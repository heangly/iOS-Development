//
//  AuthManager.swift
//  SpotifyClone
//
//  Created by Heang Ly on 9/25/21.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()

    var isSignedIn: Bool {
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

    private init() { }

}
