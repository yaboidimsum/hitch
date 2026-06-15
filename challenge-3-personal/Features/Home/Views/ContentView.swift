import SwiftUI
import MapKit

enum SheetContent {
    case hitch
    case request
    case search
}

struct ContentView: View {
    @Environment(AppStore.self) var store
    @State private var showHitchSheet = true
    @State private var selectedDetent: PresentationDetent = .fraction(0.15)
    @State private var model = MapModel()
    @State private var path = NavigationPath()
    @State private var sheetContent: SheetContent = .hitch
    
    private var showHitchSheetBinding: Binding<Bool> {
        Binding(
            get: { showHitchSheet && path.isEmpty },
            set: { showHitchSheet = $0 }
        )
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .topLeading) {
                Map(position: $model.position)
                    .mapStyle(.standard)
                    .mapControls {
                        MapUserLocationButton()
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
                    SearchFlow(sheetContent: $sheetContent)
                        .presentationDetents([.medium, .large])
                        .interactiveDismissDisabled()
                        .presentationBackgroundInteraction(.enabled)
                }
            }
            .onChange(of: path.isEmpty) { _, isEmpty in
                if isEmpty {
                    showHitchSheet = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(AppStore.mock())
}
