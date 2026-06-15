import SwiftUI

struct HitchRequestDoneCard: View {
    let ride: Ride
    let currentUserID: UUID
    
    private var otherPerson: User {
        ride.driver.id == currentUserID ? ride.passenger : ride.driver
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image(systemName: "flag.pattern.checkered.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 72, height: 72)
                .foregroundStyle(.greenBrand)
            
            Text("You've completed the ride with \(otherPerson.name)! Payment of \(ride.isIncoming(for: currentUserID) ? "+" : "-")Rp\(ride.amount, format: .number) has been transferred to your wallet.")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.greenBrand)
                .multilineTextAlignment(.center)
            
            Button("Close", action: {})
                .font(.headline)
                .foregroundStyle(.greenBrand)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(.mutedSlate.opacity(0.2))
                .clipShape(.rect(cornerRadius: 999))
                .glassEffect()
        }
        .padding(40)
    }
}

#Preview {
    let store = AppStore.mock()
    HitchRequestDoneCard(ride: store.history[0], currentUserID: store.currentUser.id)
}
