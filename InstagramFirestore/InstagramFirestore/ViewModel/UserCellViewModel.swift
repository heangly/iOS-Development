//
//  UserCellViewModel.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/1/21.
//

import Foundation

struct UserCellViewModel {
    let user: User
    var profileImageUrl: URL? { return URL(string: user.profileImageUrl) }
    var username: String { return user.username }
    var fullName: String { return user.fullName }
}
