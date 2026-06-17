import SwiftUI

struct RequestSearchLocation: View {
    @Environment(AppStore.self) var store
    let onDismiss: () -> Void
    let onPlaceSelected: (Place) -> Void
    let currentLocation: String?
    @State private var selectedPlace: Place?
    
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
            
//            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    DestinationCard(
                        currentLocation: currentLocation,   // ← From MapModel
                        selectedPlace: selectedPlace
                    )
                    MapButton()
                }
                .padding(.horizontal, 16).padding(.bottom,16)
                
//                Rectangle()
//                    .fill(.mutedSlate.opacity(0.2))
//                    .frame(height: 1)
                
                List(store.recentPlaces) { place in
                    LocationCard(place: place)
                        .frame(maxWidth: .infinity, alignment: .leading).contentShape(
                            Rectangle()
                        )
                        .onTapGesture {
                            selectedPlace = place
                            onPlaceSelected(place)
                        }
                    
                }
                .listStyle(.plain)
//            }
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
