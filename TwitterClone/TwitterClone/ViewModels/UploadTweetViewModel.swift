//
//  UploadTweetViewModel.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/22/21.
//

import UIKit

struct UploadTweetViewModel {
    private let view: UploadTweetView

    var profileImageUrl: URL? {
        didSet {
            guard let profileImageUrl = profileImageUrl else { return }
            view.configureProfileImageView(imageURL: profileImageUrl)
        }
    }

    init(view: UploadTweetView) {
        self.view = view
    }
}
