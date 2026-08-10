import SwiftUI

// MARK: - Zodiak Eyebrow
// Fonte: Zodiak Design System – Capgemini | Página "Eyebrow"
// Specs: Size Small / Medium, BG OnLite / OnHeavy
// Estilo: em-dash + uppercase, tracking largo, peso semibold, sem background visual próprio
// Uso: rótulo acima de headlines para categorizar o conteúdo

enum ZodiakEyebrowSize {
    case small, medium
    var font: Font {
        switch self {
        case .small:  return ZodiakTypography.labelMedium  // heading-2xs: 14pt
        case .medium: return ZodiakTypography.labelLarge          // heading-xs: 16pt
        }
    }
    var tracking: CGFloat {
        switch self {
        case .small:  return 1.2
        case .medium: return 1.0
        }
    }
}

enum ZodiakEyebrowBackground {
    /// Superfície clara — texto usa textPrimary (#171a22)
    case onLite
    /// Superfície escura — texto usa textInverse (branco)
    case onHeavy
}

struct ZodiakEyebrow: View {
    let text: String
    var size: ZodiakEyebrowSize = .medium
    var background: ZodiakEyebrowBackground = .onLite

    var body: some View {
        // Em-dash (item 1) + Text (item 2) — Zodiak Eyebrow anatomy
        // LocalizedStringKey lookup ensures keys like "app.tab.overview" resolve to their translated values.
        // Text string interpolation replaces the deprecated + operator (deprecated iOS 26).
        Text("— \(Text(LocalizedStringKey(text)))")
            .font(size.font)
            .fontWeight(.semibold)
            .tracking(size.tracking)
            .foregroundColor(labelColor)
            .textCase(.uppercase)
            .lineLimit(1)
            .accessibilityLabel(Text(LocalizedStringKey(text)))
            .accessibilityAddTraits(.isHeader)
    }

    private var labelColor: Color {
        switch background {
        case .onLite:  return ZodiakColors.textPrimary
        case .onHeavy: return ZodiakColors.textAlwaysWhite
        }
    }
}

// MARK: - Previews

#Preview("Eyebrow") {
    VStack(alignment: .leading, spacing: ZodiakSpacing.s24) {
        Group {
            ZodiakEyebrow(text: "Category label", size: .medium, background: .onLite)
            ZodiakEyebrow(text: "Category label", size: .small, background: .onLite)
        }
        .padding(ZodiakSpacing.s16)
        .background(ZodiakColors.background)

        Group {
            ZodiakEyebrow(text: "Category label", size: .medium, background: .onHeavy)
            ZodiakEyebrow(text: "Category label", size: .small, background: .onHeavy)
        }
        .padding(ZodiakSpacing.s16)
        .background(ZodiakColors.surfaceInk)
    }
    .padding()
}
