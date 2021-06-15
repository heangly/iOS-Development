//
//  WeatherManager.swift
//  Clima
//
//  Created by Heang Ly on 6/15/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation


struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=97acd4846c591df762b1d82f3e1b5323&units=metric"

    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
}

