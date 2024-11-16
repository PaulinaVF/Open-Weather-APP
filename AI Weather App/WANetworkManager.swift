//
//  WANetworkManager.swift
//  AI Weather App
//
//  Created by Paulina Vara on 15/11/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}

    func fetchWeatherData(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "https://open-weather13.p.rapidapi.com/city/\(city)/EN"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("d1cfea8ae3mshf78eee6d574f1dap16edf6jsn5cff068dee68", forHTTPHeaderField: "x-rapidapi-key")
        request.setValue("open-weather13.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                completion(.success(weatherData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}
