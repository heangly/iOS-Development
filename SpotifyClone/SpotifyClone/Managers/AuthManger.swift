//
//  AuthManger.swift
//  SpotifyClone
//
//  Created by Heang Ly on 8/4/21.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()

    struct Constants {
        static let clientID = "d83b9980ddca450c976fb6e4be9969f6"
    }

    private init() { }

    public var signInURL: URL? {
        let scopes = "user-read-private"
        let redirectURI = "https://www.iosacademy.io"
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }

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

    public func exchangeCodeForToken(code: String, completion: @escaping (Bool) -> Void) {

    }

    public func refreshAccessToken() {

    }

    private func cacheToken() {

    }

}
