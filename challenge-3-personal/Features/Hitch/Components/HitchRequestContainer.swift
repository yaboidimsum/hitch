import SwiftUI

struct HitchRequestContainer: View {
    let state: HitchRequestState
    let currentUserID: UUID
    let onBack: () -> Void
    
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
                Circle().frame(width: 44, height: 44).opacity(0)
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 20)
            
            ScrollView {
                switch state {
                case .empty:
                    Text("Empty")
                        .fontWeight(.medium)
                        .foregroundStyle(.mutedSlate)
                        .italic()
                    
                case .incoming(let ride):
                    HitchRequestIncomingCard(ride: ride, currentUserID: currentUserID)
                    
                case .inProgress(let ride):
                    HitchRequestProgressCard(ride: ride, currentUserID: currentUserID)
                    
                case .done(let ride):
                    HitchRequestDoneCard(ride: ride, currentUserID: currentUserID)
                    
                case .rejected(let ride):
                    HitchRequestRejectedCard(ride: ride, currentUserID: currentUserID)
                }
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview {
    let store = AppStore.mock()
    HitchRequestContainer(state: .empty, currentUserID: store.currentUser.id, onBack: {})
}
