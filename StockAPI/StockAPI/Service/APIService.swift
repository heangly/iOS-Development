//
//  APIService.swift
//  StockAPI
//
//  Created by Heang Ly on 10/18/21.
//

import Foundation
import Combine

enum APIServiceError: Error {
    case encoding
    case badRequest
}

struct APIService {
    var API_KEY: String {
        return api_key.randomElement() ?? ""
    }

    let api_key = [APIKey.KEY_1, APIKey.KEY_2, APIKey.KEY_3]

    func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResults, Error> {
        // if the keyword has space, it will have error, so we add this line
        guard let keywords = keywords.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return Fail(error: APIServiceError.encoding).eraseToAnyPublisher() }

        guard let urlString = URL(string: "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(API_KEY)") else { return Fail(error: APIServiceError.badRequest).eraseToAnyPublisher() }

        return URLSession.shared.dataTaskPublisher(for: urlString)
            .map { $0.data }.decode(type: SearchResults.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    func fetchTimeSeriesMonthlyAdjustedPublisher(keywords: String) -> AnyPublisher<TimeseriesMonthlyAdjusted, Error> {
        // if the keyword has space, it will have error, so we add this line
        guard let keywords = keywords.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return Fail(error: APIServiceError.encoding).eraseToAnyPublisher() }

        guard let urlString = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=\(keywords)&apikey=\(API_KEY)") else { return Fail(error: APIServiceError.badRequest).eraseToAnyPublisher() }

        return URLSession.shared.dataTaskPublisher(for: urlString)
            .map { $0.data }.decode(type: TimeseriesMonthlyAdjusted.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()

    }
}
