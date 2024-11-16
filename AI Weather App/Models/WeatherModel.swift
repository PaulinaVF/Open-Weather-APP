//
//  WeatherModel.swift
//  AI Weather App
//
//  Created by Paulina Vara on 13/11/24.
//

import Foundation

/// Data model that holds all the weather and location info
struct WeatherData: Codable {
    let coord: Coordinates
    let weather: [Weather]
    let main: MainWeather
    let wind: Wind
    let sys: System
    let name: String
    let timezone: Int
    let dt: Int
}

/// Data model that holds the coordinates of the location
struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}

/// Data model that holds specific weather info
struct Weather: Codable {
    let main: String
    let description: String
    let icon: String
}

/// Data model that holds details of temperature and humidity
struct MainWeather: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

/// Data model that holds wind details
struct Wind: Codable {
    let speed: Double
    let deg: Int
}

/// Data model that holds sunrise and sunset time
struct System: Codable {
    let sunrise: Int
    let sunset: Int
}
