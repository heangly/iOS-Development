//
//  UserProfile.swift
//  SpotifyClone
//
//  Created by Heang Ly on 9/25/21.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
////    let followers: [String: Any?]
    let id: String
    let images: [UserImage]
    let product: String
}

struct UserImage: Codable {
    let url: String
}
