import SwiftUI

struct FriendMeter: View {
    @Environment(AppStore.self) var store
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Nearby Friends")
                .font(.headline)
                .foregroundStyle(.ink)
                .fontWeight(.semibold)

            HStack(spacing: 16) {
                ForEach(store.friends.prefix(4)) { friend in
                    FriendItem(friend: friend)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    FriendMeter()
        .environment(AppStore.mock())
}
