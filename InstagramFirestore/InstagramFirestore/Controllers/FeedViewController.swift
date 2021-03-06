//
//  FeedViewController.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/7/21.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedViewController: UICollectionViewController {
    //MARK: - Lifecycle
    private var posts = [Post]() {
        didSet { collectionView.reloadData() }
    }

    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchPosts()
    }

    //MARK: - Helpers
    func configureUI() {
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        if post == nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        }

        navigationItem.title = "Feed"

        let referesher = UIRefreshControl()
        referesher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = referesher
    }

    //MARK: - Actions
    @objc func handleRefresh() {
        posts.removeAll()
        fetchPosts()
    }

    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true, completion: nil)
        } catch {
            print("DEBUG: Failed to sign out")
        }
    }

    //MARK: - API
    func fetchPosts() {
        guard post == nil else { return }

        PostService.fetchPosts { posts in
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.checkIfUserLikedPosts()

            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }

    func checkIfUserLikedPosts() {
        posts.forEach { post in
            PostService.checkIfUserLikedPost(post: post) { didLike in
                if let index = self.posts.firstIndex(where: { $0.postId == post.postId }) {
                    self.posts[index].didLike = didLike
                }
            }
        }

    }
}

//MARK: - UICollectionView DataSource
extension FeedViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post != nil ? 1 : posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell

        cell.delegate = self

        if let post = post {
            cell.viewModel = PostViewModel(post: post)

        } else {
            cell.viewModel = PostViewModel(post: posts[indexPath.row])
        }

        return cell
    }
}


//MARK: - UICollectionViewDelegateFlowLayout
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 9 + 40 + 8
        height += 110
        return CGSize(width: width, height: height)
    }
}

extension FeedViewController: FeedCellDelegate {
    func cell(_ cell: FeedCell, wantsToShowProfileFor uid: String) {
        let controller = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.otherUserProfileID = uid
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func cell(_ cell: FeedCell, wantsToShowCommentsFor post: Post) {
        let controller = CommentViewController(post: post)
        navigationController?.pushViewController(controller, animated: true)
    }

    func cell(_ cell: FeedCell, didLike post: Post) {
        cell.viewModel?.post.didLike.toggle()
        
        if post.didLike {
            PostService.unlikePost(post: post) { _ in
                cell.likeButton.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
                cell.likeButton.tintColor = .black
                cell.viewModel?.post.likes = post.likes - 1
            }
        } else {
            PostService.likePost(post: post) { _ in
                cell.likeButton.setImage(#imageLiteral(resourceName: "like_selected"), for: .normal)
                cell.likeButton.tintColor = .red
                cell.viewModel?.post.likes = post.likes + 1
                
                UserService.fetchUser { user in
                    NotificationService.uploadNotification(toUid: post.ownerUid, fromUser: user, type: .like, post: post)
                }
            }
        }
    }

}
