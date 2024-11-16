//
//  ContentView.swift
//  AI Weather App
//
//  Created by Paulina Vara on 13/11/24.
//

import SwiftUI
import SwiftData

import SwiftUI
import SwiftData

struct WAHomeView: View {
    @Environment(\.modelContext) var modelContext
    @StateObject private var viewModel = WAHomeViewModel()
    @State private var isShowingSheet = false
    
    var body: some View {
        ZStack {
            if viewModel.weatherHomeModel?.isDarkOutside ?? false {
                LinearGradient(colors: [.nightDarkBlueColor, .nightLightBlueColor], startPoint: .topLeading, endPoint: .bottom)
                    .ignoresSafeArea()
            } else {
                LinearGradient(colors: [.dayDarkBlueColor, .dayLightBlueColor], startPoint: .topLeading, endPoint: .bottom)
                    .ignoresSafeArea()
            }
            
            
            ScrollView {
                VStack(spacing: 0) {
                    WAHomeHeaderComponent(
                        location: viewModel.weatherHomeModel?.location ?? "-",
                        formattedDate: viewModel.weatherHomeModel?.today ?? "-",
                        latitude: viewModel.weatherHomeModel?.latitude ?? 0,
                        longitude: viewModel.weatherHomeModel?.longitude ?? 0, 
                        cities: viewModel.citiesList,
                        onReload: {
                            viewModel.getWeatherData()
                        }, onChangeCity: { city in
                            viewModel.updateCityList(cityPicked: city)
                            viewModel.getWeatherData(for: city)
                        }
                    )
                    Spacer().frame(height: 60)
                    WAHomeWeatherComponent(
                        temperature: viewModel.weatherHomeModel?.temperature ?? "-",
                        weatherDescription: viewModel.weatherHomeModel?.weatherDescription ?? "-", 
                        weatherIconName: viewModel.weatherHomeModel?.weatherIconName ?? "cloud.sun"
                    )
                    Spacer().frame(height: 60)
                    WAHomeDetailsListComponent(
                        listData: viewModel.listData
                    )
                    Spacer().frame(height: 30)
                    WARoundedRectangleTransparentButton(buttonTitle: "History") {
                        isShowingSheet.toggle()
                    }
                    .sheet(isPresented: $isShowingSheet) {
                        WAClimateHistoryView(context: modelContext)
                            .presentationDragIndicator(.visible)
                            .presentationDetents([.medium, .large])
                    }
                }
                .padding(35)
            }
            if viewModel.isLoading {
                Color.black.opacity(0.4)
                .ignoresSafeArea()
                .overlay {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding()
                        .cornerRadius(10)
                        .foregroundStyle(.white)
                        .font(.system(size: 23, weight: .light))
                }
            }
        }
        .onAppear {
            viewModel.updateContext(context: self.modelContext)
            viewModel.getWeatherData()
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: WeatherPersistentData.self)
    return WAHomeView()
            .modelContainer(container)
}
