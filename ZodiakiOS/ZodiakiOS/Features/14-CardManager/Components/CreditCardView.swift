import SwiftUI

// MARK: - Credit Card Visual
struct CreditCardView: View {
    let card: CreditCard

    private var bg: Color {
        let rgb = card.theme.background
        return Color(red: rgb[0], green: rgb[1], blue: rgb[2])
    }

    var body: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
            HStack {
                ZodiakText(verbatim: card.bankName, style: .title3)
                    .foregroundColor(ZodiakColors.textInverse)
                Spacer()
                ZodiakText(verbatim: card.brand, style: .caption())
                    .foregroundColor(ZodiakColors.textInverse.opacity(0.8))
            }
            Spacer()
            ZodiakText(
                verbatim: "**** **** **** \(card.lastDigits)",
                style: .body(bold: true)
            )
            .foregroundColor(ZodiakColors.textInverse)
        }
        .padding(ZodiakSpacing.s16)
        .frame(height: 180)
        .zodiakCardWidth()
        .background(bg)
        .cornerRadius(ZodiakRadii.m)
        .shadow(color: bg.opacity(0.4), radius: 12, x: 0, y: 6)
    }
}

// MARK: - Card Detail Modal Content
struct CardDetailContent: View {
    let card: CreditCard

    private static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM/yyyy"
        return df
    }()

    var body: some View {
        VStack(spacing: ZodiakSpacing.s8) {
            CreditCardView(card: card)
            ZodiakDivider(hierarchy: .secondary)
            ZodiakInfoRow(
                label: String(localized: "feature.card_manager.label_limit"),
                value: String(format: "R$ %.2f", card.limit)
            )
            ZodiakInfoRow(
                label: String(localized: "feature.card_manager.label_due"),
                value: Self.dateFormatter.string(from: card.dueDate)
            )
            ZodiakInfoRow(
                label: String(localized: "feature.card_manager.label_brand"),
                value: card.brand
            )
            ZodiakInfoRow(
                label: String(localized: "feature.card_manager.label_last_digits"),
                value: card.lastDigits
            )
        }
    }
}
