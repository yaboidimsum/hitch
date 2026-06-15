import SwiftUI

struct RequestReceipt: View {
    @Environment(AppStore.self) var store
    let onBack: () -> Void
    let onDone: () -> Void
    
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
                Text("Receipt")
                    .bold()
                    .foregroundStyle(.ink)
                Spacer()
                Circle().frame(width: 44, height: 44).opacity(0)
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 20)
            
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 12) {
                        DestinationCard()
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                        Rectangle()
                            .fill(.mutedSlate.opacity(0.2))
                            .frame(height: 1)
                        
                        if let firstFriend = store.friends.first {
                            FriendCard(friend: firstFriend)
                        }
                    }
                    
                    VStack {
                        HStack {
                            Text("Price")
                                .font(.caption)
                                .fontWeight(.semibold)
                            Spacer()
                            Text("Rp20.000")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        .padding(.horizontal, 16)
                        
                        HStack {
                            Text("Tax")
                                .font(.caption)
                                .fontWeight(.semibold)
                            Spacer()
                            Text("Rp20.000")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                    }
                    
                    Rectangle()
                        .fill(.mutedSlate.opacity(0.2))
                        .frame(height: 1)
                    
                    VStack {
                        HStack {
                            Text("Subtotal")
                                .font(.caption)
                                .fontWeight(.semibold)
                            Spacer()
                            Text("Rp40.000")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        
                        HStack {
                            Text("Payment Method")
                                .font(.caption)
                                .fontWeight(.semibold)
                            Spacer()
                            Text("Apple Pay")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                    }
                    
                    Rectangle()
                        .fill(.mutedSlate.opacity(0.2))
                        .frame(height: 1)
                    
                    VStack {
                        Button("Send Request", action: onDone)
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(.greenBrand)
                            .clipShape(.rect(cornerRadius: 999))
                            .glassEffect()
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 12)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RequestReceipt(onBack: {}, onDone: {})
            .environment(AppStore.mock())
    }
}
