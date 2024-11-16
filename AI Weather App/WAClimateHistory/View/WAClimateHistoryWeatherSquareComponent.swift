//
//  WAClimateHistoryWeatherSquareComponent.swift
//  AI Weather App
//
//  Created by Paulina Vara on 15/11/24.
//

import SwiftUI

struct WAClimateHistoryWeatherSquareComponent: View {
    var temperature: String
    var weatherDescription: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(
                    LinearGradient(colors: [.dayLightBlueColor, .dayDarkBlueColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            VStack(alignment: .center) {
                Text(temperature)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.white)
                    .minimumScaleFactor(0.5)
                Text(weatherDescription)
                    .font(.system(size: 18, weight: .light))
                    .foregroundStyle(.white)
                    .minimumScaleFactor(0.5)
            }
            .padding(15)
        }
        .frame(
            width: 90,
            height: 90
        )
    }
}

#Preview {
    WAClimateHistoryWeatherSquareComponent(temperature: "45°", weatherDescription: "Clear Sky")
}
