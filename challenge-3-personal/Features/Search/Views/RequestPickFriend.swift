import SwiftUI

struct RequestPickFriend: View {
    @Environment(AppStore.self) var store
//    @Bindable private var model = SearchFlowModel()
    let selectedPlace: Place
    let onFriendSelected: (User) -> Void
    let onBack: () -> Void
    let currentLocation: String?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Back", systemImage: "chevron.left", action: onBack)
                    .labelStyle(.iconOnly)
                    .font(.title3)
                    .foregroundStyle(.ink)
                    .frame(width: 44, height: 44)
                    .clipShape(.circle)
                    .glassEffect()
                
                Spacer()
                Text("Pick a friend")
                    .bold()
                    .foregroundStyle(.ink)
                Spacer()
                Circle().frame(width: 44, height: 44).opacity(0)

//
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 20)
            
                VStack(spacing: 20) {
                    VStack {
                        DestinationCard(
                            currentLocation: currentLocation,   // ← From MapModel
                            selectedPlace: selectedPlace
                        )
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                        Rectangle()
                            .fill(.mutedSlate.opacity(0.2))
                            .frame(height: 1)
                    }
                    
//                    VStack(alignment: .leading, spacing: 20) {
//                        Text("Who'll picked you up?")
//                            .font(.headline)
//                            .foregroundStyle(.ink)
//                            .padding(.horizontal, 16)
//                        
//                    }.padding(.bottom,16)
                }
            
            List(store.friends) { friend in
                FriendCard(friend: friend)
                    .frame(maxWidth: .infinity, alignment: .leading).contentShape(
                        Rectangle()
                    )
                    .onTapGesture {
                        onFriendSelected(friend)
                    }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    let store = AppStore.mock()
    NavigationStack {
        RequestPickFriend(
            selectedPlace: store.recentPlaces[0],
            onFriendSelected: { _ in }, onBack: {}, currentLocation: "Tes"
        )
        .environment(store)
    }
}
