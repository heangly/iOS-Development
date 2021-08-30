//
//  PostViewModel.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/23/21.
//

import UIKit

struct PostViewModel {
    var post: Post
    var imageUrl: URL? { return URL(string: post.imageUrl) }
    var caption: String { return post.caption }
    var likes: Int { return post.likes }
    var userProfileImageUrl: URL? { return URL(string: post.ownerImageUrl) }
    var username: String { return post.ownerUsername }

    var likesLabelText: String { return post.likes < 2 ? "\(post.likes) like" : "\(post.likes) likes" }

    var likeButtonTintCollor: UIColor { return post.didLike ? .red : .black }

    var likeButtonImage: UIImage? {
        return post.didLike ? UIImage(named: "like_selected") : UIImage(named: "like_unselected")
    }

    init(post: Post) {
        self.post = post
    }
}
