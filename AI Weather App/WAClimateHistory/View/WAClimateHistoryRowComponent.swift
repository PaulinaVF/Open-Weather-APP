//
//  WAClimateHistoryRowComponent.swift
//  AI Weather App
//
//  Created by Paulina Vara on 15/11/24.
//

import SwiftUI
import SwiftData

struct WAClimateHistoryRowComponent: View {
    var weatherData: WeatherPersistentData
    
    var body: some View {
        HStack(spacing: 20) {
            WAClimateHistoryWeatherSquareComponent(temperature: weatherData.temperature, weatherDescription: weatherData.weatherDescription)
            VStack(alignment: .leading, spacing: 0) {
                Text(weatherData.location)
                    .font(.system(size: 18, weight: .bold))
                Text(weatherData.formattedDate)
                    .font(.system(size: 18, weight: .light))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                Spacer().frame(height: 5)
                Text("Min-max temp: \(weatherData.minMaxTemperature)")
                    .font(.system(size: 16, weight: .light))
                Text("Wind: \(weatherData.wind)")
                    .font(.system(size: 16, weight: .light))
                Text("Humidity: \(weatherData.humidity)")
                    .font(.system(size: 16, weight: .light))
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    let container = try! ModelContainer(for: WeatherPersistentData.self)

    let exampleWeatherData = WeatherPersistentData(
        formattedDate: "Nov 15 2024 16:20",
        temperature: "45°",
        weatherDescription: "Clear Sky",
        minMaxTemperature: "43°-50°",
        location: "Mexico",
        wind: "10.2 mph",
        humidity: "34%"
    )

    //container.mainContext.insert(exampleWeatherData)

    return List {
        WAClimateHistoryRowComponent(weatherData: exampleWeatherData)
            .modelContainer(container)
    }
}
