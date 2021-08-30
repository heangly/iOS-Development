//
//  FeedViewController.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/7/21.
//

import UIKit
import Firebase

private let reusableCell = "Cell"

class FeedViewController: UICollectionViewController {

    var post: Post?

    private var posts = [Post]() {
        didSet { collectionView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchPosts()
    }

    func configureUI() {
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reusableCell)

        if post == nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        }

        navigationController?.title = "Feed"

        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }

    //MARK: - Actions
    @objc func handleRefresh() {
        posts.removeAll()
        fetchPosts()
    }

    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
            let nav = UINavigationController(rootViewController: LoginViewController())
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true, completion: nil)
        } catch {
            print("Failed to sign user out \(error.localizedDescription)")
        }
    }

    //MARK: - API
    func fetchPosts() {
        guard post == nil else { return }
        PostService.fetchPost { posts in
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.checkIfUserLikedPosts()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
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

//MARK: - UICollectionViewController Datasource
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post != nil ? 1 : posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCell, for: indexPath) as! FeedCell
        cell.delegate = self

        if let post = post {
            cell.viewModel = PostViewModel(post: post)
        } else {
            cell.viewModel = PostViewModel(post: posts[indexPath.row])
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 9 + 40 + 8
        height += 110
        return CGSize(width: width, height: height)
    }
}

//MARK: - FeedCell Delegate
extension FeedViewController: FeedCellDelegate {
    func cell(_ cell: FeedCell, wantsToShowProfileFor uid: String) {
        let controller = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.otherUserProfileId = uid
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
            }
        }
    }
}
