//
//  ContentView.swift
//  challenge-3-personal
//

import SwiftUI

struct ContentView: View {
    @State private var greeting = Greeting(message: "Hello, world!", recipient: "world")
    @State private var showHitchSheet = true
    @State private var selectedDetent: PresentationDetent = .height(70)

    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                // Main content
                VStack(spacing: 12) {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text(greeting.headline)
                        .font(.title2)
                        .bold()
                    Text(greeting.subtitle)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                WeatherActivity()
                    .padding(.top, -52)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button("notifications", systemImage: "bell", action: {})
                        Button("receipt", systemImage: "receipt", action: {})
                        Button("history", systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90", action: {})
                    }
                }
            }
            .padding(.horizontal, 16)
            .sheet(isPresented: $showHitchSheet) {
                HitchSheet(selectedDetent: $selectedDetent)
                    .presentationDetents(
                        [.height(70), .medium],
                        selection: $selectedDetent
                    )
                    .interactiveDismissDisabled()
                    .presentationBackgroundInteraction(.enabled)
            }
        }
    }
}

#Preview {
    ContentView()
}
