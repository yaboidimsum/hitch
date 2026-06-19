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
    @State private var hasInitialCentered = false
    
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
                    if (model.destinationName != nil){
                        Marker(model.destinationName ?? "Point B", coordinate: model.pointB)
                    }
                    
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
                
//                WeatherActivity()
//                    .padding(.top, 20)
//                    .padding(.leading, 16)
//                DriverButton {
//                    withAnimation {
//                        sheetContent = sheetContent == .hitch ? .request : .hitch
//                    }
//                }
//                .padding(.top, 80)
//                .padding(.leading, 342)

            }
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    HStack {
//                        Button("notifications", systemImage: "bell", action: {
//                            path.append("notification")
//                        })
//                        Button("receipt", systemImage: "receipt", action: {
//                            path.append("history")
//                        })
//                        Button("history", systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90", action: {
//                            path.append("history")
//                        })
//                        Button("debug", systemImage: "ladybug", action: {
//                            path.append("debugmap")
//                        })
//                        .foregroundStyle(.red)
//                    }
//                }
//            }
//            .navigationDestination(for: String.self) { value in
//                if value == "activity" {
//                    Activity()
//                } else if value == "notification" {
//                    Notification()
//                } else if value == "history" {
//                    History()
//                } else if value == "debugmap" {
//                    MapDebugView()
//                }
//            }
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
                        [.fraction(0.10),.fraction(0.40)],
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
                    .presentationDetents([.fraction(0.40), .large])
                    .interactiveDismissDisabled()
                    .presentationBackgroundInteraction(.enabled)
                }
            }
            .onAppear {
                store.locationService.startTracking()
                
                if !hasInitialCentered {
                    if let userLoc = store.locationService.userLocation {
                        model.recenter(on: userLoc, animated: false)
                        hasInitialCentered = true
                    } else {
                        hasInitialCentered = true
                        Task { @MainActor in
                            let deadline = ContinuousClock.now.advanced(by: .seconds(10))
                            while ContinuousClock.now < deadline {
                                if let loc = store.locationService.userLocation {
                                    model.recenter(on: loc, animated: false)
                                    return
                                }
                                try? await Task.sleep(for: .milliseconds(200))
                            }
                        }
                    }
                }
                
                Task {
                    await store.contactService.requestAccess()
                }
            }
            .onChange(of: path.isEmpty) { _, isEmpty in
                if isEmpty {
                    showHitchSheet = true
                }
            }
            .onChange(of: userLocationKey) { _, _ in
                model.reverseGeocode(store.locationService.userLocation)
            }
            .onChange(of: selectedDestination) { _, newPlace in
                guard let place = newPlace else { return }
                model.destinationName = place.name
                Task {
                    model.clearRoute()
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
