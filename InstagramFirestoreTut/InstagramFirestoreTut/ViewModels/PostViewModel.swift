//
//  PostViewModel.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/23/21.
//

import Foundation

struct PostViewModel {
    private let post: Post
    var imageUrl: URL? { return URL(string: post.imageUrl) }
    var caption: String { return post.caption }
    var likes: Int { return post.likes }
    var userProfileImageUrl: URL? { return URL(string: post.ownerImageUrl) }
    var username: String { return post.ownerUsername }

    var likesLabelText: String { return post.likes < 2 ? "\(post.likes) like" : "\(post.likes) likes" }

    init(post: Post) {
        self.post = post
    }
}
