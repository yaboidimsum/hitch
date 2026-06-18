import SwiftUI

struct RequestReceipt: View {
    @Environment(AppStore.self) var store
    @Environment(\.openURL) private var openURL
    let selectedPlace: Place
    let selectedFriend: User
    let onBack: ()->Void
    let onSend: () -> Void
    let currentLocation: String?
    let distance: Double?
    
    private var routeKm: Double? {
        guard let distance else { return nil }
        return distance / 1000
    }
    
    private var routePrice: Int? {
        guard let km = routeKm else { return nil }
        return Int((km * 7000 / 1000).rounded() * 1000)
    }
    
    private var tax: Int? {
        guard let price = routePrice else { return nil }
        return Int((Double(price) * 0.11).rounded())
    }
    
    private var subtotal: Int? {
        guard let price = routePrice, let tax = tax else { return nil }
        return price + tax
    }

    private var whatsappURL: URL? {
        guard let phoneNumber = whatsappPhoneNumber else { return nil }
        let message = whatsappMessage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let message else { return nil }
        return URL(string: "https://wa.me/\(phoneNumber)?text=\(message)")
    }

    private var whatsappPhoneNumber: String? {
        let digits = selectedFriend.phoneNumber?.filter(\.isNumber) ?? ""
        guard !digits.isEmpty else { return nil }

        if digits.hasPrefix("62") {
            return digits
        }

        if digits.hasPrefix("0") {
            return "62" + digits.dropFirst()
        }

        return digits
    }

    private var whatsappMessage: String {
        let origin = currentLocation ?? "Current location"
        let distanceText = routeKm?.formatted(.number.precision(.fractionLength(2))) ?? "-"
        let subtotalText = subtotal?.formatted(.number.precision(.fractionLength(0))) ?? "-"

        return """
        [HITCH GIGS]
        Hi \(selectedFriend.name), can you pick me up?
        From: \(origin)
        To: \(selectedPlace.name)
        Distance: \(distanceText) km
        Total: Rp\(subtotalText)
        """
    }
    
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
                        DestinationCard(
                            currentLocation: currentLocation,
                            selectedPlace: selectedPlace
                        )
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                        Rectangle()
                            .fill(.mutedSlate.opacity(0.2))
                            .frame(height: 1)
                        
                        FriendCard(friend: selectedFriend)
                    }
                    
                    if let km = routeKm {
                        HStack {
                            Text("Distance")
                                .font(.caption)
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(km, format: .number.precision(.fractionLength(2))) km")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        .padding(.horizontal, 16)
                    }
                    
                    VStack {
                        HStack {
                            Text("Price")
                                .font(.caption)
                                .fontWeight(.semibold)
                            Spacer()
                            if let price = routePrice {
                                Text("Rp\(price, format: .number.precision(.fractionLength(0)))")
                                    .font(.caption)
                                    .fontWeight(.medium)
                            } else {
                                Text("Calculating...")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        HStack {
                            Text("Tax (11%)")
                                .font(.caption)
                                .fontWeight(.semibold)
                            Spacer()
                            if let tax = tax {
                                Text("Rp\(tax, format: .number.precision(.fractionLength(0)))")
                                    .font(.caption)
                                    .fontWeight(.medium)
                            } else {
                                Text("Calculating...")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
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
                            if let subtotal = subtotal {
                                Text("Rp\(subtotal, format: .number.precision(.fractionLength(0)))")
                                    .font(.caption)
                                    .fontWeight(.medium)
                            } else {
                                Text("Calculating...")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        
//                        HStack {
//                            Text("Payment Method")
//                                .font(.caption)
//                                .fontWeight(.semibold)
//                            Spacer()
//                            Text("Apple Pay")
//                                .font(.caption)
//                                .fontWeight(.medium)
//                        }
//                        .padding(.vertical, 12)
//                        .padding(.horizontal, 16)
                    }
                    
                    Rectangle()
                        .fill(.mutedSlate.opacity(0.2))
                        .frame(height: 1)
                    
                    VStack {
                        Button("Send Request") {
                            onSend()

                            guard let whatsappURL else { return }
                            openURL(whatsappURL)
                        }
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
    let store = AppStore.mock()
    NavigationStack {
        RequestReceipt(
            selectedPlace: store.recentPlaces[0],
            selectedFriend: store.friends[0],
            onBack: {},
            onSend: {},
            currentLocation: "Test",
            distance: 3500
        )
        .environment(store)
    }
}
