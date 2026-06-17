import SwiftUI
import MapKit

struct ContentView: View {
    @Environment(AppStore.self) var store
    @Environment(\.colorScheme) private var colorScheme
    @State private var showHitchSheet = true
    @State private var selectedDetent: PresentationDetent = .fraction(0.15)
    @State private var model = MapModel()
    @State private var path = NavigationPath()
    @State private var sheetContent: SheetContent = .hitch
    @State private var selectedDestination: Place? = nil
    
    private var showHitchSheetBinding: Binding<Bool> {
        Binding(
            get: { showHitchSheet && path.isEmpty },
            set: { showHitchSheet = $0 }
        )
    }
    
    private var routeColor: Color {
        colorScheme == .dark ? Color(red: 0.12, green: 0.59, blue: 0.33) : Color(red: 0.00, green: 0.24, blue: 0.20)
    }
    
    private var userLocationKey: String {
        guard let loc = store.locationService.userLocation else { return "nil" }
        return "\(loc.latitude),\(loc.longitude)"
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .topLeading) {
                Map(position: $model.position) {
                    UserAnnotation()
//                    Marker("Point A", coordinate: model.pointA)
                    Marker(model.destinationName ?? "Point B", coordinate: model.pointB)
                    
                    if let route = model.route {
                        MapPolyline(route)
                            .stroke(routeColor, lineWidth: 8)
                    }
                }
                .mapStyle(.standard)
                .mapControls {
                    MapUserLocationButton()
                    MapCompass()
                }
                .onMapCameraChange { context in
                    let center = context.region.center
                    let maxDistance = 0.2 // degrees
                    if abs(center.latitude - (-6.2088)) > maxDistance ||
                        abs(center.longitude - 106.8456) > maxDistance {
                        Task { model.snapToCity() }
                    }
                }
                
                WeatherActivity()
                    .padding(.top, -52)
                    .padding(.leading, 16)
                DriverButton {
                    withAnimation {
                        sheetContent = sheetContent == .hitch ? .request : .hitch
                    }
                }
                .padding(.top, 80)
                .padding(.leading, 342)

                VStack(spacing: 8) {
                    HStack(spacing: 8) {
                        Button("Route A→B") {
                            Task { await model.calculateRouteAB() }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.greenBrand)

                        Button("Route User→B") {
                            Task { await model.calculateRouteFromUser(using: store.locationService) }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.blue)

                        Button("Clear") {
                            model.clearRoute()
                        }
                        .buttonStyle(.bordered)
                    }

                    if let distance = model.routeDistance {
                        let km = distance / 1000
                        let price = (km * 7000 / 1000).rounded() * 1000
                        Text("Distance: \(km, format: .number.precision(.fractionLength(2))) km | Price: Rp\(price, format: .number.precision(.fractionLength(0)))")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.greenBrand)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(.thinMaterial)
                            .clipShape(.rect(cornerRadius: 8))
                    }

                    if model.isCalculatingRoute {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                }
                .padding(.bottom, 120)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button("notifications", systemImage: "bell", action: {
                            path.append("notification")
                        })
                        Button("receipt", systemImage: "receipt", action: {
                            path.append("history")
                        })
                        Button("history", systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90", action: {
                            path.append("activity")
                        })
                        Button("debug", systemImage: "ladybug", action: {
                            path.append("debugmap")
                        })
                        .foregroundStyle(.red)
                    }
                }
            }
            .navigationDestination(for: String.self) { value in
                if value == "activity" {
                    Activity()
                } else if value == "notification" {
                    Notification()
                } else if value == "history" {
                    History()
                } else if value == "debugmap" {
                    MapDebugView()
                }
            }
            .sheet(isPresented: showHitchSheetBinding) {
                switch sheetContent {
                case .hitch:
                    HitchSheet(
                        selectedDetent: $selectedDetent,
                        onSearchTapped: {
                            withAnimation {
                                sheetContent = .search
                            }
                        }
                    )
                    .presentationDetents(
                        [.fraction(0.10), .medium, .large],
                        selection: $selectedDetent
                    )
                    .interactiveDismissDisabled()
                    .presentationBackgroundInteraction(.enabled)
                    
                case .request:
                    if let pendingRide = store.pendingRides.first {
                        HitchRequestContainer(
                            state: .incoming(pendingRide),
                            currentUserID: store.currentUser.id
                        ) {
                            withAnimation {
                                sheetContent = .hitch
                            }
                        }
                        .presentationDetents(
                            [.fraction(0.10), .medium, .large],
                            selection: $selectedDetent
                        )
                        .interactiveDismissDisabled()
                        .presentationBackgroundInteraction(.enabled)
                    }
                    
                case .search:
                    SearchFlow(
                        sheetContent: $sheetContent,
                        routeDistance: $model.routeDistance,
                        onDestinationSelected: { place in
                            selectedDestination = place
                        },
                        onReset: {
                            model.resetDestination()
                            selectedDestination = nil
                        }
                    )
                    .presentationDetents([.medium, .large])
                    .interactiveDismissDisabled()
                    .presentationBackgroundInteraction(.enabled)
                }
            }
            .onAppear {
                store.locationService.startTracking()
            }
            .onChange(of: path.isEmpty) { _, isEmpty in
                if isEmpty {
                    showHitchSheet = true
                }
            }
            .onChange(of: userLocationKey) { _, _ in
                Task {
                    await model.reverseGeocode(store.locationService.userLocation)
                }
            }
            .onChange(of: selectedDestination) { _, newPlace in
                guard let place = newPlace else { return }
                model.destinationName = place.name
                Task {
                    if let coord = place.coordinate {
                        await model.calculateRouteFromUser(
                            using: store.locationService,
                            to: coord
                        )
                    } else {
                        if let coord = await model.geocodeAddress(place.address) {
                            await model.calculateRouteFromUser(
                                using: store.locationService,
                                to: coord
                            )
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(AppStore.mock())
}
