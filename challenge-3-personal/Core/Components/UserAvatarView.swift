import SwiftUI

struct UserAvatarView: View {
    let user: User
    var size: CGFloat = 40
    
    var body: some View {
        Group {
            if let data = user.avatarData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else if let urlString = user.avatarURL, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Circle()
                        .fill(.gray.opacity(0.3))
                }
            } else {
                Circle()
                    .fill(.gray.opacity(0.3))
                    .overlay(
                        Text(String(user.name.prefix(1)))
                            .font(.system(size: size * 0.4, weight: .semibold))
                            .foregroundStyle(.white)
                    )
            }
        }
        .frame(width: size, height: size)
        .clipShape(.circle)
    }
}

#Preview {
    let store = AppStore.mock()
    HStack(spacing: 16) {
        UserAvatarView(user: store.friends[0], size: 64)
        UserAvatarView(user: store.friends[1], size: 40)
    }
}
