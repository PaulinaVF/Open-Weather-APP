//
//  WAClimateHistoryViewModelTests.swift
//  AI Weather AppTests
//
//  Created by Paulina Vara on 16/11/24.
//

import SwiftData
import XCTest
@testable import AI_Weather_App

final class WAClimateHistoryViewModelTests: XCTestCase {
    var viewModel: WAClimateHistoryViewModel!
    var mockContext: ModelContext!

    @MainActor
    override func setUp() {
        super.setUp()
        let modelContainer = try! ModelContainer(for: WeatherPersistentData.self)
        mockContext = modelContainer.mainContext
        viewModel = WAClimateHistoryViewModel(context: mockContext)
    }

    override func tearDown() {
        viewModel = nil
        mockContext = nil
        super.tearDown()
    }

    func testFetchWeatherHistory_WhenDataExists_ShouldPopulateWeatherData() {
        // Insertar datos ficticios en el contexto
        let testData = WeatherPersistentData(
            formattedDate: "Nov 15 2024 16:20",
            temperature: "45°",
            weatherDescription: "Clear Sky",
            minMaxTemperature: "43°-50°",
            location: "Mexico",
            wind: "10.2 mph",
            humidity: "39%"
        )
        mockContext.insert(testData)
        try? mockContext.save()

        // Ejecutar la función
        viewModel.fetchWeatherHistory()

        // Validar que el ViewModel tenga los datos
        XCTAssertEqual(viewModel.weatherData.count, 1)
        XCTAssertEqual(viewModel.weatherData.first?.location, "Mexico")
    }

    func testDeleteWeatherHistory_ShouldClearAllData() {
        // Insertar datos ficticios
        let testData = WeatherPersistentData(
            formattedDate: "Nov 15 2024 16:20",
            temperature: "45°",
            weatherDescription: "Clear Sky",
            minMaxTemperature: "43°-50°",
            location: "Mexico",
            wind: "10.2 mph",
            humidity: "39%"
        )
        mockContext.insert(testData)
        try? mockContext.save()

        // Llamar a la función
        viewModel.deleteWeatherHistory()

        // Validar que no haya datos
        XCTAssertEqual(viewModel.weatherData.count, 0)
    }
}
