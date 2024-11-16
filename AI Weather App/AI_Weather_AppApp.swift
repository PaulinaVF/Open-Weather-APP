//
//  AI_Weather_AppApp.swift
//  AI Weather App
//
//  Created by Paulina Vara on 13/11/24.
//

import SwiftUI
import SwiftData

@main
struct AI_Weather_AppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            WeatherPersistentData.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            WAHomeView()
        }
        .modelContainer(sharedModelContainer)
    }
}
