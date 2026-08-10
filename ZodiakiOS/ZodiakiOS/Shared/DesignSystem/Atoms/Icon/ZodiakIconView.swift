import SwiftUI

// MARK: - ZodiakIconView
// Fonte: Zodiak Design System – Capgemini (visual-assets/icons/)
//
// Color rules (spec):
//   • Use Content colors (ZodiakColors.textPrimary/Secondary) for non-interactive icons.
//   • Use Action colors (ZodiakColors.actionPrimary) for links and interactive icons.
//
// ⚠️ Missing asset indicator: if a ZodiakIcon imageset is absent from Assets.xcassets,
//    the view renders a red "questionmark.circle" — a deliberate signal to add the asset.

/// A Zodiak Design System icon view that renders a named icon at a canonical size.
///
/// ## Usage
/// ```swift
/// ZodiakIconView(.arrowRight, size: .medium)
/// ZodiakIconView(.bell, size: .small, color: ZodiakColors.brand, isDecorative: true)
/// ```
///
/// Set `isDecorative: true` for purely ornamental icons that should be hidden from
/// VoiceOver (e.g., decorative row separators).
struct ZodiakIconView: View {
    let icon: ZodiakIcon
    let size: ZodiakIconSize
    let color: Color
    /// When `true`, the icon is hidden from assistive technologies.
    var isDecorative: Bool

    @Environment(\.redactionReasons) private var redactionReasons

    init(
        _ icon: ZodiakIcon,
        size: ZodiakIconSize = .medium,
        color: Color = ZodiakColors.textPrimary,
        isDecorative: Bool = false
    ) {
        self.icon = icon
        self.size = size
        self.color = color
        self.isDecorative = isDecorative
    }

    var body: some View {
        Group {
            if redactionReasons.contains(.placeholder) {
                // SF Symbols don't redact natively — render a shape placeholder instead.
                Circle()
                    .fill(ZodiakColors.borderPrimary)
            } else {
                iconImage
                    .foregroundStyle(color)
            }
        }
        .frame(width: size.dimension, height: size.dimension)
        .accessibilityLabel(icon.accessibilityLabel)
        .accessibilityHidden(isDecorative)
    }

    // MARK: - Private

    @ViewBuilder
    private var iconImage: some View {
        if UIImage(named: icon.imageName) != nil {
            Image(icon.imageName)
                .resizable()
                .scaledToFit()
                .flipsForRightToLeftLayoutDirection(icon.shouldMirrorForRTL)
        } else {
            // Red indicator: asset missing from Assets.xcassets — add the imageset to fix.
            Image(systemName: "questionmark.circle")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.red)
        }
    }
}

// MARK: - Preview

#Preview("Icon sizes") {
    VStack(spacing: ZodiakSpacing.s24) {
        Text("ZodiakIconView")
            .font(ZodiakTypography.captionLarge)
            .foregroundStyle(ZodiakColors.textSecondary)

        HStack(spacing: ZodiakSpacing.s16) {
            ZodiakIconView(.user, size: .small)
            ZodiakIconView(.user, size: .medium)
            ZodiakIconView(.user, size: .large)
            ZodiakIconView(.user, size: .xLarge)
        }

        HStack(spacing: ZodiakSpacing.s16) {
            ZodiakIconView(.settings, size: .medium, color: ZodiakColors.textSecondary)
            ZodiakIconView(.bell, size: .medium, color: ZodiakColors.brand)
            ZodiakIconView(.close, size: .medium, color: ZodiakColors.textNegative)
            ZodiakIconView(.star, size: .medium, isDecorative: true)
        }
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}
