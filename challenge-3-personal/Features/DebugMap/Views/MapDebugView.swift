//
//  MapDebugView.swift
//  challenge-3-personal
//

import MapKit
import SwiftUI

struct MapDebugView: View {
    @State private var model = MapDebugModel()
    @Environment(\.colorScheme) private var colorScheme
    
    private var routeColor: Color {
        colorScheme == .dark ? Color(red: 0.12, green: 0.59, blue: 0.33) : Color(red: 0.00, green: 0.24, blue: 0.20)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $model.position, interactionModes: .all) {
                if let userLocation = model.userLocation {
                    Marker("You", coordinate: userLocation)
                }
                
                Marker("Point A", coordinate: model.pointA)
                Marker("Point B", coordinate: model.pointB)
                
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
                
                HStack(spacing: 12) {
                    Button("Route A→B") {
                        Task {
                            await model.calculateRoute()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.greenBrand)
                    
                    Button("Clear") {
                        model.clearRoute()
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Center User") {
                        model.centerOnUser()
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
            model.startTrackingLocation()
        }
        .onDisappear {
            model.stopTrackingLocation()
        }
    }
}

struct DebugInfoCard: View {
    let model: MapDebugModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Debug Info")
                .font(.headline)
                .bold()
                .foregroundStyle(.greenBrand)
            
            Group {
                if let userLocation = model.userLocation {
                    Text("User: \(userLocation.latitude.formatted(.number.precision(.fractionLength(6)))), \(userLocation.longitude.formatted(.number.precision(.fractionLength(6))))")
                } else {
                    Text("User: —")
                }
                
                Text("Point A: \(model.pointA.latitude.formatted(.number.precision(.fractionLength(6)))), \(model.pointA.longitude.formatted(.number.precision(.fractionLength(6))))")
                
                Text("Point B: \(model.pointB.latitude.formatted(.number.precision(.fractionLength(6)))), \(model.pointB.longitude.formatted(.number.precision(.fractionLength(6))))")
                
                if let distance = model.routeDistance {
                    let km = distance / 1000
                    let price = (km * 7000 / 1000).rounded() * 1000
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Route: \(km, format: .number.precision(.fractionLength(2))) km")
                        Text("Price: Rp\(price, format: .number.precision(.fractionLength(0))) (Rp7000/km)")
                    }
                    .foregroundStyle(.greenBrand)
                    .bold()
                } else {
                    Text("Route: —")
                    Text("Price: Rp7000/km")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Text("Auth: \(String(describing: model.authorizationStatus))")
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
}
