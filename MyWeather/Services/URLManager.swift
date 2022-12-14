//
//  Constants.swift
//  MyWeather
//
//  Created by Artem Pavlov on 10.12.2022.
//

import Foundation

class URLManager {
    static let shared = URLManager()
    
    private init() {}
    
    func getWeatherURL(forCity city: String, forNumberOfDays days: Int) -> String {
        let url = "https://api.weatherapi.com/v1\(Links.currentWeather.rawValue)?key=\(Keys.apiKey.rawValue)&q=\(city)&days=\(days)&aqi=no&alerts=no"
        return url
    }
}

extension URLManager {
    enum Links: String {
        case baseURL = "http://api.weatherapi.com/v1"
        case currentWeather = "/current.json"
        case forecast = "/forecast.json"
        case historyWeather = "/history.json"
    }
    
    enum Keys: String {
        case apiKey = "1574ca7511704252b03180557221012"
    }
}



