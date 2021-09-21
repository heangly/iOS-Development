//
//  User.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/21/21.
//

import Foundation

struct User {
    let email: String
    let username: String
    let fullname: String
    let profileImageUrl: String
    let uid: String

    init(dictionary: [String: String], uid: String) {
        email = dictionary["email"] ?? ""
        username = dictionary["username"] ?? ""
        fullname = dictionary["fullname"] ?? ""
        profileImageUrl = dictionary["profileImageUrl"] ?? ""
        self.uid = uid
    }
}
