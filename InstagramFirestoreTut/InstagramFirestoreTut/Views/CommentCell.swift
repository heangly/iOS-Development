//
//  CommentCell.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/25/21.
//

import UIKit

class CommentCell: UICollectionViewCell {
    static let reusuableIdentifier = "Comment Cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    func configureCell(){
        backgroundColor = .red
    }
}
