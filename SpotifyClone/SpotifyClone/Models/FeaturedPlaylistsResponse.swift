//
//  FeaturedPlaylistsResponse.swift
//  SpotifyClone
//
//  Created by Heang Ly on 9/28/21.
//

import Foundation

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}

struct FeaturedPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}
