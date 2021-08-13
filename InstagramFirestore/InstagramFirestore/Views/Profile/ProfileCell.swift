//
//  ProfileCell.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/13/21.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    //MARK: - Properties
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
