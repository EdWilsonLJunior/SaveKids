import SwiftUI

// MARK: - ZodiakFlagView
// Fonte: Zodiak Design System – Capgemini (visual-assets/flags/)
//
// Rules (spec):
//   • A flag MUST always be accompanied by a text label.
//   • Do not resize flags beyond the four defined sizes.
//   • Do not distort the dimensions of the flags.
//   • Do not use flags of different sizes within the same group.
//   • Always include alt text: "Flag of {country}".

struct ZodiakFlagView: View {
    let country: ZodiakFlagCountry
    let size: ZodiakFlagSize
    /// Required by spec — a flag must never be shown without a label.
    let label: String

    init(
        _ country: ZodiakFlagCountry,
        size: ZodiakFlagSize = .small,
        label: String
    ) {
        self.country = country
        self.size = size
        self.label = label
    }

    var body: some View {
        HStack(spacing: size.gap) {
            Image(country.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: size.flagDimension, height: size.flagDimension)
                .clipShape(RoundedRectangle(cornerRadius: 2))

            Text(label)
                .font(labelFont)
                .foregroundStyle(ZodiakColors.textPrimary)
                .lineLimit(1)
        }
        .frame(height: size.rowHeight, alignment: .center)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(
            Text(verbatim: String(format: String(localized: "shared.format.flag_of"), country.displayName, label))
        )
    }

    // MARK: - Private

    private var labelFont: Font {
        switch size {
        case .xSmall: return ZodiakTypography.captionLarge        // body-xs 12pt
        case .small:  return ZodiakTypography.labelMedium  // heading-2xs 14pt
        case .medium: return ZodiakTypography.labelLarge         // heading-xs 16pt
        case .large:  return ZodiakTypography.titleSmall         // heading-s 18pt
        }
    }
}

// MARK: - Preview

#Preview("Flag sizes") {
    VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
        ZodiakFlagView(.france, size: .xSmall, label: "France")
        ZodiakFlagView(.france, size: .small, label: "France")
        ZodiakFlagView(.france, size: .medium, label: "France")
        ZodiakFlagView(.france, size: .large, label: "France")
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}

#Preview("Flag grid sample") {
    let samples: [ZodiakFlagCountry] = [
        .germany, .france, .italy, .japan, .norway, .switzerland, .sweden, .netherlands
    ]
    return ScrollView {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ForEach(samples, id: \.imageName) { country in
                ZodiakFlagView(country, size: .small, label: country.displayName)
            }
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
