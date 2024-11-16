//
//  WAClimateHistoryViewModel.swift
//  AI Weather App
//
//  Created by Paulina Vara on 15/11/24.
//

import Foundation
import SwiftData

class WAClimateHistoryViewModel: ObservableObject {
    @Published var weatherData: [WeatherPersistentData] = []
    private var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
        fetchWeatherHistory()
    }
    
    func fetchWeatherHistory() {
        let request = FetchDescriptor<WeatherPersistentData>()
        do {
            weatherData = try context.fetch(request)
        } catch {
            print("Failed to fetch weather data: \(error)")
        }
    }
    
    func deleteWeatherHistory() {
        do {
            let request = FetchDescriptor<WeatherPersistentData>()
            let allData = try context.fetch(request)
            for item in allData {
                context.delete(item)
            }
            try context.save()
            weatherData = []
        } catch {
            print("Failed to delete weather data: \(error)")
        }
    }
    
    func deleteWeatherRecord(at offsets: IndexSet) {
        offsets.forEach { index in
            let record = weatherData[index]
            context.delete(record)
        }
        do {
            try context.save()
            weatherData.remove(atOffsets: offsets)
        } catch {
            print("Failed to delete weather record: \(error)")
        }
    }
}
