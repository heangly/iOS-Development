//
//  ProfileViewController.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/7/21.
//

import UIKit

private let cellIdentifier = "ProfileCell"
private let headerIdeentifier = "ProfileHeader"

class ProfileViewController: UICollectionViewController {
    //MARK: - Properties
    var user: User? {
        didSet { collectionView.reloadData() }
    }

    var otherUserProfileID: String? {
        didSet { fetchOtherUserProfile() }
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUser()
    }

    //MARK: - Helpers
    func configureUI() {
        collectionView.backgroundColor = .white
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdeentifier)
    }

    //MARK: - API
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
            self.navigationItem.title = user.username
        }
    }

    func fetchOtherUserProfile() {
        guard let id = otherUserProfileID else { return }
        UserService.fetchUserWithID(id) { (user) in
            self.user = user
            self.navigationItem.title = user.username
        }
    }
}

//MARK: - UICollectionViewDataSource
extension ProfileViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProfileCell
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdeentifier, for: indexPath) as! ProfileHeader

        if let user = user {
            header.viewModel = ProfileHeaderViewModel(user: user)
        }

        header.delegate = self

        return header
    }
}

//MARK: - UICollectionViewDelegate
// This is for selecting item in the collection
extension ProfileViewController {

}


//MARK: - UICollectionViewDelegateFlowLayout
// This is where you determine all the sizing
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
            print("DEBUG: show edit profile here...")
        } else if user.isFollowed {
            print("DEBUG: handle unfollow user here")
        } else {
            UserService.follow(uid: user.uid) { (error) in
                print("DEBUG: Did follow user. Update UI now...")
            }
        }
    }


}
