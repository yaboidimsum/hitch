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
    var userLocation: CLLocationCoordinate2D?
    var currentLocationAddress: String?
    var route: MKRoute?
    var routeDistance: Double?
    var isCalculatingRoute = false
    let pointA = CLLocationCoordinate2D(latitude: -6.2088, longitude: 106.8456)
    var pointB = CLLocationCoordinate2D(latitude: -6.1751, longitude: 106.8650)
    var destinationName: String?
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
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
    
    func reverseGeocode(_ coordinate: CLLocationCoordinate2D?) async {
        guard let coordinate else {
            currentLocationAddress = nil
            return
        }
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                currentLocationAddress = [
                    placemark.subThoroughfare,
                    placemark.thoroughfare,
                    placemark.locality,
                    placemark.country
                ].compactMap { $0 }.joined(separator: ", ")
            }
        } catch {
            currentLocationAddress = "Unknown location"
        }
    }

    func calculateRouteAB() async {
        await calculateRoute(from: pointA, to: pointB)
    }

    func calculateRouteFromUser(using locationService: LocationService, to destination: CLLocationCoordinate2D? = nil) async {
        guard let userLocation = locationService.userLocation else { return }
        let dest = destination ?? pointB
        pointB = dest
        await calculateRoute(from: userLocation, to: dest)
    }

    func geocodeAddress(_ address: String) async -> CLLocationCoordinate2D? {
        do {
            let placemarks = try await geocoder.geocodeAddressString(address)
            return placemarks.first?.location?.coordinate
        } catch {
            return nil
        }
    }

    private func calculateRoute(from sourceCoordinate: CLLocationCoordinate2D, to destinationCoordinate: CLLocationCoordinate2D) async {
        isCalculatingRoute = true
        defer { isCalculatingRoute = false }

        let source = MKMapItem(
            location: CLLocation(latitude: sourceCoordinate.latitude, longitude: sourceCoordinate.longitude),
            address: nil
        )
        let destination = MKMapItem(
            location: CLLocation(latitude: destinationCoordinate.latitude, longitude: destinationCoordinate.longitude),
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
    
    func resetDestination() {
        clearRoute()
        pointB = CLLocationCoordinate2D(latitude: -6.1751, longitude: 106.8650)
        destinationName = nil
    }
}
