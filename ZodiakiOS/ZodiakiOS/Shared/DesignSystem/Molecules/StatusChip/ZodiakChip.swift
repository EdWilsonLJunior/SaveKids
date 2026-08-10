import SwiftUI

/// Chip de status — radius pill (999pt) conforme Zodiak
struct ZodiakChip: View {
    private let label: Text
    let isActive: Bool
    var onTap: () -> Void = {}

    /// Localiza `text` via `LocalizedStringKey` — use para chaves de localização.
    init(text: LocalizedStringKey, isActive: Bool, onTap: @escaping () -> Void = {}) {
        self.label = Text(text)
        self.isActive = isActive
        self.onTap = onTap
    }

    /// Exibe `verbatim` sem localização — use para conteúdo dinâmico (nomes, dados do servidor).
    init(verbatim: String, isActive: Bool, onTap: @escaping () -> Void = {}) {
        self.label = Text(verbatim: verbatim)
        self.isActive = isActive
        self.onTap = onTap
    }

    var body: some View {
        HStack(spacing: ZodiakSpacing.s4) {
            if isActive {
                Image(systemName: "checkmark")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(ZodiakColors.textInverse)
            }
            label
                .font(ZodiakTypography.captionLarge)
                .tracking(ZodiakTypography.BodySize.xs.tracking)
                .foregroundColor(isActive ? ZodiakColors.textInverse : ZodiakColors.textSecondary)
        }
        .padding(.horizontal, ZodiakSpacing.s8)
        .padding(.vertical, ZodiakSpacing.s4)
        .background(isActive ? ZodiakColors.actionPrimary : ZodiakColors.borderPrimary)
        .cornerRadius(ZodiakRadii.l)
        .onTapGesture { onTap() }
        .accessibilityAddTraits(.isButton)
        .accessibilityValue(isActive ? "catalog.spec.state_active_lower" : "catalog.spec.state_inactive_lower")
        .zodiakA11yID("chip", role: "status")
    }
}

#Preview {
    HStack(spacing: ZodiakSpacing.s8) {
        ZodiakChip(text: "shared.state.active", isActive: true)
        ZodiakChip(text: "Inativo", isActive: false)
    }
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.background)
}
