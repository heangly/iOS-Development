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
    private var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchPosts()
    }

    //MARK: - Helpers
    func configureUI() {
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.title = "Feed"
    }

    //MARK: - Actions
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
    func fetchPosts(){
        PostService.fetchPosts { posts in
            self.posts = posts
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
}


//MARK: - UICollectionView DataSource
extension FeedViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
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
