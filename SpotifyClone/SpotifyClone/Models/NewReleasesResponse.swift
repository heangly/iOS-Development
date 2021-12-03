//
//  NewReleasesResponse.swift
//  SpotifyClone
//
//  Created by Heang Ly on 9/28/21.
//

import Foundation

struct ImageURL: Codable {
    let url: String
}




struct Album: Codable {
    let album_type: String
    let available_markets: [String]
    let id: String
    let images: [APIImage]
    let name: String
    let release_date: String
    let total_tracks: Int
    let artists: [Artist]
}

struct AlbumsResponse: Codable {
    let items: [Album]
}

struct NewReleasesResponse: Codable {
    let albums: AlbumsResponse
}
