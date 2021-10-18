//
//  APIService.swift
//  StockAPI
//
//  Created by Heang Ly on 10/18/21.
//

import Foundation
import Combine

struct APIService {
    var API_KEY: String {
        return api_key.randomElement() ?? ""
    }

    let api_key = [APIKey.KEY_1, APIKey.KEY_2, APIKey.KEY_3]

    func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResults, Error> {
        let urlString = URL(string: "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(API_KEY)")!
        return URLSession.shared.dataTaskPublisher(for: urlString)
            .map { $0.data }.decode(type: SearchResults.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
