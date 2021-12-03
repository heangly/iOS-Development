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
    var profileImageUrl: URL?
    let uid: String

    init(dictionary: [String: String], uid: String) {
        email = dictionary["email"] ?? ""
        username = dictionary["username"] ?? ""
        fullname = dictionary["fullname"] ?? ""
        self.uid = uid
        
        if let profileImageUrl = dictionary["profileImageUrl"] {
            guard let profileImageUrl = URL(string: profileImageUrl) else { return }
            self.profileImageUrl = profileImageUrl
        }
       
    }
}
