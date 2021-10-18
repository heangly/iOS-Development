//
//  SearchResult.swift
//  StockAPI
//
//  Created by Heang Ly on 10/18/21.
//

import Foundation

struct SearchResult: Decodable {
    let symbol: String
    let name: String
    let type: String
    let currency: String

    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case currency = "8. currency"
    }
}

struct SearchResults: Decodable {
    let items: [SearchResult]

    enum CodingKeys: String, CodingKey {
        case items = "bestMatches"
    }
}
