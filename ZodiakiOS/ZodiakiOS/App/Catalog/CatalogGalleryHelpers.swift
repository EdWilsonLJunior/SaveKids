import SwiftUI

// MARK: - Gallery Header
// Shared header used across all Catalog gallery views.
// Uses ZodiakHeadlineSection for responsive typography (iPad: headline 32pt / iPhone: title1 24pt).
// The optional figmaRef line is catalog-specific (no DS equivalent).

@ViewBuilder
func galleryHeader(title: String, subtitle: String, figmaRef: String? = nil) -> some View {
    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
        ZodiakHeadlineSection(
            title: title,
            intro: subtitle,
            style: .plainWithIntro
        )
        if let figmaRef {
            HStack(spacing: ZodiakSpacing.s4) {
                Image(systemName: "square.grid.2x2")
                    .font(.caption2)
                    .foregroundColor(ZodiakColors.textDisabled)
                Text(verbatim: "Figma: \(figmaRef)")
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textDisabled)
            }
        }
    }
    .padding(.horizontal, ZodiakSpacing.screenPad)
}

// Overload for dynamic subtitles that must not pass through LocalizedStringKey.
// ZodiakHeadlineSection always wraps `intro` in Text(LocalizedStringKey(...)),
// which causes a pre-resolved String to be treated as a key, failing lookup
// and displaying the string in the system locale instead of the app locale.
@ViewBuilder
func galleryHeader(title: String, subtitleText: Text, figmaRef: String? = nil) -> some View {
    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            ZodiakHeadlineSection(title: title, style: .plain)
            subtitleText
                .font(ZodiakTypography.bodyLarge)
                .foregroundColor(ZodiakColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        if let figmaRef {
            HStack(spacing: ZodiakSpacing.s4) {
                Image(systemName: "square.grid.2x2")
                    .font(.caption2)
                    .foregroundColor(ZodiakColors.textDisabled)
                Text(verbatim: "Figma: \(figmaRef)")
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textDisabled)
            }
        }
    }
    .padding(.horizontal, ZodiakSpacing.screenPad)
}

// MARK: - Gallery Section Card
// Standardised section card used across all catalog gallery views.
// Wraps a titled section with card styling, replacing the manual
// VStack { Text("title").font(.title3); content }.cardStyle() pattern.

@ViewBuilder
func gallerySectionCard<Content: View>(
    title: LocalizedStringKey,
    @ViewBuilder content: () -> Content
) -> some View {
    VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
        Text(title)
            .font(ZodiakTypography.titleSmall)
            .foregroundColor(ZodiakColors.textPrimary)
        content()
    }
    .cardStyle()
    .padding(.horizontal, ZodiakSpacing.screenPad)
}
