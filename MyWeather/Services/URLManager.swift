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
        let url = "https://api.weatherapi.com/v1\(Links.forecast.rawValue)?key=\(Keys.apiKey.rawValue)&q=\(city)&days=\(days)&aqi=no&alerts=no"
        return url
    }
}





