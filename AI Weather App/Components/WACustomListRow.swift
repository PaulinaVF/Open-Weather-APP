//
//  WACustomListRow.swift
//  AI Weather App
//
//  Created by Paulina Vara on 13/11/24.
//

import SwiftUI

struct WACustomListRow: View {
    @State public var rowLabel: String
    @State public var rowIcon: String
    @State public var rowContent: String
    @State public var rowTintColor: Color
    
    var body: some View {
        LabeledContent {
            Text(rowContent)
                .fontWeight(.light)
        } label: {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 30, height: 30)
                        .foregroundStyle(rowTintColor)
                        .fontWeight(.light)
                    Image(systemName: rowIcon)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
                Text(rowLabel)
            }
            .padding(.vertical, 5)
        }
    }
}

#Preview {
    List {
        WACustomListRow(rowLabel: "Feels like", rowIcon: "hand.point.up.left", rowContent: "40°", rowTintColor: .customYellowIconBackground)
            .listRowBackground(Color.listBackground)
    }
    
}
