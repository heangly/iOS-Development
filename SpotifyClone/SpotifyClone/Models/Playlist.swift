//
//  Playlist.swift
//  SpotifyClone
//
//  Created by Heang Ly on 9/25/21.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
