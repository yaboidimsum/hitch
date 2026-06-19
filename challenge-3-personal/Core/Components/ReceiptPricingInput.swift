import SwiftUI

struct ReceiptPricingInput: View {
    @Bindable var model: ReceiptPricingModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Trip Details")
                .font(.caption)
                .bold()
                .foregroundStyle(.ink)
            
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Price per km")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    TextField("0", value: $model.pricePerKm, format: .number)
                        .keyboardType(model.currency.usesDecimals ? .decimalPad : .numberPad)
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.ink)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(.ink.opacity(0.01))
                        .clipShape(.rect(cornerRadius: 10))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Currency")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    Picker("Currency", selection: $model.currency) {
                        ForEach(Currency.allCases) { currency in
                            Text(currency.rawValue)
                                .tag(currency)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.ink)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    ReceiptPricingInput(model: ReceiptPricingModel())
}
