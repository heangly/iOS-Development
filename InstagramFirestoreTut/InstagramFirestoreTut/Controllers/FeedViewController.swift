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
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

    }

    func configureUI() {
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reusableCell)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        title = "Feed"
    }

    //MARK: - Actions
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
}

//MARK: - UICollectionViewController Datasource
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCell, for: indexPath) as! FeedCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 9 + 40 + 8
        height += 110
        return CGSize(width: width, height: height)
    }



}
