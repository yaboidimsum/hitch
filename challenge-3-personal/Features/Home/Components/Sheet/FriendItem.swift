import SwiftUI

struct FriendItem: View {
    let friend: User
    
    var body: some View {
        VStack(spacing: 8) {
            UserAvatarView(user: friend, size: 80)

            VStack(spacing: 4) {
                Text(friend.name)
                    .foregroundStyle(.ink)
                    .font(.caption)
                    .fontWeight(.medium)
//                if friend.isAvailable {
//                    Text("Nearby")
//                        .foregroundStyle(.greenBrand)
//                        .font(.caption2)
//                        .fontWeight(.medium)
//                }
            }
        }
    }
}

#Preview {
    let store = AppStore.mock()
    FriendItem(friend: store.friends[0])
}
