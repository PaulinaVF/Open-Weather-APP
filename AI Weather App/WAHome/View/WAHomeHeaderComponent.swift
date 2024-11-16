//
//  WAHomeHeaderComponent.swift
//  AI Weather App
//
//  Created by Paulina Vara on 14/11/24.
//

import SwiftUI

struct WAHomeHeaderComponent: View {
    var location: String
    var formattedDate: String
    var latitude: Double
    var longitude: Double
    var cities: [String]
    var onReload: () -> Void
    var onChangeCity: (String) -> Void

    @State private var showMap = false
    @State private var showCityOptions = false
    @State private var cityName: String?
    
    init(location: String, formattedDate: String, latitude: Double, longitude: Double, cities: [String], onReload: @escaping () -> Void, onChangeCity: @escaping (String) -> Void, showMap: Bool = false, showCityOptions: Bool = false) {
        self.location = location
        self.formattedDate = formattedDate
        self.latitude = latitude
        self.longitude = longitude
        self.cities = cities
        self.onReload = onReload
        self.onChangeCity = onChangeCity
        self.showMap = showMap
        self.showCityOptions = showCityOptions
        self.cityName = location
    }
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(cityName ?? location)
                            .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)
                        Button {
                            showCityOptions.toggle()
                        } label: {
                            Image(systemName: "chevron.down")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .padding(7)
                                .foregroundStyle(Color.white)
                        }
                        .sheet(isPresented: $showCityOptions) {
                            VStack {
                                Text("Select a city")
                                    .font(.headline)
                                    .padding()
                                List(cities, id: \.self) { city in
                                    Button(action: {
                                        cityName = city
                                        onChangeCity(city)
                                        showCityOptions = false
                                    }) {
                                        Text(city)
                                            .foregroundColor(.primary)
                                    }
                                }
                                .listStyle(.plain)
                            }
                            .padding()
                            .presentationDragIndicator(.visible)
                        }
                    }
                    Text(formattedDate)
                        .font(.system(size: 20, weight: .light))
                        .foregroundStyle(.white)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                }
                Spacer()
                HStack(spacing: 25) {
                    WACustomCircleButton(systemSymbol: "mappin.and.ellipse") {
                        showMap.toggle()
                    }
                    .fullScreenCover(isPresented: $showMap) {
                        WAMapCoordinatesView(viewModel: WAMapCoordinatesViewModel(latitude: latitude, longitude: longitude, location: location))
                    }
                    WACustomCircleButton(systemSymbol: "arrow.counterclockwise") {
                        onReload()
                    }
                }
                .padding(.leading, 25)
            }
        }
    }
}


#Preview {
    ZStack {
        Color.teal.ignoresSafeArea()
        WAHomeHeaderComponent(location: "Puebla", formattedDate: "Jan 16 2020, 08:25 am", latitude: 37.7749, longitude: -122.4194, cities: ["Landon", "Rome", "Cancun", "Bogota", "Madrid", "Ottawa"], onReload: {
            print("Reload")
        }, onChangeCity: { city in
            print("New city: \(city)")
        })
        .padding(35)
    }
}
