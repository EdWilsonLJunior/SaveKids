import Foundation

// MARK: - Currency Model

struct Currency: Hashable, Identifiable {
    let id: String
    let code: String
    let name: String
    let symbol: String
    let flag: String
    let usdRate: Double
}

// MARK: - Constants

enum CurrencyConverterConstants {
    static let currencies: [Currency] = [
        Currency(id: "USD", code: "USD", name: "US Dollar", symbol: "$", flag: "🇺🇸", usdRate: 1.00),
        Currency(id: "EUR", code: "EUR", name: "Euro", symbol: "€", flag: "🇪🇺", usdRate: 0.92),
        Currency(id: "BRL", code: "BRL", name: "Real Brasileiro", symbol: "R$", flag: "🇧🇷", usdRate: 5.70),
        Currency(id: "GBP", code: "GBP", name: "British Pound", symbol: "£", flag: "🇬🇧", usdRate: 0.79),
        Currency(id: "JPY", code: "JPY", name: "Japanese Yen", symbol: "¥", flag: "🇯🇵", usdRate: 155.00),
        Currency(id: "AUD", code: "AUD", name: "Australian Dollar", symbol: "A$", flag: "🇦🇺", usdRate: 1.56),
        Currency(id: "CAD", code: "CAD", name: "Canadian Dollar", symbol: "C$", flag: "🇨🇦", usdRate: 1.37),
        Currency(id: "CHF", code: "CHF", name: "Swiss Franc", symbol: "Fr", flag: "🇨🇭", usdRate: 0.91),
        Currency(id: "CNY", code: "CNY", name: "Chinese Yuan", symbol: "¥", flag: "🇨🇳", usdRate: 7.24),
        Currency(id: "MXN", code: "MXN", name: "Mexican Peso", symbol: "$", flag: "🇲🇽", usdRate: 17.20)
    ]
}
