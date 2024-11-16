//
//  WARoundedRectangleTransparentButton.swift
//  AI Weather App
//
//  Created by Paulina Vara on 14/11/24.
//

import SwiftUI

struct WARoundedRectangleTransparentButton: View {
    let buttonTitle: String
    var action: () -> Void
    var opacity: Double = 0.15
    var shouldAdjustToDarkMode: Bool = false
    
    @GestureState private var isPressing = false
    
    init(buttonTitle: String, opacity: Double = 0.15, shouldAdjustToDarkMode: Bool = false, action: @escaping () -> Void) {
        self.buttonTitle = buttonTitle
        self.action = action
        self.opacity = opacity
        self.shouldAdjustToDarkMode = shouldAdjustToDarkMode
    }
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(buttonTitle)
                .font(.system(size: 18, weight: .light))
                .foregroundColor(.white)
                .padding(.horizontal, 35)
                .padding(.vertical, 18)
                .background((shouldAdjustToDarkMode ? Color.customButtonBackgroundColor : Color.black).opacity(opacity))
                .cornerRadius(15)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ZStack {
        Color.teal.ignoresSafeArea()
        WARoundedRectangleTransparentButton(buttonTitle: "Button") {
            print("Button pressed")
        }
    }
}
