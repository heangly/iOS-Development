//
//  AuthManager.swift
//  SpotifyCloneProgrammaticallyUI
//
//  Created by Heang Ly on 8/5/21.
//

import Foundation

final class AuthManger {
    static let shared = AuthManger()
    
    private init(){}
    
    var inSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var expirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
}
