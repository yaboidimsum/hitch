import SwiftUI

struct FriendItem: View {
    let friend: User
    
    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: friend.avatarURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Circle()
                    .fill(.gray.opacity(0.3))
            }
            .frame(width: 80, height: 80)
            .clipShape(.circle)

            VStack(spacing: 4) {
                Text(friend.name)
                    .foregroundStyle(.ink)
                    .font(.caption)
                    .fontWeight(.medium)
                Text("Nearby")
                    .foregroundStyle(.ink)
                    .font(.caption2)
                    .fontWeight(.medium)
            }
        }
    }
}

#Preview {
    let store = AppStore.mock()
    FriendItem(friend: store.friends[0])
}
