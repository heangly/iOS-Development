//
//  PostViewModal.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/23/21.
//

import Foundation

struct PostViewModel {
    var post: Post

    var imageUrl: URL? { return URL(string: post.imageUrl) }

    var userProfileImageUrl: URL? { return URL(string: post.ownerImageUrl) }

    var username: String { return post.ownerUsername }

    var caption: String { return post.caption; }

    var likes: Int { return post.likes }

    var likesLabelText: String {
        return post.likes < 2 ? "\(post.likes) like" : "\(post.likes) likes"
    }

    init(post: Post) {
        self.post = post
    }
}
