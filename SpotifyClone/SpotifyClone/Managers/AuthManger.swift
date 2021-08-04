//
//  AuthManger.swift
//  SpotifyClone
//
//  Created by Heang Ly on 8/4/21.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()

    private init() { }

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

}
