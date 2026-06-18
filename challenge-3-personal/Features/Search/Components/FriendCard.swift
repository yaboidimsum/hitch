import SwiftUI

struct FriendCard: View {
    let friend: User
    
    var body: some View {
        HStack(spacing: 12) {
            UserAvatarView(user: friend, size: 40)
            
            Text(friend.name)
                .font(.caption)
                .bold()
                .foregroundStyle(.ink)
            
            Spacer()
            
            if let phone = friend.phoneNumber {
                Text(phone)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    let store = AppStore.mock()
    FriendCard(friend: store.friends[0])
}
