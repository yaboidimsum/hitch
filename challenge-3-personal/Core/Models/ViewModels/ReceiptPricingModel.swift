import SwiftUI

@MainActor
@Observable
final class ReceiptPricingModel {
    var pricePerKm: Double {
        didSet { UserDefaults.standard.set(pricePerKm, forKey: "receiptPricePerKm") }
    }
    var currency: Currency {
        didSet { UserDefaults.standard.set(currency.rawValue, forKey: "receiptCurrency") }
    }
    
    init() {
        let storedPrice = UserDefaults.standard.double(forKey: "receiptPricePerKm")
        self.pricePerKm = storedPrice == 0 ? 7000 : storedPrice
        let storedCurrency = UserDefaults.standard.string(forKey: "receiptCurrency")
        self.currency = Currency(rawValue: storedCurrency ?? "IDR") ?? .idr
    }
}

enum Currency: String, CaseIterable, Identifiable, Hashable {
    case idr = "IDR"
    case usd = "USD"
    case sgd = "SGD"
    case eur = "EUR"
    case jpy = "JPY"
    case myr = "MYR"
    case aud = "AUD"
    case krw = "KRW"
    case gbp = "GBP"
    case thb = "THB"
    case php = "PHP"
    case cny = "CNY"
    
    var id: String { rawValue }
    
    var symbol: String {
        switch self {
        case .idr: return "Rp"
        case .usd: return "$"
        case .sgd: return "S$"
        case .eur: return "€"
        case .jpy: return "¥"
        case .myr: return "RM"
        case .aud: return "A$"
        case .krw: return "₩"
        case .gbp: return "£"
        case .thb: return "฿"
        case .php: return "₱"
        case .cny: return "¥"
        }
    }
    
    var displayName: String {
        switch self {
        case .idr: return "Indonesian Rupiah"
        case .usd: return "US Dollar"
        case .sgd: return "Singapore Dollar"
        case .eur: return "Euro"
        case .jpy: return "Japanese Yen"
        case .myr: return "Malaysian Ringgit"
        case .aud: return "Australian Dollar"
        case .krw: return "South Korean Won"
        case .gbp: return "British Pound"
        case .thb: return "Thai Baht"
        case .php: return "Philippine Peso"
        case .cny: return "Chinese Yuan"
        }
    }
    
    var locale: Locale {
        switch self {
        case .idr: return Locale(identifier: "id_ID")
        case .usd: return Locale(identifier: "en_US")
        case .sgd: return Locale(identifier: "en_SG")
        case .eur: return Locale(identifier: "de_DE")
        case .jpy: return Locale(identifier: "ja_JP")
        case .myr: return Locale(identifier: "ms_MY")
        case .aud: return Locale(identifier: "en_AU")
        case .krw: return Locale(identifier: "ko_KR")
        case .gbp: return Locale(identifier: "en_GB")
        case .thb: return Locale(identifier: "th_TH")
        case .php: return Locale(identifier: "fil_PH")
        case .cny: return Locale(identifier: "zh_CN")
        }
    }
    
    var usesDecimals: Bool {
        switch self {
        case .idr, .jpy, .krw:
            return false
        case .usd, .sgd, .eur, .myr, .aud, .gbp, .thb, .php, .cny:
            return true
        }
    }
}
