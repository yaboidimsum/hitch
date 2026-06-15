//
//  MapDebugModel.swift
//  challenge-3-personal
//

import MapKit
import SwiftUI

@MainActor
@Observable
final class MapDebugModel {
    var position: MapCameraPosition
    var userLocation: CLLocationCoordinate2D?
    var route: MKRoute?
    var routeDistance: Double?
    var isCalculatingRoute = false
    var authorizationStatus: CLAuthorizationStatus = .notDetermined

    let pointA = CLLocationCoordinate2D(latitude: -6.2088, longitude: 106.8456)
    let pointB = CLLocationCoordinate2D(latitude: -6.1751, longitude: 106.8650)

    private let manager = CLLocationManager()
    private let regionSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    private let locationDelegate: LocationDelegate

    init() {
        position = .region(
            MKCoordinateRegion(
                center: pointA,
                span: regionSpan
            )
        )
        locationDelegate = LocationDelegate()
        locationDelegate.onLocationUpdate = { [weak self] coordinate in
            Task { @MainActor in
                self?.userLocation = coordinate
            }
        }
        locationDelegate.onAuthorizationChange = { [weak self] status in
            Task { @MainActor in
                self?.authorizationStatus = status
                #if os(iOS)
                if status == .authorizedWhenInUse || status == .authorizedAlways {
                    self?.manager.startUpdatingLocation()
                }
                #else
                if status == .authorizedAlways {
                    self?.manager.startUpdatingLocation()
                }
                #endif
            }
        }
        manager.delegate = locationDelegate
        requestAuthorization()
    }

    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }

    func startTrackingLocation() {
        manager.startUpdatingLocation()
    }

    func stopTrackingLocation() {
        manager.stopUpdatingLocation()
    }

    func centerOnUser() {
        guard let userLocation else { return }
        withAnimation(.smooth(duration: 0.5)) {
            position = .region(
                MKCoordinateRegion(
                    center: userLocation,
                    span: regionSpan
                )
            )
        }
    }

    func calculateRoute() async {
        isCalculatingRoute = true
        defer { isCalculatingRoute = false }

        let source = MKMapItem(
            location: CLLocation(latitude: pointA.latitude, longitude: pointA.longitude),
            address: nil
        )
        let destination = MKMapItem(
            location: CLLocation(latitude: pointB.latitude, longitude: pointB.longitude),
            address: nil
        )

        let request = MKDirections.Request()
        request.source = source
        request.destination = destination
        request.transportType = .automobile

        do {
            let directions = MKDirections(request: request)
            let response = try await directions.calculate()
            route = response.routes.first
            routeDistance = route?.distance
        } catch {
            route = nil
            routeDistance = nil
        }
    }

    func clearRoute() {
        route = nil
        routeDistance = nil
    }
}

final class LocationDelegate: NSObject, CLLocationManagerDelegate {
    var onLocationUpdate: ((CLLocationCoordinate2D) -> Void)?
    var onAuthorizationChange: ((CLAuthorizationStatus) -> Void)?

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        onLocationUpdate?(location.coordinate)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        onAuthorizationChange?(status)
    }
}
