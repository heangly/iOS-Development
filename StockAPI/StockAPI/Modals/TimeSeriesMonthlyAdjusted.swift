//
//  TimeSeriesMonthlyAdjusted.swift
//  StockAPI
//
//  Created by Heang Ly on 10/21/21.
//

import Foundation


struct TimeseriesMonthlyAdjusted: Codable {
    let meta: Meta
    let timeSeries: [String: OHLC]
}

struct Meta: Codable {
    let symbol: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "2. Symbol"
    }
}

struct OHLC: Codable {
    let open: String
    let close: String
    let adjustedClose: String
    
    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case close = "4. close"
        case adjustedClose = "5. adjusted close"
    }
}

