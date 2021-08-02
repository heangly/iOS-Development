//
//  User.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 7/30/21.
//

import Foundation
import Firebase

struct User {
    let email: String
    let fullName: String
    let profileImageUrl: String
    let username: String
    let uid: String

    var isFollowed = false
    var stats: UserStats!
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }

    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullName = dictionary["fullname"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        
        self.stats = UserStats(followers: 0, following: 0)
    }
}

struct UserStats {
    let followers: Int
    let following: Int
//    let posts: Int
    
}
