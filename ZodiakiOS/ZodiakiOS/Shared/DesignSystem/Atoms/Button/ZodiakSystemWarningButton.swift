import SwiftUI

// MARK: - Zodiak System Warning Buttons
// Figma: "Button system — warning" (primary + secondary variants)
// Spec: rectangular (corner xs), S(38px)/M(48px), max 312px.
// Warning icon FIXED — do not remove (spec mandatory).
// Requires confirmation dialog before completing destructive action.

// MARK: - Primary Variant

struct ZodiakSystemWarningButton: View {
    let title: LocalizedStringKey
    let action: () -> Void
    var size: ZodiakButtonSize = .small
    var isEnabled: Bool = true
    var confirmationTitle: LocalizedStringKey?
    var confirmationMessage: LocalizedStringKey?

    @State private var showConfirmation = false

    private var resolvedHeight: CGFloat {
        size == .medium ? ZodiakSizing.buttonHeightMedium : ZodiakSizing.buttonHeightSmall
    }

    var body: some View {
        Button {
            if confirmationTitle != nil {
                showConfirmation = true
            } else {
                action()
            }
        } label: {
            HStack(spacing: ZodiakSpacing.s4) {
                Image(ZodiakIcon.octagonWarning.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                Text(title)
                    .font(ZodiakTypography.bodySmall)
            }
            .foregroundColor(isEnabled ? ZodiakColors.textInverse : ZodiakColors.actionDisabledContent)
            .padding(.horizontal, ZodiakSpacing.s8)
            .frame(height: resolvedHeight)
            .frame(maxWidth: 312)
            .background(isEnabled ? ZodiakColors.actionWarningSecondary : ZodiakColors.actionDisabled)
            .cornerRadius(ZodiakRadii.xs)
        }
        .disabled(!isEnabled)
        .zodiakFocusRing(cornerRadius: ZodiakRadii.xs)
        .accessibilityLabel(Text(title))
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(isEnabled ? "shared.state.destructive_action" : "shared.state.unavailable")
        .zodiakA11yID("button", role: "system.warning")
        .confirmationDialog(
            confirmationTitle ?? "",
            isPresented: $showConfirmation,
            titleVisibility: .visible
        ) {
            Button(role: .destructive, action: action) { Text(title) }
            Button("shared.action.cancel", role: .cancel) {}
        } message: {
            if let msg = confirmationMessage { Text(msg) }
        }
    }
}

// MARK: - Secondary Variant

struct ZodiakSystemWarningSecondaryButton: View {
    let title: LocalizedStringKey
    let action: () -> Void
    var size: ZodiakButtonSize = .small
    var isEnabled: Bool = true
    var confirmationTitle: LocalizedStringKey?
    var confirmationMessage: LocalizedStringKey?

    @State private var showConfirmation = false

    private var resolvedHeight: CGFloat {
        size == .medium ? ZodiakSizing.buttonHeightMedium : ZodiakSizing.buttonHeightSmall
    }

    var body: some View {
        Button {
            if confirmationTitle != nil {
                showConfirmation = true
            } else {
                action()
            }
        } label: {
            HStack(spacing: ZodiakSpacing.s4) {
                Image(ZodiakIcon.octagonWarning.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                Text(title)
                    .font(ZodiakTypography.bodySmall)
            }
            .foregroundColor(isEnabled ? ZodiakColors.actionWarningSecondary : ZodiakColors.actionDisabledContent)
            .padding(.horizontal, ZodiakSpacing.s8)
            .frame(height: resolvedHeight)
            .frame(maxWidth: 312)
            .background(isEnabled ? .clear : ZodiakColors.actionDisabled)
            .cornerRadius(ZodiakRadii.xs)
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                    .stroke(
                        isEnabled ? ZodiakColors.actionWarningSecondary : ZodiakColors.actionDisabled,
                        lineWidth: 1.5
                    )
            )
        }
        .disabled(!isEnabled)
        .zodiakFocusRing(cornerRadius: ZodiakRadii.xs)
        .accessibilityLabel(Text(title))
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(isEnabled ? "shared.state.destructive_action" : "shared.state.unavailable")
        .zodiakA11yID("button", role: "system.warning")
        .confirmationDialog(
            confirmationTitle ?? "",
            isPresented: $showConfirmation,
            titleVisibility: .visible
        ) {
            Button(role: .destructive, action: action) { Text(title) }
            Button("shared.action.cancel", role: .cancel) {}
        } message: {
            if let msg = confirmationMessage { Text(msg) }
        }
    }
}

// MARK: - Preview

#Preview("System Warning Buttons") {
    VStack(spacing: ZodiakSpacing.s8) {
        HStack(spacing: ZodiakSpacing.s8) {
            ZodiakSystemWarningButton(
                title: "Descartar",
                action: {},
                confirmationTitle: "Descartar rascunho?",
                confirmationMessage: "Esta ação não pode ser desfeita."
            )
            ZodiakSystemWarningSecondaryButton(title: "Cancelar", action: {})
        }
        HStack(spacing: ZodiakSpacing.s8) {
            ZodiakSystemWarningButton(title: "Disabled", action: {}, isEnabled: false)
            ZodiakSystemWarningSecondaryButton(title: "Disabled", action: {}, isEnabled: false)
        }
    }
    .padding()
    .background(ZodiakColors.background)
}
