//
//  WAHomeWeatherComponent.swift
//  AI Weather App
//
//  Created by Paulina Vara on 14/11/24.
//

import SwiftUI

struct WAHomeWeatherComponent: View {
    var temperature: String
    var weatherDescription: String
    var weatherIconName: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("\(temperature)")
                    .font(.system(size: 80, weight: .black))
                    .foregroundStyle(.white)
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)
                Text(weatherDescription)
                    .font(.system(size: 28, weight: .light))
                    .foregroundStyle(.white)
            }
            Spacer().frame(minWidth: 20)
            Image(systemName: weatherIconName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 300)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    ZStack {
        Color.teal.ignoresSafeArea()
        WAHomeWeatherComponent(temperature: "20°", weatherDescription: "Sunny", weatherIconName: "cloud.sun.fill")
            .padding(35)
    }
}
