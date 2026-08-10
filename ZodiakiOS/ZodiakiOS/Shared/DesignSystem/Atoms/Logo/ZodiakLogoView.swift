import SwiftUI

// MARK: - ZodiakLogoView
// Fonte: Zodiak Design System – Capgemini (visual-assets/logo/)
//
// Spec enforcement:
//   • Wordmarks: never rendered below 175pt width.
//   • Spade symbol: never rendered below 24pt height.
//   • Aspect ratio always preserved (scaledToFit).
//   • Do not alter colors — assets are full-color SVGs.

struct ZodiakLogoView: View {
    let variant: ZodiakLogoVariant

    init(_ variant: ZodiakLogoVariant) {
        self.variant = variant
    }

    var body: some View {
        Image(variant.imageName)
            .resizable()
            .scaledToFit()
            .modifier(LogoSizeConstraint(variant: variant))
            .accessibilityLabel(variant.accessibilityLabel)
            .accessibilityAddTraits(.isImage)
    }
}

// MARK: - LogoSizeConstraint (internal)

private struct LogoSizeConstraint: ViewModifier {
    let variant: ZodiakLogoVariant

    func body(content: Content) -> some View {
        if variant.isSymbol {
            // Spade: height-driven, minimum 24pt
            content.frame(minHeight: variant.minimumHeight)
        } else {
            // Wordmark: width-driven, minimum 175pt
            content.frame(minWidth: variant.minimumWidth)
        }
    }
}

// MARK: - Preview

#Preview("Primary logos") {
    VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
        ZodiakLogoView(.capgemini)
            .frame(height: 32)

        ZodiakLogoView(.spade)
            .frame(height: 40)

        ZodiakLogoView(.capgeminiInvent)
            .frame(height: 32)

        ZodiakLogoView(.capgeminiEngineering)
            .frame(height: 32)
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}

#Preview("All logos") {
    ScrollView {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s24) {
            ForEach(ZodiakLogoVariant.allCases, id: \.imageName) { variant in
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    Text(variant.displayName)
                        .font(ZodiakTypography.captionLarge)
                        .foregroundStyle(ZodiakColors.textSecondary)
                    ZodiakLogoView(variant)
                        .frame(height: variant.isSymbol ? 32 : 28)
                }
            }
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}

#Preview("Logo on dark surface") {
    ZStack {
        ZodiakColors.surfaceInk.ignoresSafeArea()
        ZodiakLogoView(.capgemini)
            .frame(height: 32)
            .padding(ZodiakSpacing.s16)
    }
}
