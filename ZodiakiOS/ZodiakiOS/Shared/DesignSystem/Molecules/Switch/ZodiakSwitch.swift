import SwiftUI

// MARK: - ZodiakSwitch
// Zodiak Design System — "Switch" (also known as: Toggle)
// Spec: 3 variants (no label, label right, label left), 2 sizes (small/large), spacing-xs in groups

/// Posição do label em relação ao switch.
enum ZodiakSwitchLabelPlacement {
    /// Label à esquerda, switch à direita (padrão Zodiak).
    case leading
    /// Label à direita, switch à esquerda.
    case trailing
    /// Sem label visível — accessibilityLabel obrigatório.
    case hidden
}

// MARK: - ZodiakSwitchState

/// Estado do `ZodiakSwitch`.
enum ZodiakSwitchState {
    /// Switch interativo (padrão).
    case normal
    /// Switch desabilitado.
    case disabled
}

/// Switch binário Zodiak. Label descreve o que acontece quando está ON.
struct ZodiakSwitch: View {
    let label: String
    @Binding var isOn: Bool
    /// Preferred API. When set, `isEnabled` is ignored.
    var state: ZodiakSwitchState?
    /// Deprecated: use `state: .disabled` instead.
    @available(*, deprecated, message: "Use state: .disabled instead.")
    var isEnabled: Bool = true
    var labelPlacement: ZodiakSwitchLabelPlacement = .leading
    @Environment(\.colorScheme) private var colorScheme

    var effectiveIsEnabled: Bool {
        if let state { return state != .disabled }
        return isEnabled
    }

    // actionPrimary dark = #FFF (branco puro) → thumb iOS também branco → invisível.
    // Em dark mode usa actionActive (azul médio) que contrasta com superfícies escuras.
    private var switchTint: Color {
        colorScheme == .dark ? ZodiakColors.actionActive : ZodiakColors.actionPrimary
    }

    var body: some View {
        HStack(spacing: ZodiakSpacing.s8) {
            if labelPlacement == .trailing {
                toggle
                ZodiakText(label, style: .body())
                Spacer()
            } else if labelPlacement == .leading {
                ZodiakText(label, style: .body())
                Spacer()
                toggle
            } else {
                toggle
            }
        }
    }

    private var toggle: some View {
        Toggle("", isOn: $isOn)
            .tint(switchTint)
            .labelsHidden()
            .disabled(!effectiveIsEnabled)
            .accessibilityLabel(label)
            .accessibilityValue(isOn ? Text("shared.accessibility.on") : Text("shared.accessibility.off"))
            .zodiakA11yID("switch")
    }
}

#Preview {
    VStack(spacing: ZodiakSpacing.s16) {
        ZodiakSwitch(label: "feature.pix.pay_with_pix", isOn: .constant(true))
        ZodiakSwitch(label: "feature.theme_toggle.enable_dark", isOn: .constant(false))
        ZodiakSwitch(label: "feature.theme_toggle.enable_dark", isOn: .constant(true), labelPlacement: .trailing)
        ZodiakSwitch(label: "feature.pix.pay_with_pix", isOn: .constant(false), labelPlacement: .hidden)
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}
