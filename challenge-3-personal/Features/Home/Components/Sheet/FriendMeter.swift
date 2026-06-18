import SwiftUI

struct FriendMeter: View {
    @Environment(AppStore.self) var store
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Friends")
                .font(.headline)
                .foregroundStyle(.ink)
                .fontWeight(.semibold)
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(store.contactService.contacts
                        .filter{
                        !($0.phoneNumber?.isEmpty ?? true)
                    }
                        .sorted { $0.name < $1.name }
                    )
                    { friend in
                        FriendItem(friend: friend)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.vertical, 4)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    FriendMeter()
        .environment(AppStore.mock())
}
