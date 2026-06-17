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
    var route: MKRoute?
    var routeDistance: Double?
    var isCalculatingRoute = false
    var currentUserPlaceName: String?
    var searchQuery: String = ""
    var isSearching = false
    var searchResultName: String?
    
    private let geocoder = CLGeocoder()

    let pointA = CLLocationCoordinate2D(latitude: -6.2088, longitude: 106.8456)
    var pointB = CLLocationCoordinate2D(latitude: -6.1751, longitude: 106.8650)

    private let regionSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)

    init() {
        position = .region(
            MKCoordinateRegion(
                center: pointA,
                span: regionSpan
            )
        )
    }

    func centerOnUser(using locationService: LocationService) {
        guard let userLocation = locationService.userLocation else { return }
        withAnimation(.smooth(duration: 0.5)) {
            position = .region(
                MKCoordinateRegion(
                    center: userLocation,
                    span: regionSpan
                )
            )
        }
    }

    func calculateRouteAB() async {
        await calculateRoute(from: pointA, to: pointB)
    }

    func calculateRouteFromUser(using locationService: LocationService) async {
        guard let userLocation = locationService.userLocation else { return }
        await calculateRoute(from: userLocation, to: pointB)
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
    
    func reverseGeocodeUserLocation(using locationService: LocationService) async {
        guard let coordinate = locationService.userLocation else {
            currentUserPlaceName = nil
            return
        }
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                currentUserPlaceName = [
                    placemark.subThoroughfare,
                    placemark.thoroughfare,
                    placemark.locality,
                    placemark.country
                ].compactMap { $0 }.joined(separator: ", ")
            }
        } catch {
            currentUserPlaceName = "Unknown location"
        }
    }
    
    func searchForDestination() async {
        guard !searchQuery.isEmpty else { return }
        isSearching = true
        defer { isSearching = false }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchQuery
        request.region = MKCoordinateRegion(
            center: pointA,
            latitudinalMeters: 50000,
            longitudinalMeters: 50000
        )
        
        do {
            let search = MKLocalSearch(request: request)
            let response = try await search.start()
            if let item = response.mapItems.first {
                let coordinate = item.placemark.coordinate
                pointB = coordinate
                searchResultName = item.name
                withAnimation(.smooth(duration: 0.5)) {
                    position = .region(
                        MKCoordinateRegion(
                            center: coordinate,
                            span: regionSpan
                        )
                    )
                }
            }
        } catch {
            searchResultName = nil
        }
    }
}
