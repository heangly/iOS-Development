//
//  ProfileViewController.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/7/21.
//

import UIKit

private let cellIdentifer = "ProfileCell"
private let headerIdentifier = "ProfileHeader"

class ProfileViewController: UICollectionViewController {
    var user: User?
    private var posts = [Post]()

    var otherUserProfileId: String? {
        didSet { fetchUserWithId() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUser()
        fetchPosts()
    }

    //MARK: - Helpers
    func configureUI() {
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifer)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }

    //MARK: - API
    func fetchUserStats(uid: String) {
        UserService.fetchUserStats(uid: uid) { (stats) in
            self.user?.stats = stats
            self.collectionView.reloadData()
        }
    }

    func fetchUser() {
        UserService.fetchUser { (user) in
            self.user = user
            self.navigationItem.title = user.username
            self.fetchUserStats(uid: user.uid)
            self.collectionView.reloadData()
        }
    }

    func fetchUserWithId() {
        UserService.fetchUserWithId(id: otherUserProfileId) { (user) in
            self.user = user
            self.navigationItem.title = user.username
            self.checkIfUserIsFollowed(uid: user.uid)
            self.fetchUserStats(uid: user.uid)

        }
    }

    func fetchPosts() {
        if let id = otherUserProfileId {
            UserService.fetchUserWithId(id: id) { user in
                PostService.fetchPosts(forUser: user.uid) { posts in
                    self.posts = posts
                    self.collectionView.reloadData()
                }
            }
        } else {
            UserService.fetchUser() { user in
                PostService.fetchPosts(forUser: user.uid) { posts in
                    self.posts = posts
                    self.collectionView.reloadData()
                }
            }
        }
    }

    func checkIfUserIsFollowed(uid: String) {
        UserService.checkIfUserIsFollowed(uid: uid) { (isFollowed) in
            self.user?.isFollowed = isFollowed
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

// UICollectionView Datasource
extension ProfileViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifer, for: indexPath) as! ProfileCell
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader

        if let user = user {
            header.viewModel = ProfileHeaderViewModel(user: user)
        }

        header.delegate = self
        return header
    }

}

//MARK: - UICollectionView Delegate
extension ProfileViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = FeedViewController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.post = posts[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - UIcollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}

//MARK: - ProfileHeaderDelegate
extension ProfileViewController: ProfileHeaderDelegate {
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User) {
        if user.isCurrentUser {
            print("DEBUG: show edit profile here")
        } else if user.isFollowed {
            UserService.unfollow(uid: user.uid) { (error) in
                self.user?.isFollowed = false
                self.collectionView.reloadData()
                self.fetchUserStats(uid: user.uid)
            }
        } else {
            UserService.follow(uid: user.uid) { (error) in
                self.user?.isFollowed = true
                self.collectionView.reloadData()
                self.fetchUserStats(uid: user.uid)
            }
        }
    }


}
