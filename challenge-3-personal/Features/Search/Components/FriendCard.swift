import SwiftUI

struct FriendCard: View {
    let friend: User
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: friend.avatarURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Circle()
                    .fill(.gray.opacity(0.3))
            }
            .frame(width: 40, height: 40)
            .clipShape(.circle)
            
            Text(friend.name)
                .font(.caption)
                .bold()
                .foregroundStyle(.ink)
            
            Spacer()
            
            Text("Nearby")
                .font(.caption)
                .bold()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    let store = AppStore.mock()
    FriendCard(friend: store.friends[0])
}
