//
//  Weather.swift
//  MyWeather
//
//  Created by Artem Pavlov on 11.12.2022.
//

import Foundation

struct Weather: Decodable, Hashable {
    let location: CityLocationData
    let current: CityWeatherData
    let forecast: Forecast
}

struct CityLocationData: Decodable, Hashable {
    let name: String
    let country: String
    let lat: Double
    let lon: Double
    let localtime: String
}

struct CityWeatherData: Decodable, Hashable {
    let temp_c: Int
    let condition: Condition
    let wind_kph: Double
    let humidity: Int
    let feelslike_c: Double
    let uv: Int
}

struct Condition: Decodable, Hashable {
    let text: String
    let icon: String
}

struct Forecast: Decodable, Hashable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Decodable, Hashable {
    let date: String
    let day: DayForecastDetails
    let astro: Astro
    let hour: [Hour]
}

struct DayForecastDetails: Decodable, Hashable {
    let maxtemp_c: String
    let mintemp_c: String
    let daily_chance_of_rain: Int
    let daily_chance_of_snow: Int
    let condition: Condition
}

struct Astro: Decodable, Hashable {
    let sunrise: String
    let sunset: String
}

struct Hour: Decodable, Hashable {
    let time: String
    let temp_c: String
    let condition: Condition
}
