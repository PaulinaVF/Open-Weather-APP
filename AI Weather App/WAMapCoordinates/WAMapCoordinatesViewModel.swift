//
//  WAMapCoordinatesViewModel.swift
//  AI Weather App
//
//  Created by Paulina Vara on 15/11/24.
//

import SwiftUI
import MapKit

class WAMapCoordinatesViewModel: ObservableObject {
    @Published var mapPosition: MapCameraPosition
    @Published private(set) var locationPin: Location
    
    init(latitude: Double, longitude: Double, location: String) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.mapPosition = MapCameraPosition.region(
            MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.12, longitudeDelta: 0.12)
            )
        )
        self.locationPin = Location(name: location, coordinate: coordinate)
    }
}
