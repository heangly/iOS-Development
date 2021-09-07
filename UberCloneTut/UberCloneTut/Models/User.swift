//
//  User.swift
//  UberCloneTut
//
//  Created by Heang Ly on 9/7/21.
//

struct User {
    let fullname: String
    let email: String
    let accountType: Int

    init(dictionary: [String: Any]) {
        self.fullname = dictionary["fulllname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.accountType = dictionary["accountType"] as? Int ?? 0
    }
}
