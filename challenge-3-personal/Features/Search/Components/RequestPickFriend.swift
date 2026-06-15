import SwiftUI

struct RequestPickFriend: View {
    @Environment(AppStore.self) var store
    let onBack: () -> Void
    let onConfirm: () -> Void
    
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
                Text("Hitch Request")
                    .bold()
                    .foregroundStyle(.ink)
                Spacer()
                Button("Confirm", systemImage: "checkmark", action: onConfirm)
                    .labelStyle(.iconOnly)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .background(.greenBrand)
                    .clipShape(.circle)
                    .glassEffect()
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 20)
            
            ScrollView {
                VStack(spacing: 20) {
                    VStack {
                        DestinationCard()
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                        Rectangle()
                            .fill(.mutedSlate.opacity(0.2))
                            .frame(height: 1)
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Who'll picked you up?")
                            .font(.headline)
                            .foregroundStyle(.ink)
                            .padding(.horizontal, 16)
                        
                        VStack(spacing: 0) {
                            ForEach(store.friends) { friend in
                                FriendCard(friend: friend)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RequestPickFriend(onBack: {}, onConfirm: {})
            .environment(AppStore.mock())
    }
}
