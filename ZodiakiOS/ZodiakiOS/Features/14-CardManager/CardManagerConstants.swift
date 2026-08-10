import Foundation

// MARK: - Constants
enum CardManagerConstants {
    static let sampleCards: [CreditCard] = [
        CreditCard(
            bankName: "Astro Bank",
            brand: "Visa",
            lastDigits: "4231",
            theme: .ocean,
            limit: 5_000.00,
            dueDate: Calendar.current.date(from: DateComponents(year: 2027, month: 8, day: 1)) ?? .now
        ),
        CreditCard(
            bankName: "Crimson Card",
            brand: "Mastercard",
            lastDigits: "7890",
            theme: .crimson,
            limit: 12_000.00,
            dueDate: Calendar.current.date(from: DateComponents(year: 2028, month: 3, day: 1)) ?? .now
        ),
        CreditCard(
            bankName: "Midnight Pay",
            brand: "Mastercard",
            lastDigits: "5512",
            theme: .midnight,
            limit: 8_500.00,
            dueDate: Calendar.current.date(from: DateComponents(year: 2026, month: 11, day: 1)) ?? .now
        ),
        CreditCard(
            bankName: "Amber Finance",
            brand: "Elo",
            lastDigits: "3307",
            theme: .amber,
            limit: 3_200.00,
            dueDate: Calendar.current.date(from: DateComponents(year: 2027, month: 5, day: 1)) ?? .now
        ),
        CreditCard(
            bankName: "Verdant Bank",
            brand: "Visa",
            lastDigits: "9944",
            theme: .forest,
            limit: 2_000.00,
            dueDate: Calendar.current.date(from: DateComponents(year: 2026, month: 9, day: 1)) ?? .now
        )
    ]
}
