//
//  WAClimateHistoryView.swift
//  AI Weather App
//
//  Created by Paulina Vara on 15/11/24.
//

import SwiftUI
import SwiftData

struct WAClimateHistoryView: View {
    private var context: ModelContext
    @StateObject private var viewModel: WAClimateHistoryViewModel
    @State private var showDeleteConfirmation = false

    init(context: ModelContext) {
        self.context = context
        _viewModel = StateObject(wrappedValue: WAClimateHistoryViewModel(context: context))
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color.listBackground.ignoresSafeArea()
            VStack(spacing: 15) {
                Image(systemName: "clock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(Color.gray)
                Text("Weather History")
                    .font(.system(size: 22, weight: .light))
                    .foregroundStyle(Color.gray)
                if viewModel.weatherData.isEmpty {
                    Text("No weather history available.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(viewModel.weatherData, id: \.self) { item in
                            WAClimateHistoryRowComponent(weatherData: item)
                        }
                        .onDelete(perform: viewModel.deleteWeatherRecord(at:))
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                    WARoundedRectangleTransparentButton(buttonTitle: "Delete History", opacity: 0.8, shouldAdjustToDarkMode: true) {
                        showDeleteConfirmation = true
                    }
                }
            }
            .padding(.init(top: 30, leading: 10, bottom: 15, trailing: 10))
        }
        .alert("Are you sure you want to delete all history?", isPresented: $showDeleteConfirmation) {
            Button("Delete", role: .destructive) {
                viewModel.deleteWeatherHistory()
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

// Previsualización
#Preview {
    let container = try! ModelContainer(for: WeatherPersistentData.self)

    let previewData = [
        WeatherPersistentData(
            formattedDate: "Nov 15 2024 16:20",
            temperature: "45°",
            weatherDescription: "Clear Sky",
            minMaxTemperature: "43°-50°",
            location: "Mexico",
            wind: "10.2 mph",
            humidity: "39%"
        )
    ]

    let context = container.mainContext
    
    let fetchDescriptor = FetchDescriptor<WeatherPersistentData>()
    
    let existingData = try? context.fetch(fetchDescriptor)

    if existingData?.isEmpty ?? true {
        previewData.forEach { context.insert($0) }
    }
    
    return WAClimateHistoryView(context: context)
}
