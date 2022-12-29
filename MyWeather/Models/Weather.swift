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
    let pressure_mb: Double
    let vis_km: Double
    let precip_mm: Double
    let humidity: Int
    let feelslike_c: Double
    let gust_kph: Double
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
    let maxtemp_c: Double
    let mintemp_c: Double
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
    let temp_c: Double
    let condition: Condition
}

struct DaySpec: Hashable {
    let description: String
    let value: String
}

enum WeatherSpecs: String, Hashable, CaseIterable {
    case sunrise = "SUNRISE"
    case sunset = "SUNSET"
    case humidity = "HUMIDITY"
    case feelsLike = "FELLS LIKE"
    case preciption = "PRECIPTION"
    case pressure = "PRESSURE"
    case visibility = "VISIBILITY"
    case uvIndex = "UV INDEX"
    
    //извлечь безопасно
    static func getInfo(for specs: WeatherSpecs, from weather: Weather) -> String {
        switch specs {
        case .sunrise:
            return "\(String(describing: weather.forecast.forecastday.first!.astro.sunrise))"
        case .sunset:
            return weather.forecast.forecastday.first!.astro.sunset
        case .humidity:
            return "\(String(describing: weather.current.humidity))%"
        case .feelsLike:
            return "\(String(format:"%.0f", weather.current.feelslike_c))°"
        case .preciption:
            return "\(String(format:"%.0f", weather.current.precip_mm)) mm"
        case .pressure:
            return "\(String(format:"%.0f", weather.current.pressure_mb)) hPa"
        case .visibility:
            return "\(weather.current.vis_km) km"
        case .uvIndex:
            return "\(weather.current.uv)"
        }
    }
}

enum Links: String {
    case baseURL = "http://api.weatherapi.com/v1"
    case currentWeather = "/current.json"
    case forecast = "/forecast.json"
    case historyWeather = "/history.json"
}

enum Keys: String {
    case apiKey = "1574ca7511704252b03180557221012"
}


