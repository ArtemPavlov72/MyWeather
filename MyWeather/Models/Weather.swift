//
//  Weather.swift
//  MyWeather
//
//  Created by Artem Pavlov on 11.12.2022.
//

import Foundation

struct Weather {
    let location: CityLocationData
    let current: CityWeatherData
}

struct CityLocationData {
    let name: String
    let country: String
    let lat: Double
    let lon: Double
    let localtime: String
}

struct CityWeatherData {
    let temp_c: Double
    let condition: Condition
    let wind_kph: Double
    let humidity: Int
    let feelslike_c: Double
    let uv: Int
}

struct Condition {
    let text: String
    let icon: String
}
