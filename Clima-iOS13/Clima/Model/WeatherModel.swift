//
//  WeatherModel.swift
//  Clima
//
//  Created by Heang Ly on 6/16/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String{
        String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        getConditionName(weatherId: conditionId)
    }

    private func getConditionName(weatherId: Int) -> String {
        switch weatherId {
        case 200...232, 801...804:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
}
