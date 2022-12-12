//
//  Constants.swift
//  MyWeather
//
//  Created by Artem Pavlov on 10.12.2022.
//

import Foundation

struct WeatherUrls {
    let searchCityURL = "http://api.weatherapi.com/v1/current.json?key=\(Keys.apiKey.rawValue)&q="
}

enum Keys: String {
    case apiKey = "1574ca7511704252b03180557221012"
}
