//
//  WACustomCircleButton.swift
//  AI Weather App
//
//  Created by Paulina Vara on 13/11/24.
//

import SwiftUI

struct WACustomCircleButton: View {
    var systemSymbol: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: systemSymbol)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(7)
                .background(Color.black.opacity(0.3)) // Cambiar el color de fondo
                .clipShape(Circle()) // Forma circular
                .frame(width: 28, height: 28) // Tamaño del botón
                .foregroundStyle(Color.white)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ZStack {
        Color.teal.ignoresSafeArea()
        WACustomCircleButton(systemSymbol: "mappin.and.ellipse") {
            print("button pressed")
        }
    }
}
