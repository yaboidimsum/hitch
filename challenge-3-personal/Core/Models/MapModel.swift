//
//  MapModel.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 12/06/26.
//

import MapKit
import SwiftUI
import Observation

@MainActor
@Observable
final class MapModel {
    private let cityCenter = CLLocationCoordinate2D(latitude: -6.2088, longitude: 106.8456)
    private let citySpan = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
    
    var position: MapCameraPosition
    
    init() {
        position = .region(
            MKCoordinateRegion(
                center: cityCenter,
                span: citySpan
            )
        )
    }
    
    func snapToCity() {
        withAnimation(.smooth(duration: 0.5)) {
            position = .region(
                MKCoordinateRegion(
                    center: cityCenter,
                    span: citySpan
                )
            )
        }
    }
}
