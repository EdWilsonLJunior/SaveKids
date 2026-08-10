import SwiftUI

// MARK: - Zodiak Headline Section
// Figma: "Headline section"
// Cabeçalho reutilizável que apresenta o conteúdo principal de uma seção.
// Usado como submontagem em Card Grids, Key Figures e demais compositions.

enum ZodiakHeadlineSectionStyle {
    case plain
    case plainWithIntro
    case middleAligned
    case withFilter
}

enum ZodiakHeadlineSectionBackground {
    case page
    case fog

    var color: Color {
        switch self {
        case .page: return .clear
        case .fog:  return ZodiakColors.surface
        }
    }
}

struct ZodiakHeadlineSection: View {
    let title: String
    var eyebrow: String?
    var intro: String?
    var style: ZodiakHeadlineSectionStyle = .plain
    var background: ZodiakHeadlineSectionBackground = .page

    @Environment(\.horizontalSizeClass) private var sizeClass
    private var isRegularWidth: Bool { sizeClass == .regular }

    var body: some View {
        VStack(
            alignment: alignment,
            spacing: ZodiakSpacing.s8
        ) {
            if let eyebrow {
                ZodiakEyebrow(text: eyebrow, size: .medium, background: .onLite)
            }

            Text(LocalizedStringKey(title))
                .font(isRegularWidth ? ZodiakTypography.titleLarge : ZodiakTypography.titleMedium)
                .foregroundColor(ZodiakColors.textPrimary)
                .multilineTextAlignment(textAlignment)
                .fixedSize(horizontal: false, vertical: true)

            if showIntro, let intro {
                Text(LocalizedStringKey(intro))
                    .font(ZodiakTypography.bodyLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                    .multilineTextAlignment(textAlignment)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(maxWidth: .infinity, alignment: frameAlignment)
        .padding(background == .page ? 0 : ZodiakSpacing.s16)
        .background(background.color)
        .clipShape(RoundedRectangle(cornerRadius: background == .page ? 0 : ZodiakRadii.s, style: .continuous))
    }

    // MARK: - Computed layout helpers

    private var alignment: HorizontalAlignment {
        switch style {
        case .middleAligned: return .center
        default:             return .leading
        }
    }

    private var textAlignment: TextAlignment {
        switch style {
        case .middleAligned: return .center
        default:             return .leading
        }
    }

    private var frameAlignment: Alignment {
        switch style {
        case .middleAligned: return .center
        default:             return .leading
        }
    }

    private var showIntro: Bool {
        switch style {
        case .plainWithIntro, .withFilter: return true
        default:                           return false
        }
    }
}

#Preview("Headline Section") {
    ScrollView {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s32) {
            ZodiakHeadlineSection(
                title: "Explore our services",
                eyebrow: "What we do",
                style: .plain
            )

            ZodiakHeadlineSection(
                title: "Insights for modern engineering teams",
                eyebrow: "Engineering",
                // swiftlint:disable:next line_length
                intro: "A curated set of articles and guides to keep your team aligned on architecture, tooling and delivery.",
                style: .plainWithIntro
            )

            ZodiakHeadlineSection(
                title: "Our approach to innovation",
                eyebrow: "Methodology",
                intro: "Centered on outcomes, not outputs.",
                style: .middleAligned
            )

            ZodiakHeadlineSection(
                title: "Case studies",
                eyebrow: "Portfolio",
                intro: "Filter by industry or capability to find what matters most.",
                style: .withFilter,
                background: .fog
            )
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
