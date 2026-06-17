//
//  MapDebugView.swift
//  challenge-3-personal
//

import MapKit
import SwiftUI

struct MapDebugView: View {
    @State private var model = MapDebugModel()
    @Environment(AppStore.self) private var store
    @Environment(\.colorScheme) private var colorScheme
    
    private var userLocationKey: String {
        guard let loc = store.locationService.userLocation else { return "nil" }
        return "\(loc.latitude),\(loc.longitude)"
    }
    
    private var routeColor: Color {
        colorScheme == .dark ? Color(red: 0.12, green: 0.59, blue: 0.33) : Color(red: 0.00, green: 0.24, blue: 0.20)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $model.position, interactionModes: .all) {
                if let userLocation = store.locationService.userLocation {
                    Marker("You", coordinate: userLocation)
                }
                
                Marker("Point A", coordinate: model.pointA)
                Marker(model.searchResultName ?? "Point B", coordinate: model.pointB)
                
                if let route = model.route {
                    MapPolyline(route)
                        .stroke(routeColor, lineWidth: 8)
                }
                
                UserAnnotation()
            }
            .mapStyle(.standard)
            .mapControls {
                MapUserLocationButton()
                MapCompass()
            }
            
            VStack(spacing: 12) {
                DebugInfoCard(model: model)
                
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
                    TextField("Search destination", text: $model.searchQuery)
                        .submitLabel(.search)
                        .onSubmit {
                            Task {
                                await model.searchForDestination()
                            }
                        }
                    if model.isSearching {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .scaleEffect(0.7)
                    }
                    if !model.searchQuery.isEmpty {
                        Button("Clear", systemImage: "xmark.circle.fill") {
                            model.searchQuery = ""
                        }
                        .labelStyle(.iconOnly)
                        .foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 12))
                
                HStack(spacing: 12) {
                    Button("Route A→B") {
                        Task {
                            await model.calculateRouteAB()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.greenBrand)

                    Button("Route User→B") {
                        Task {
                            await model.calculateRouteFromUser(using: store.locationService)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)

                    Button("Clear") {
                        model.clearRoute()
                    }
                    .buttonStyle(.bordered)

                    Button("Center User") {
                        model.centerOnUser(using: store.locationService)
                    }
                    .buttonStyle(.bordered)
                }
                
                if model.isCalculatingRoute {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            }
            .padding(16)
        }
        .onAppear {
            store.locationService.startTracking()
        }
        .onDisappear {
            store.locationService.stopTracking()
        }
        .onChange(of: userLocationKey) { _, _ in
            Task {
                await model.reverseGeocodeUserLocation(using: store.locationService)
            }
        }
    }
}

struct DebugInfoCard: View {
    let model: MapDebugModel
    @Environment(AppStore.self) private var store
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Debug Info")
                .font(.headline)
                .bold()
                .foregroundStyle(.greenBrand)
            
            Group {
                if let userLocation = store.locationService.userLocation {
                    Text("User: \(userLocation.latitude.formatted(.number.precision(.fractionLength(6)))), \(userLocation.longitude.formatted(.number.precision(.fractionLength(6))))")
                    if let placeName = model.currentUserPlaceName {
                        Text("Place: \(placeName)")
                            .foregroundStyle(.greenBrand)
                    }
                } else {
                    Text("User: —")
                }
                
                Text("Point A: \(model.pointA.latitude.formatted(.number.precision(.fractionLength(6)))), \(model.pointA.longitude.formatted(.number.precision(.fractionLength(6))))")
                
                if let resultName = model.searchResultName {
                    Text("Point B: \(resultName)")
                        .foregroundStyle(.greenBrand)
                    Text("\(model.pointB.latitude.formatted(.number.precision(.fractionLength(6)))), \(model.pointB.longitude.formatted(.number.precision(.fractionLength(6))))")
                        .foregroundStyle(.secondary)
                } else {
                    Text("Point B: \(model.pointB.latitude.formatted(.number.precision(.fractionLength(6)))), \(model.pointB.longitude.formatted(.number.precision(.fractionLength(6))))")
                }
                
                if let distance = model.routeDistance {
                    let km = distance / 1000
                    let price = (km * 7000 / 1000).rounded() * 1000
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Distance: \(km, format: .number.precision(.fractionLength(2))) km")
                        Text("Price: Rp\(price, format: .number.precision(.fractionLength(0)))")
                        Text("Rate: Rp7,000/km")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .foregroundStyle(.greenBrand)
                    .bold()
                } else {
                    Text("Route: —")
                    Text("Rate: Rp7,000/km")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Text("Auth: \(String(describing: store.locationService.authorizationStatus))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .font(.caption)
            .foregroundStyle(.primary)
        }
        .padding(12)
        .background(.thinMaterial)
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    MapDebugView()
        .environment(AppStore.mock())
}
