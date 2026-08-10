import SwiftUI

// MARK: - Zodiak Rating
// Figma: "catalog.component_name.rating" — star-based score input and display
// Nota: ZodiakRating não tem spec Supernova. A cor de estrela ativa é interna ao componente.
private let ratingActiveFill = Color(hex: "#f2b81a")

public struct ZodiakRating: View {
    @Binding var rating: Int
    let maxStars: Int
    let size: CGFloat
    let isReadOnly: Bool
    let showLabel: Bool
    @Environment(\.locale) private var locale

    public init(
        rating: Binding<Int>,
        maxStars: Int = 5,
        size: CGFloat = 24,
        isReadOnly: Bool = false,
        showLabel: Bool = false
    ) {
        self._rating = rating
        self.maxStars = maxStars
        self.size = size
        self.isReadOnly = isReadOnly
        self.showLabel = showLabel
    }

    public var body: some View {
        HStack(spacing: ZodiakSpacing.s4) {
            HStack(spacing: ZodiakSpacing.s4) {
                ForEach(1...maxStars, id: \.self) { star in
                    Image(ZodiakIcon.star.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size, height: size)
                        .foregroundStyle(star <= rating ? ratingActiveFill : ZodiakColors.borderPrimary)
                        .onTapGesture {
                            if !isReadOnly {
                                withAnimation(.spring(response: 0.2)) {
                                    // Tap same star toggles off
                                    rating = (rating == star) ? 0 : star
                                }
                            }
                        }
                        .accessibilityLabel(
                            Text(verbatim: String(
                                format: String(localized: "shared.format.stars_rating", locale: locale),
                                star,
                                maxStars
                            ))
                        )
                }
            }

            if showLabel && rating > 0 {
                Text(ratingLabel)
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.15), value: rating)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text("shared.label.rating"))
        .accessibilityValue(
            Text(verbatim: String(
                format: String(localized: "shared.format.stars_rating", locale: locale),
                rating,
                maxStars
            ))
        )
        .accessibilityAdjustableAction { direction in
            guard !isReadOnly else { return }
            switch direction {
            case .increment:
                if rating < maxStars { rating += 1 }

            case .decrement:
                if rating > 0 { rating -= 1 }

            @unknown default: break
            }
        }
        .zodiakA11yID("rating", role: isReadOnly ? "readonly" : "editable")
    }

    private var ratingLabel: LocalizedStringKey {
        switch rating {
        case 1: return "shared.rating.terrible"
        case 2: return "shared.rating.poor"
        case 3: return "shared.rating.average"
        case 4: return "shared.rating.good"
        case 5: return "shared.rating.excellent"
        default: return ""
        }
    }
}

// MARK: Read-only display variant (accepts Double for half-stars visual)

public struct ZodiakRatingDisplay: View {
    let value: Double   // e.g. 3.7
    let maxStars: Int
    let size: CGFloat
    let showValue: Bool

    public init(value: Double, maxStars: Int = 5, size: CGFloat = 14, showValue: Bool = true) {
        self.value = value
        self.maxStars = maxStars
        self.size = size
        self.showValue = showValue
    }

    public var body: some View {
        HStack(spacing: ZodiakSpacing.s4) {
            HStack(spacing: 1) {
                ForEach(1...maxStars, id: \.self) { star in
                    let fill = starFill(for: star)
                    Image(ZodiakIcon.star.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size, height: size)
                        .foregroundStyle(fill > 0 ? ratingActiveFill : ZodiakColors.borderPrimary)
                }
            }

            if showValue {
                Text(String(format: "%.1f", value))
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
            }
        }
    }

    private func starFill(for star: Int) -> Double {
        let diff = value - Double(star - 1)
        if diff >= 1.0 { return 1.0 }
        if diff >= 0.5 { return 0.5 }
        return 0.0
    }
}
