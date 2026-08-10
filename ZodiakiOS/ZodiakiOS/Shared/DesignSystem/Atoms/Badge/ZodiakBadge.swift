import SwiftUI

// MARK: - ZodiakBadge (genérico)
// Radius: XS = 4pt | Font: caption Ubuntu-Regular 12pt

struct ZodiakBadge: View {
    private enum Label {
        case localized(LocalizedStringKey)
        case verbatim(String)
    }
    private let label: Label
    let backgroundColor: Color
    let foregroundColor: Color

    init(text: LocalizedStringKey, backgroundColor: Color, foregroundColor: Color) {
        self.label = .localized(text)
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }

    init(verbatim text: String, backgroundColor: Color, foregroundColor: Color) {
        self.label = .verbatim(text)
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }

    var body: some View {
        textView
            .font(ZodiakTypography.captionLarge)
            .tracking(ZodiakTypography.BodySize.xs.tracking)
            .foregroundColor(foregroundColor)
            .padding(.horizontal, ZodiakSpacing.s8)
            .padding(.vertical, ZodiakSpacing.s4)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.xs))
    }

    @ViewBuilder
    private var textView: some View {
        switch label {
        case .localized(let key): Text(key)
        case .verbatim(let str): Text(verbatim: str)
        }
    }
}

// MARK: - ZodiakSuccessBadge
// bg: surfacePositive (green-50 #eff7f5 / dark #0f2e22) | texto: textPrimary

struct ZodiakSuccessBadge: View {
    private let badge: ZodiakBadge

    init(text: LocalizedStringKey) {
        badge = ZodiakBadge(
            text: text,
            backgroundColor: ZodiakColors.surfacePositive,
            foregroundColor: ZodiakColors.textPrimary
        )
    }

    init(verbatim text: String) {
        badge = ZodiakBadge(
            verbatim: text,
            backgroundColor: ZodiakColors.surfacePositive,
            foregroundColor: ZodiakColors.textPrimary
        )
    }

    var body: some View { badge }
}

// MARK: - ZodiakErrorBadge
// bg: surfaceNegative (red-50) | texto: textNegative (#9e0029)

struct ZodiakErrorBadge: View {
    private let badge: ZodiakBadge

    init(text: LocalizedStringKey) {
        badge = ZodiakBadge(
            text: text,
            backgroundColor: ZodiakColors.surfaceNegative,
            foregroundColor: ZodiakColors.textNegative
        )
    }

    init(verbatim text: String) {
        badge = ZodiakBadge(
            verbatim: text,
            backgroundColor: ZodiakColors.surfaceNegative,
            foregroundColor: ZodiakColors.textNegative
        )
    }

    var body: some View { badge }
}

// MARK: - ZodiakWarningBadge
// Zodiak não tem warning amarelo — usa actionWarning (vermelho #f64059) | texto: textInverse

struct ZodiakWarningBadge: View {
    private let badge: ZodiakBadge

    init(text: LocalizedStringKey) {
        badge = ZodiakBadge(
            text: text,
            backgroundColor: ZodiakColors.actionWarning,
            foregroundColor: ZodiakColors.textInverse
        )
    }

    init(verbatim text: String) {
        badge = ZodiakBadge(
            verbatim: text,
            backgroundColor: ZodiakColors.actionWarning,
            foregroundColor: ZodiakColors.textInverse
        )
    }

    var body: some View { badge }
}

// MARK: - Preview
#Preview {
    VStack(spacing: ZodiakSpacing.s8) {
        ZodiakSuccessBadge(text: "shared.state.passed_decorated")
        ZodiakErrorBadge(text: "shared.state.failed_decorated")
        ZodiakWarningBadge(text: "catalog.spec.warning_badge")
        ZodiakBadge(
            text: "Custom",
            backgroundColor: ZodiakColors.surfaceAzur,
            foregroundColor: ZodiakColors.textInverse
        )
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}
