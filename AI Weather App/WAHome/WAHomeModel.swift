//
//  WAHomeModel.swift
//  AI Weather App
//
//  Created by Paulina Vara on 14/11/24.
//

import Foundation
import SwiftUI

/// Struct that holds the weather details to display in a WAHomeView list row
struct WeatherListItem: Identifiable {
    let id = UUID()
    let label: String
    let icon: String
    let content: String
    let tintColor: Color
}

/// Struct that holds all the formatted data to display in WAHomeView
struct WAHomeModel {
    let location: String
    let today: String
    let temperature: String
    let weatherDescription: String
    let latitude: Double
    let longitude: Double
    let isDarkOutside: Bool
    let weatherIconName: String
}
