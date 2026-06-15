import SwiftUI

struct HitchRequestRejectedCard: View {
    let ride: Ride
    let currentUserID: UUID
    
    private var otherPerson: User {
        ride.driver.id == currentUserID ? ride.passenger : ride.driver
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image(systemName: "hand.thumbsup.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 72, height: 72)
                .foregroundStyle(.mutedSlate)
            
            Text("Your request with \(otherPerson.name) has been rejected. See you on the next ride.")
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
    HitchRequestRejectedCard(ride: store.history[2], currentUserID: store.currentUser.id)
}
