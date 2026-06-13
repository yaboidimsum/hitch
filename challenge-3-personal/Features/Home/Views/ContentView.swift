//
//  ContentView.swift
//  challenge-3-personal
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var greeting = Greeting(message: "Hello, world!", recipient: "world")
    @State private var showHitchSheet = true
    @State private var selectedDetent: PresentationDetent = .height(70)
    @State private var model = MapModel()
    @State private var path = NavigationPath()
    
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
                            Task { model.snapToCity()
                            }
                        }
                    }
                
                WeatherActivity()
                    .padding(.top, -52)
                    .padding(.leading, 16)
                DriverButton() .padding(.top, 80)
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
                    }
                }
                
            }
            .navigationDestination(for: String.self) { value in
                if value == "activity" {
                    Activity()
                }
                else if value == "notification"{
                    Notification()
                }
                else if value == "history"{
                    History()
                }
            }
            .sheet(isPresented:  showHitchSheetBinding) {
                
                HitchSheet(selectedDetent: $selectedDetent)
                    .presentationDetents(
                        [.height(70), .medium, .large],
                        selection: $selectedDetent
                    )
                    .interactiveDismissDisabled()
                    .presentationBackgroundInteraction(.enabled)
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
}
