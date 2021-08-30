//
//  PostViewModal.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/23/21.
//

import UIKit

struct PostViewModel {
    var post: Post

    var imageUrl: URL? { return URL(string: post.imageUrl) }

    var userProfileImageUrl: URL? { return URL(string: post.ownerImageUrl) }

    var username: String { return post.ownerUsername }

    var caption: String { return post.caption; }

    var likes: Int { return post.likes }

    var likeButtonTintColor: UIColor { return post.didLike ? .red : .black }

    var likeButtonImage: UIImage? {
        return post.didLike ? UIImage(named: "like_selected") : UIImage(named: "like_unselected") }

    var likesLabelText: String {
        return post.likes < 2 ? "\(post.likes) like" : "\(post.likes) likes"
    }

    init(post: Post) {
        self.post = post
    }
}
