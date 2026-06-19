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
    
    @State private var pricingModel = ReceiptPricingModel()
    @State private var frozenPricePerKm: Double?
    @State private var frozenCurrency: Currency?
    @State private var composerContext: ComposerContext?
    
    private struct ComposerContext: Identifiable {
        let id = UUID()
        let recipients: [String]
        let body: String
    }
    
    private var effectivePricePerKm: Double {
        frozenPricePerKm ?? pricingModel.pricePerKm
    }
    
    private var effectiveCurrency: Currency {
        frozenCurrency ?? pricingModel.currency
    }
    
    private var routeKm: Double? {
        guard let distance else { return nil }
        return distance / 1000
    }
    
    private var routePrice: Int? {
        guard let km = routeKm else { return nil }
        return Int((km * effectivePricePerKm).rounded())
    }
    
    private var tax: Int? {
        guard let price = routePrice else { return nil }
        return Int((Double(price) * 0.11).rounded())
    }
    
    private var subtotal: Int? {
        guard let price = routePrice else {return nil}
                /*, let tax = tax else { return nil }*/
//        return /*price + */tax
        return price
    }
    
    private func formatPrice(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = effectiveCurrency.locale
        formatter.maximumFractionDigits = effectiveCurrency.usesDecimals ? 2 : 0
        formatter.minimumFractionDigits = effectiveCurrency.usesDecimals ? 2 : 0
        let numberString = formatter.string(from: NSNumber(value: value)) ?? "\(value)"
        return "\(effectiveCurrency.symbol) \(numberString)"
    }
    
    private func formatPrice(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = effectiveCurrency.locale
        formatter.maximumFractionDigits = effectiveCurrency.usesDecimals ? 2 : 0
        formatter.minimumFractionDigits = effectiveCurrency.usesDecimals ? 2 : 0
        let numberString = formatter.string(from: NSNumber(value: value)) ?? "\(value)"
        return "\(effectiveCurrency.symbol) \(numberString)"
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
        let subtotalText = subtotal.map { formatPrice($0) } ?? "-"
        
        let destination: String
        if selectedPlace.address.isEmpty {
            destination = selectedPlace.name
        } else {
            destination = "\(selectedPlace.name) — \(selectedPlace.address)"
        }

        return """
        [HITCH GIGS]
        Hi \(selectedFriend.name), can you pick me up?
        From: \(origin)
        To: \(destination)
        Distance: \(distanceText) km
        Rate: \(formatPrice(effectivePricePerKm)) /km
        Total: \(subtotalText)
        """
    }

    private var imessagePhoneNumber: String? {
        let digits = selectedFriend.phoneNumber?.filter(\.isNumber) ?? ""
        guard !digits.isEmpty else { return nil }

        if digits.hasPrefix("62") {
            return "+" + digits
        }

        return digits
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
                            selectedPlace: selectedPlace,
                            isEditable: false,
                            onPlaceSelected: { _ in }
                        )
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        Rectangle()
                            .fill(.mutedSlate.opacity(0.2))
                            .frame(height: 1)
                        
                        FriendCard(friend: selectedFriend)
                    }
                    
                    ReceiptPricingInput(model: pricingModel)
                    
                    if let km = routeKm {
                        HStack {
                            Text("Distance")
                                .font(.caption)
                                .bold()
                            Spacer()
                            Text("\(km, format: .number.precision(.fractionLength(2))) km")
                                .font(.caption)
                                .bold()
                        }
                        .padding(.horizontal, 16)
                    }
                    
                    VStack {
//                        HStack {
//                            Text("Price")
//                                .font(.caption)
//                                .bold()
//                            Spacer()
//                            if let price = routePrice {
//                                Text(formatPrice(price))
//                                    .font(.caption)
//                                    .bold()
//                            } else {
//                                Text("Calculating...")
//                                    .font(.caption)
//                                    .foregroundStyle(.secondary)
//                            }
//                        }
//                        .padding(.horizontal, 16)
                        
//                        HStack {
//                            Text("Tax (11%)")
//                                .font(.caption)
//                                .bold()
//                            Spacer()
//                            if let tax = tax {
//                                Text(formatPrice(tax))
//                                    .font(.caption)
//                                    .bold()
//                            } else {
//                                Text("Calculating...")
//                                    .font(.caption)
//                                    .foregroundStyle(.secondary)
//                            }
//                        }
//                        .padding(.vertical, 12)
//                        .padding(.horizontal, 16)
                    }
                    
                    Rectangle()
                        .fill(.mutedSlate.opacity(0.2))
                        .frame(height: 1)
                    
                    VStack {
                        HStack {
                            Text("Total")
                                .font(.caption)
                                .bold()
                            Spacer()
                            if let subtotal = subtotal {
                                Text(formatPrice(subtotal))
                                    .font(.caption)
                                    .bold()
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
                    
                    VStack(spacing: 8) {
                        Button("Forward via iMessage", systemImage: "message.fill", action: {
                            guard let phone = imessagePhoneNumber else { return }
                            frozenPricePerKm = pricingModel.pricePerKm
                            frozenCurrency = pricingModel.currency
                            onSend()
                            composerContext = ComposerContext(
                                recipients: [phone],
                                body: whatsappMessage
                            )
                        })
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(.blue)
                        .clipShape(.rect(cornerRadius: 999))
                        .disabled(imessagePhoneNumber == nil)
                        .glassEffect()

                        Button("Send via WhatsApp", action: {
                            frozenPricePerKm = pricingModel.pricePerKm
                            frozenCurrency = pricingModel.currency
                            onSend()
                            guard let whatsappURL else { return }
                            openURL(whatsappURL)
                        })
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
        .sheet(item: $composerContext) { context in
            MessageComposer(
                recipients: context.recipients,
                body: context.body
            ) {
                composerContext = nil
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
