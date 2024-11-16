//
//  WAMapCoordinatesModel.swift
//  AI Weather App
//
//  Created by Paulina Vara on 15/11/24.
//

import Foundation
import MapKit

/// Struct that holds the data to make map annotations
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
