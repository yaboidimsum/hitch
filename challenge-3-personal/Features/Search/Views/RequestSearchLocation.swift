import SwiftUI

struct RequestSearchLocation: View {
    @Environment(AppStore.self) var store
    let onDismiss: () -> Void
    let onPlaceSelected: (Place) -> Void
    let currentLocation: String?
    @State private var selectedPlace: Place?
    @State private var cardID = UUID()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Button("Back", systemImage: "chevron.left", action: onDismiss)
                    .labelStyle(.iconOnly)
                    .font(.title3)
                    .foregroundStyle(.ink)
                    .frame(width: 44, height: 44)
                    .clipShape(.circle)
                    .glassEffect()
                
                Spacer()
                Text("Search destination")
                    .bold()
                    .foregroundStyle(.ink)
                Spacer()
                Circle().frame(width: 44, height: 44).opacity(0)
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 20)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    DestinationCard(
                        currentLocation: currentLocation,
                        selectedPlace: selectedPlace,
                        isEditable: true,
                        onPlaceSelected: { place in
                            selectedPlace = place
                            onPlaceSelected(place)
                        }
                    )
                    .id(cardID)
                    
//                    if selectedPlace == nil {
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("Recent")
//                                .font(.headline)
//                                .foregroundStyle(.ink)
//                                .padding(.horizontal, 16)
//                            
//                            ForEach(store.recentPlaces) { place in
//                                Button {
//                                    selectedPlace = place
//                                    onPlaceSelected(place)
//                                } label: {
//                                    LocationCard(place: place)
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                }
//                                .buttonStyle(.plain)
//                            }
//                        }
//                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .onAppear {
            selectedPlace = nil
            cardID = UUID()
        }
    }
}

#Preview {
    let store = AppStore.mock()
    NavigationStack {
        RequestSearchLocation(
            onDismiss: {},
            onPlaceSelected: { _ in },
            currentLocation: "Tes"
        )
        .environment(store)
    }
}
