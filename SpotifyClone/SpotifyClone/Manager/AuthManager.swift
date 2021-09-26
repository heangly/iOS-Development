//
//  AuthManager.swift
//  SpotifyClone
//
//  Created by Heang Ly on 9/25/21.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()

    struct Constants {
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static let redirectURI = "https://www.iosacademy.io"
        static let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
    }

    var isSignedIn: Bool {
        return accessToken != nil
    }

    var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize"
        let scopes = Constants.scopes
        let string = "\(base)?response_type=code&client_id=\(SPOTIFY_SECRET_KEY.CLIENT_ID.rawValue)&scope=\(scopes)&redirect_uri=\(Constants.redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }

    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }

    private var refreshedToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }

    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }

    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else { return false }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }

    func exchangeCodeForToken(code: String, completion: @escaping(Bool) -> Void) {
        guard let url = URL(string: Constants.tokenAPIURL) else { return }

        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = "\(SPOTIFY_SECRET_KEY.CLIENT_ID.rawValue):\(SPOTIFY_SECRET_KEY.CLIENT_SECRET.rawValue)"
        let data = basicToken.data(using: .utf8)

        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get bbase 64")
            completion(false)
            return
        }

        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }

            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result: result)
                print("Success:", result)
                completion(true)
            } catch {
                print("ERROR:", error.localizedDescription)
                completion(false)
            }
        }

        task.resume()
    }

    func refreshIfNeedded(completion: @escaping (Bool) -> Void) {
//        guard shouldRefreshToken else {
//            completion(true)
//            return
//        }

        guard let refreshToken = self.refreshedToken else { return }

        guard let url = URL(string: Constants.tokenAPIURL) else { return }

        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken),
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = "\(SPOTIFY_SECRET_KEY.CLIENT_ID.rawValue):\(SPOTIFY_SECRET_KEY.CLIENT_SECRET.rawValue)"
        let data = basicToken.data(using: .utf8)

        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get bbase 64")
            completion(false)
            return
        }

        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }

            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result: result)
                print("Successfully refresh")
                completion(true)
            } catch {
                print("ERROR:", error.localizedDescription)
                completion(false)
            }
        }

        task.resume()
    }

    func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        if let refresh_token = result.refresh_token {
            UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
        }

        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }

    private init() { }

}
