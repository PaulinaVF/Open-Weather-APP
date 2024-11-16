//
//  WAHomeDetailsListComponent.swift
//  AI Weather App
//
//  Created by Paulina Vara on 14/11/24.
//

import SwiftUI

struct WAHomeDetailsListComponent: View {
    var listData: [WeatherListItem]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(listData, id: \.id) { data in
                WACustomListRow(
                    rowLabel: data.label,
                    rowIcon: data.icon,
                    rowContent: data.content,
                    rowTintColor: data.tintColor
                )
                .listRowBackground(Color.listBackground)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
            }
        }
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.listBackground)
        )
    }
}

#Preview {
    ZStack {
        Color.teal.ignoresSafeArea()
        WAHomeDetailsListComponent(listData: [
            WeatherListItem(
                label: "Feels like",
                icon: "hand.point.up.left",
                content: "20°",
                tintColor: .customYellowIconBackground
            ),
            WeatherListItem(
                label: "Min Temperature",
                icon: "dial.low",
                content: "10°",
                tintColor: .customLightBlueIconBackground
        )])
        .padding(35)
    }
}
