//
//  WeatherUtilitiesTests.swift
//  AI Weather AppTests
//
//  Created by Paulina Vara on 16/11/24.
//

import XCTest
@testable import AI_Weather_App

final class WAHomeViewModelTests: XCTestCase {
    var viewModel: WAHomeViewModel!
        
    override func setUp() {
        super.setUp()
        // Inicializa el viewModel antes de cada test
        viewModel = WAHomeViewModel()
    }
    
    override func tearDown() {
        // Libera recursos después de cada test
        viewModel = nil
        super.tearDown()
    }
    
    func testHandleWeatherSuccess_ShouldUpdateWeatherHomeModel() {
        let mockWeatherData = WeatherData(coord: Coordinates(lon: -99.1332, lat: 19.4326), weather: [Weather(main: "Clear", description: "clear sky", icon: "cloud")], main: MainWeather(temp: 25.0, feelsLike: 27.0, tempMin: 22.0, tempMax: 28.0, humidity: 60), wind: Wind(speed: 9.0, deg: 45), sys: System(sunrise: 1699911600, sunset: 1699954800), name: "Mexico", timezone: -21600, dt: 1699958400)

        viewModel.handleWeatherSuccess(mockWeatherData)
        
        XCTAssertEqual(viewModel.weatherHomeModel?.location, "Mexico")
        XCTAssertEqual(viewModel.weatherHomeModel?.temperature, "25°")
        XCTAssertEqual(viewModel.weatherHomeModel?.weatherDescription, "Clear Sky")
    }
    
    func testCalculateIsDarkOutside_ShouldReturnFalse_WhenWithinSunriseAndSunset() {
        let sunrise = 6 * 60 * 60 // 6:00 AM
        let sunset = 18 * 60 * 60 // 6:00 PM
        let currentTime = 12 * 60 * 60 // 12:00 PM

        let result = viewModel.calculateIsDarkOutside(currentTime: currentTime, sunrise: sunrise, sunset: sunset)
        
        XCTAssertFalse(result)
    }

    func testCalculateIsDarkOutside_ShouldReturnTrue_WhenOutsideSunriseAndSunset() {
        let sunrise = 6 * 60 * 60 // 6:00 AM
        let sunset = 18 * 60 * 60 // 6:00 PM
        let currentTime = 22 * 60 * 60 // 10:00 PM

        let result = viewModel.calculateIsDarkOutside(currentTime: currentTime, sunrise: sunrise, sunset: sunset)
        
        XCTAssertTrue(result)
    }
    
    func testDetermineWeatherIconName() {
        // Test para clima soleado durante el día
        XCTAssertEqual(viewModel.determineWeatherIconName(main: "Clear Sky", isDarkOutside: false), "sun.max")
        
        // Test para clima soleado durante la noche
        XCTAssertEqual(viewModel.determineWeatherIconName(main: "Clear Sky", isDarkOutside: true), "moon")
        
        // Test para lluvia
        XCTAssertEqual(viewModel.determineWeatherIconName(main: "Slight Rain", isDarkOutside: false), "cloud.rain")
        
        // Test para tormenta
        XCTAssertEqual(viewModel.determineWeatherIconName(main: "Storm", isDarkOutside: false), "cloud.bolt.rain")
        
        // Test para nieve
        XCTAssertEqual(viewModel.determineWeatherIconName(main: "Snow", isDarkOutside: false), "snowflake")
    }
}
