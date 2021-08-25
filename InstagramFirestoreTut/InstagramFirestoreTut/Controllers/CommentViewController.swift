//
//  CommentViewController.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/25/21.
//

import UIKit

class CommentViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCommentViewControllerUI()
    }
    
    //MARK: - Helpers
    func configureCommentViewControllerUI(){
        title = "Comments"
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.reusuableIdentifier)
    }
    
}

//MARK: - UICollectionView DataSource
extension CommentViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.reusuableIdentifier, for: indexPath) as! CommentCell
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CommentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
}
