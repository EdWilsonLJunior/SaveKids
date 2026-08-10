import SwiftUI

// MARK: - Zodiak Text Block
// Figma: "Text block"
// Estrutura de conteúdo textual com suporte a um ou dois parágrafos
// e heading opcional em dois níveis.

enum ZodiakTextBlockAlignment {
    case center
    case leading
    case twoColumn

    // Duas colunas só fazem sentido em iPad (horizontalSizeClass == .regular).
    // Em iPhone, `.twoColumn` recai em `.leading`.
}

struct ZodiakTextBlock: View {
    var headingLarge: String?
    let bodyText: String
    var headingSmall: String?
    var alignment: ZodiakTextBlockAlignment = .leading

    @Environment(\.horizontalSizeClass) private var sizeClass
    private var isRegularWidth: Bool { sizeClass == .regular }

    var body: some View {
        Group {
            if alignment == .twoColumn && isRegularWidth {
                twoColumnLayout
            } else {
                singleColumnLayout
            }
        }
    }

    // MARK: - Single column

    private var singleColumnLayout: some View {
        let textAlign: TextAlignment = (alignment == .center) ? .center : .leading
        let frameAlign: Alignment = (alignment == .center) ? .center : .leading
        let hAlign: HorizontalAlignment = (alignment == .center) ? .center : .leading

        return VStack(alignment: hAlign, spacing: ZodiakSpacing.s8) {
            if let headingLarge {
                Text(LocalizedStringKey(headingLarge))
                    .font(ZodiakTypography.titleSmall)
                    .foregroundColor(ZodiakColors.textPrimary)
                    .multilineTextAlignment(textAlign)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Text(LocalizedStringKey(bodyText))
                .font(ZodiakTypography.bodyMedium)
                .foregroundColor(ZodiakColors.textSecondary)
                .multilineTextAlignment(textAlign)
                .fixedSize(horizontal: false, vertical: true)

            if let headingSmall {
                Text(LocalizedStringKey(headingSmall))
                    .font(ZodiakTypography.bodySmall.bold())
                    .foregroundColor(ZodiakColors.textPrimary)
                    .multilineTextAlignment(textAlign)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, ZodiakSpacing.s4)
            }
        }
        .frame(maxWidth: .infinity, alignment: frameAlign)
    }

    // MARK: - Two-column (iPad only)

    private var twoColumnLayout: some View {
        HStack(alignment: .top, spacing: ZodiakSpacing.s32) {
            // Left column — heading + first half of body
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                if let headingLarge {
                    Text(LocalizedStringKey(headingLarge))
                        .font(ZodiakTypography.titleSmall)
                        .foregroundColor(ZodiakColors.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Right column — body text
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                Text(LocalizedStringKey(bodyText))
                    .font(ZodiakTypography.bodyMedium)
                    .foregroundColor(ZodiakColors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)

                if let headingSmall {
                    Text(LocalizedStringKey(headingSmall))
                        .font(ZodiakTypography.bodySmall.bold())
                        .foregroundColor(ZodiakColors.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, ZodiakSpacing.s4)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview("Text Block") {
    ScrollView {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s32) {
            ZodiakTextBlock(
                headingLarge: "Building design systems that last",
                // swiftlint:disable:next line_length
                bodyText: "A design system is only as good as the discipline used to maintain it. Consistency, documentation and adoption are the three pillars that determine whether a system becomes a true accelerator or just another library that sits unused."
            )

            ZodiakTextBlock(
                headingLarge: "Centered layout",
                // swiftlint:disable:next line_length
                bodyText: "Use this alignment for introductory or editorial text that benefits from a more symmetrical visual weight.",
                alignment: .center
            )

            ZodiakTextBlock(
                headingLarge: "Two-column layout",
                // swiftlint:disable:next line_length
                bodyText: "On iPad the heading appears on the left and the body on the right, creating a balanced newspaper-style composition. On iPhone it collapses to a single column automatically.",
                headingSmall: "Adapts to any viewport",
                alignment: .twoColumn
            )
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
