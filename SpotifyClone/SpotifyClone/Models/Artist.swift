//
//  Artist.swift
//  SpotifyClone
//
//  Created by Heang Ly on 9/25/21.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
}
