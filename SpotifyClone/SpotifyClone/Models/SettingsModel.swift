//
//  SettingsModel.swift
//  SpotifyClone
//
//  Created by Heang Ly on 9/27/21.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
