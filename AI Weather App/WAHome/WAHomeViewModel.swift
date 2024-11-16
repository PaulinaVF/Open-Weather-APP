//
//  WAHomeViewModel.swift
//  AI Weather App
//
//  Created by Paulina Vara on 13/11/24.
//

import SwiftUI
import Foundation
import SwiftData

class WAHomeViewModel: ObservableObject {
    @Published var weatherHomeModel: WAHomeModel? = nil
    @Published var listData: [WeatherListItem] = []
    @Published var citiesList: [String] = []
    @Published var isLoading: Bool = false

    private var context: ModelContext?
    private var weatherData: WeatherData? = nil
    private let initialListData: [WeatherListItem] = [
        WeatherListItem(label: "Feels like", icon: "hand.point.up.left", content: "-", tintColor: .customYellowIconBackground),
        WeatherListItem(label: "Min Temperature", icon: "dial.low", content: "-", tintColor: .customLightBlueIconBackground),
        WeatherListItem(label: "Max Temperature", icon: "dial.high", content: "-", tintColor: .customRedIconBackground),
        WeatherListItem(label: "Humidity", icon: "humidity", content: "-", tintColor: .customDarkBlueIconBackground),
        WeatherListItem(label: "Wind", icon: "wind", content: "-", tintColor: .customGreenIconBackground),
        WeatherListItem(label: "Sunrise time", icon: "sunrise", content: "-", tintColor: .customOrangeIconBackground),
        WeatherListItem(label: "Sunset time", icon: "sunset", content: "-", tintColor: .customPurpleIconBackground)
    ]
    private var initialCitiesList = ["Landon", "Paris", "Cancun", "Bogota", "Madrid", "Ottawa", "Caracas", "Chicago", "Vienna", "Guadalajara", "Puebla"]
    private var currentCity = "Landon"
    
    init() {
        self.listData = initialListData
        self.citiesList = initialCitiesList
    }
    
    func updateContext(context: ModelContext) {
        self.context = context
    }
    
    func getWeatherData(for city: String? = nil) {
        isLoading = true
        NetworkManager.shared.fetchWeatherData(for: (city ?? self.currentCity).lowercased()) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let data):
                    self?.handleWeatherSuccess(data)
                case .failure(let error):
                    print("Error fetching weather: \(error)")
                }
            }
        }
    }
    
    public func handleWeatherSuccess(_ data: WeatherData) {
        self.weatherData = data
        let isDarkOutside = calculateIsDarkOutside(
            currentTime: data.dt,
            sunrise: data.sys.sunrise,
            sunset: data.sys.sunset
        )
        let weatherIconName = determineWeatherIconName(main: data.weather.first?.main ?? "", isDarkOutside: isDarkOutside)
        
        updateListData()
        updateCityList(cityPicked: data.name)
        
        weatherHomeModel = WAHomeModel(
            location: data.name,
            today: convertTimestampToTimeString(data.dt, withFullDate: true, timezoneOffset: data.timezone),
            temperature: "\(String(format: "%.0f", data.main.temp))°",
            weatherDescription: (data.weather.first?.description ?? "").capitalized,
            latitude: data.coord.lat,
            longitude: data.coord.lon,
            isDarkOutside: isDarkOutside,
            weatherIconName: weatherIconName
        )
        saveWeatherToPersistentStorage(data)
    }

    
    private func updateListData() {
        guard let weatherData else { return }
        listData = [
            WeatherListItem(label: "Feels like", icon: "hand.point.up.left", content: "\(String(format: "%.0f", weatherData.main.feelsLike))°", tintColor: .customYellowIconBackground),
            WeatherListItem(label: "Min Temperature", icon: "dial.low", content: "\(String(format: "%.0f", weatherData.main.tempMin))°", tintColor: .customLightBlueIconBackground),
            WeatherListItem(label: "Max Temperature", icon: "dial.high", content: "\(String(format: "%.0f", weatherData.main.tempMax))°", tintColor: .customRedIconBackground),
            WeatherListItem(label: "Humidity", icon: "humidity", content: "\(weatherData.main.humidity)%", tintColor: .customDarkBlueIconBackground),
            WeatherListItem(label: "Wind", icon: "wind", content: "\(String(format: "%.1f", weatherData.wind.speed)) mph, direction \(weatherData.wind.deg)°", tintColor: .customGreenIconBackground),
            WeatherListItem(label: "Sunrise time", icon: "sunrise", content: convertTimestampToTimeString(weatherData.sys.sunrise, timezoneOffset: weatherData.timezone), tintColor: .customOrangeIconBackground),
            WeatherListItem(label: "Sunset time", icon: "sunset", content: convertTimestampToTimeString(weatherData.sys.sunset, timezoneOffset: weatherData.timezone), tintColor: .customPurpleIconBackground)
        ]
    }
    
    private func convertTimestampToTimeString(_ timestamp: Int, withFullDate: Bool = false, timezoneOffset: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp + timezoneOffset))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        if withFullDate {
            dateFormatter.dateFormat = "MMM dd yyyy, hh:mm a"
        } else {
            dateFormatter.dateFormat = "hh:mm a"
        }
        return dateFormatter.string(from: date)
    }
    
    private func saveWeatherToPersistentStorage(_ weatherData: WeatherData) {
        let persistentData = WeatherPersistentData(
            formattedDate: convertTimestampToTimeString(weatherData.dt, withFullDate: true, timezoneOffset: weatherData.timezone),
            temperature: "\(String(format: "%.0f", weatherData.main.temp))°",
            weatherDescription: weatherData.weather.first?.description.capitalized ?? "",
            minMaxTemperature: "\(String(format: "%.0f", weatherData.main.tempMin))°-\(String(format: "%.0f", weatherData.main.tempMax))°",
            location: weatherData.name,
            wind: "\(String(format: "%.1f", weatherData.wind.speed)) mph",
            humidity: "\(weatherData.main.humidity)%"
        )
        context?.insert(persistentData)
        do {
            try context?.save()
            print("Weather data saved successfully!")
        } catch {
            print("Failed to save weather data: \(error)")
        }
    }
    
    public func updateCityList(cityPicked: String) {
        self.citiesList = initialCitiesList.sorted()
        self.currentCity = cityPicked.lowercased()
        if citiesList.contains(cityPicked.capitalized) {
            citiesList.removeAll(where: {$0 == cityPicked})
        }
    }
    
    public func calculateIsDarkOutside(currentTime: Int, sunrise: Int, sunset: Int) -> Bool {
        return currentTime < sunrise || currentTime > sunset
    }

    public func determineWeatherIconName(main: String, isDarkOutside: Bool) -> String {
        let lowercasedMain = main.lowercased()
        
        if lowercasedMain.contains("rain") {
            return "cloud.rain"
        } else if lowercasedMain.contains("storm") {
            return "cloud.bolt.rain"
        } else if lowercasedMain.contains("snow") {
            return "snowflake"
        } else if lowercasedMain.contains("wind") {
            return "wind"
        } else if lowercasedMain.contains("clear") {
            return isDarkOutside ? "moon" : "sun.max"
        } else if lowercasedMain.contains("cloud") {
            return "cloud"
        }
        
        return "thermometer"
    }
}
