//
//  WeatherData.swift
//  AI Weather App
//
//  Created by Paulina Vara on 15/11/24.
//

import SwiftData

@Model
class WeatherPersistentData {
    var formattedDate: String
    var temperature: String
    var weatherDescription: String
    var minMaxTemperature: String
    var location: String
    var wind: String
    var humidity: String

    init(formattedDate: String, temperature: String, weatherDescription: String, minMaxTemperature: String, location: String, wind: String, humidity: String) {
        self.formattedDate = formattedDate
        self.temperature = temperature
        self.weatherDescription = weatherDescription
        self.minMaxTemperature = minMaxTemperature
        self.location = location
        self.wind = wind
        self.humidity = humidity
    }
}
