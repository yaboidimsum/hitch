import SwiftUI

struct RequestSearchLocation: View {
    @Environment(AppStore.self) var store
    let onDismiss: () -> Void
    
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
                Text("Hitch Request")
                    .bold()
                    .foregroundStyle(.ink)
                Spacer()
                NavigationLink(value: SearchDestination.pickFriend) {
                    Image(systemName: "checkmark")
                        .font(.title3)
                        .foregroundStyle(.white)
                        .frame(width: 44, height: 44)
                        .background(.greenBrand)
                        .clipShape(.circle)
                        .glassEffect()
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 20)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    DestinationCard()
                    MapButton()
                }
                .padding(.horizontal, 16)
                
                Rectangle()
                    .fill(.mutedSlate.opacity(0.2))
                    .frame(height: 1)
                
                ForEach(store.recentPlaces) { place in
                    LocationCard(place: place)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RequestSearchLocation(onDismiss: {})
            .environment(AppStore.mock())
    }
}
