import SwiftUI

// MARK: - Zodiak Warning Button (Primary)
// Spec: pill shape, ícone exclamationmark.triangle.fill FIXO (não remover/alterar).
// Confirmação sempre obrigatória — confirmationTitle/Message são parâmetros requeridos.
// Tamanhos: small 38pt / medium 48pt (default) / large 56pt / máx 800px.
// Cores: bg actionWarningSecondary (#9e0029 light / #ff848b dark), text textInverse.

struct ZodiakWarningButton: View {
    let title: LocalizedStringKey
    let action: () -> Void
    var size: ZodiakButtonSize = .medium
    var isEnabled: Bool = true
    var confirmationTitle: LocalizedStringKey?
    var confirmationMessage: LocalizedStringKey?

    @State private var showConfirmation = false

    var body: some View {
        Button {
            if confirmationTitle != nil {
                showConfirmation = true
            } else {
                action()
            }
        } label: {
            HStack(spacing: ZodiakSpacing.s8) {
                Image(ZodiakIcon.octagonWarning.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size == .small ? 14 : 16, height: size == .small ? 14 : 16)
                Text(title)
            }
        }
        .disabled(!isEnabled)
        .zodiakWarningPrimaryButtonStyle(isEnabled: isEnabled, size: size)
        .zodiakFocusRing()
        .expandedTouchTarget()
        .accessibilityLabel(Text(title))
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(isEnabled ? "shared.state.destructive_action" : "shared.state.unavailable")
        .zodiakA11yID("button", role: "warning")
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

// MARK: - Zodiak Warning Secondary Button
// Spec: border 1.5px actionWarningSecondary, texto actionWarningSecondary, fundo transparente.
// Pressed: fundo actionWarningSecondaryHover, texto textInverse.

struct ZodiakWarningSecondaryButton: View {
    let title: LocalizedStringKey
    let action: () -> Void
    var size: ZodiakButtonSize = .medium
    var isEnabled: Bool = true
    var confirmationTitle: LocalizedStringKey?
    var confirmationMessage: LocalizedStringKey?

    @State private var showConfirmation = false

    var body: some View {
        Button {
            if confirmationTitle != nil {
                showConfirmation = true
            } else {
                action()
            }
        } label: {
            HStack(spacing: ZodiakSpacing.s8) {
                Image(ZodiakIcon.octagonWarning.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size == .small ? 14 : 16, height: size == .small ? 14 : 16)
                Text(title)
            }
        }
        .disabled(!isEnabled)
        .zodiakWarningSecondaryButtonStyle(isEnabled: isEnabled, size: size)
        .zodiakFocusRing()
        .expandedTouchTarget()
        .accessibilityLabel(Text(title))
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(isEnabled ? "shared.state.destructive_action" : "shared.state.unavailable")
        .zodiakA11yID("button", role: "warning")
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

// MARK: - Zodiak Warning Tertiary Button
// Spec: texto underline actionWarningSecondary, sem fundo. Hierarquia mínima.

struct ZodiakWarningTertiaryButton: View {
    let title: LocalizedStringKey
    let action: () -> Void
    var size: ZodiakButtonSize = .medium
    var isEnabled: Bool = true
    var confirmationTitle: LocalizedStringKey?
    var confirmationMessage: LocalizedStringKey?

    @State private var showConfirmation = false

    private var textFont: Font {
        size == .small ? ZodiakTypography.bodySmall : ZodiakTypography.button
    }

    var body: some View {
        Button {
            if confirmationTitle != nil {
                showConfirmation = true
            } else {
                action()
            }
        } label: {
            HStack(spacing: ZodiakSpacing.s8) {
                Image(ZodiakIcon.octagonWarning.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size == .small ? 14 : 16, height: size == .small ? 14 : 16)
                Text(title)
                    .font(textFont)
                    .underline()
            }
            .foregroundColor(isEnabled ? ZodiakColors.actionWarningSecondary : ZodiakColors.textDisabled)
        }
        .disabled(!isEnabled)
        .zodiakFocusRing(cornerRadius: ZodiakRadii.xs)
        .expandedTouchTarget()
        .accessibilityLabel(Text(title))
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(isEnabled ? "shared.state.destructive_action" : "shared.state.unavailable")
        .zodiakA11yID("button", role: "warning")
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

// MARK: - Warning Button Styles

struct ZodiakWarningPrimaryButtonStyle: ButtonStyle {
    var isEnabled: Bool = true
    var size: ZodiakButtonSize = .medium

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(size.font)
            .foregroundColor(isEnabled ? ZodiakColors.textInverse : ZodiakColors.actionDisabledContent)
            .frame(maxWidth: .infinity)
            .frame(height: size.height)
            .frame(maxWidth: 800)
            .background(
                isEnabled
                    ? (configuration.isPressed
                        ? ZodiakColors.actionWarningSecondaryHover
                        : ZodiakColors.actionWarningSecondary)
                    : ZodiakColors.actionDisabled
            )
            .cornerRadius(ZodiakRadii.l)
    }
}

struct ZodiakWarningSecondaryButtonStyle: ButtonStyle {
    var isEnabled: Bool = true
    var size: ZodiakButtonSize = .medium

    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed && isEnabled
        return configuration.label
            .font(size.font)
            .foregroundColor(
                isEnabled
                    ? (isPressed ? ZodiakColors.textInverse : ZodiakColors.actionWarningSecondary)
                    : ZodiakColors.actionDisabledContent
            )
            .frame(maxWidth: .infinity)
            .frame(height: size.height)
            .frame(maxWidth: 800)
            .background(
                isEnabled
                    ? (isPressed ? ZodiakColors.actionWarningSecondaryHover : .clear)
                    : ZodiakColors.actionDisabled
            )
            .cornerRadius(ZodiakRadii.l)
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.l)
                    .stroke(
                        isEnabled ? ZodiakColors.actionWarningSecondary : ZodiakColors.actionDisabled,
                        lineWidth: 1.5
                    )
            )
    }
}

// MARK: - View Extensions

extension View {
    func zodiakWarningPrimaryButtonStyle(
        isEnabled: Bool = true,
        size: ZodiakButtonSize = .medium
    ) -> some View {
        buttonStyle(ZodiakWarningPrimaryButtonStyle(isEnabled: isEnabled, size: size))
    }

    func zodiakWarningSecondaryButtonStyle(
        isEnabled: Bool = true,
        size: ZodiakButtonSize = .medium
    ) -> some View {
        buttonStyle(ZodiakWarningSecondaryButtonStyle(isEnabled: isEnabled, size: size))
    }
}

// MARK: - Previews

#Preview {
    ScrollView {
        VStack(spacing: ZodiakSpacing.s16) {
            ZodiakWarningButton(
                title: "Excluir conta",
                action: {},
                confirmationTitle: "Confirmar exclusão?",
                confirmationMessage: "Esta ação não pode ser desfeita."
            )
            ZodiakWarningButton(title: "Warning Primary (disabled)", action: {}, isEnabled: false)
            ZodiakWarningSecondaryButton(
                title: "Warning Secondary",
                action: {},
                confirmationTitle: "Tem certeza?",
                confirmationMessage: nil
            )
            ZodiakWarningSecondaryButton(
                title: "Warning Secondary (disabled)",
                action: {},
                isEnabled: false
            )
            ZodiakWarningTertiaryButton(title: "Warning Tertiary", action: {})
            ZodiakWarningTertiaryButton(title: "Warning Tertiary (disabled)", action: {}, isEnabled: false)
        }
        .padding(ZodiakSpacing.s16)
    }
}
