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
        let result = parseQuery(text: keywords)
        var symbol = String()

        switch result {
        case .success(let query):
            symbol = query
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }

        let urlResult = parseURL(urlString: "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(symbol)&apikey=\(API_KEY)")

        switch urlResult {
        case .success(let url):
            return URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }.decode(type: SearchResults.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }

    func fetchTimeSeriesMonthlyAdjustedPublisher(keywords: String) -> AnyPublisher<TimeseriesMonthlyAdjusted, Error> {
        let result = parseQuery(text: keywords)
        var symbol = String()

        switch result {
        case .success(let query):
            symbol = query
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }

        let urlResult = parseURL(urlString: "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=\(symbol)&apikey=\(API_KEY)")

        switch urlResult {
        case .success(let url):
            return URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }.decode(type: TimeseriesMonthlyAdjusted.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }

    private func parseQuery(text: String) -> Result<String, Error> {
        // if the keyword has space, it will have error, so we add this line
        if let query = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            return .success(query)
        } else {
            return .failure(APIServiceError.encoding)
        }
    }

    private func parseURL(urlString: String) -> Result<URL, Error> {
        if let url = URL(string: urlString) {
            return .success(url)
        } else {
            return .failure(APIServiceError.badRequest)
        }
    }
}
