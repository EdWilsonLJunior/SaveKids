import SwiftUI

// MARK: - Zodiak Filter Button
// Figma: "Button filter" — opens a drawer/sheet with filter inputs
// Pill shape, badge count on active filters

struct ZodiakFilterButton: View {
    let action: () -> Void
    var activeFilterCount: Int = 0
    var isEnabled: Bool = true

    @Environment(\.locale) private var locale
    private var isActive: Bool { activeFilterCount > 0 }

    var body: some View {
        Button(action: action) {
            HStack(spacing: ZodiakSpacing.s4) {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 14, weight: .regular))
                Text("shared.label.filters")
                    .font(ZodiakTypography.button)
                if isActive {
                    Text(verbatim: "\(activeFilterCount)")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(ZodiakColors.textInverse)
                        .frame(minWidth: 18, minHeight: 18)
                        .background(ZodiakColors.actionPrimary)
                        .clipShape(Circle())
                }
            }
            .foregroundColor(isEnabled
                ? (isActive ? ZodiakColors.textInverse : ZodiakColors.actionPrimary)
                : ZodiakColors.actionDisabledContent)
            .padding(.horizontal, ZodiakSpacing.s16)
            .frame(height: ZodiakSizing.buttonHeightSmall)
            .background(resolvedBackground)
            .cornerRadius(ZodiakRadii.l)
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.l)
                    .stroke(resolvedBorder, lineWidth: 1.5)
            )
        }
        .disabled(!isEnabled)
        .accessibilityLabel(
            isActive
                // swiftlint:disable:next line_length
                ? Text(verbatim: String(format: String(localized: "shared.format.filters_active", locale: locale), activeFilterCount))
                : Text("shared.label.filters")
        )
        .accessibilityHint(isEnabled ? "shared.action.tap_to_open_filters" : "shared.state.unavailable")
        .accessibilityAddTraits(.isButton)
        .zodiakA11yID("button", role: "filter")
    }

    private var resolvedBackground: Color {
        guard isEnabled else { return ZodiakColors.actionDisabled }
        return isActive ? ZodiakColors.actionPrimary : .clear
    }

    private var resolvedBorder: Color {
        isEnabled ? ZodiakColors.actionPrimary : ZodiakColors.actionDisabled
    }
}

// MARK: - Preview

#Preview("Filter Button") {
    HStack(spacing: ZodiakSpacing.s8) {
        ZodiakFilterButton(action: {})
        ZodiakFilterButton(action: {}, activeFilterCount: 3)
        ZodiakFilterButton(action: {}, isEnabled: false)
    }
    .padding()
    .background(ZodiakColors.background)
}
