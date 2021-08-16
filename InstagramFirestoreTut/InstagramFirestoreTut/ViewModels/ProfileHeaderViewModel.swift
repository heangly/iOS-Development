//
//  ProfileHeadderViewModel.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/15/21.
//

import Foundation

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    init(user: User) {
        self.user = user
    }
}
