//
//  WAMapCoordinatesView.swift
//  AI Weather App
//
//  Created by Paulina Vara on 15/11/24.
//

import SwiftUI
import MapKit

struct WAMapCoordinatesView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: WAMapCoordinatesViewModel

    var body: some View {
        ZStack(alignment: .topLeading) {
            Map(position: $viewModel.mapPosition) {
                Marker(viewModel.locationPin.name, coordinate: viewModel.locationPin.coordinate)
            }
            .mapStyle(.standard(elevation: .realistic))
            .mapControls {
                MapCompass()
                MapScaleView()
            }
            .ignoresSafeArea()

            // Back button in the top left corner
            WACustomCircleButton(systemSymbol: "arrow.backward") {
                dismiss()
            }
            .padding(.leading, 35)
            .padding(.top, 15)
        }
    }
}


#Preview {
    WAMapCoordinatesView(viewModel: WAMapCoordinatesViewModel(latitude: 37.7749, longitude: -122.4194, location: "San Francisco"))
}
