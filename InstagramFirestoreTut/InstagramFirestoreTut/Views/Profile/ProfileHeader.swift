//
//  ProfileHeader.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/13/21.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
