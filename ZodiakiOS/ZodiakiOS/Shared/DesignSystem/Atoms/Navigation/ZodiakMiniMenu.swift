import SwiftUI

// MARK: - Zodiak Mini Menu
// Fonte: Zodiak Design System – Capgemini | Página "Mini menu"
// Specs: lista compacta de ações contextuais com ícones opcionais
// Uso: context menus, action sheets inline, menus secundários de navegação

struct ZodiakMiniMenuItem: Identifiable {
    let id: String
    let label: String
    var icon: String?
    var isDestructive: Bool = false
    var isDisabled: Bool = false
    let action: () -> Void
}

struct ZodiakMiniMenu: View {
    let items: [ZodiakMiniMenuItem]
    var showDividers: Bool = true

    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                menuItem(item)

                if showDividers && index < items.count - 1 {
                    ZodiakDivider(hierarchy: .secondary)
                        .padding(.horizontal, ZodiakSpacing.s16)
                }
            }
        }
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
        .zodiakShadow()
        .overlay(
            RoundedRectangle(cornerRadius: ZodiakRadii.s)
                .stroke(ZodiakColors.borderSecondary, lineWidth: 1)
        )
    }

    @ViewBuilder
    private func menuItem(_ item: ZodiakMiniMenuItem) -> some View {
        Button(action: item.action) {
            HStack(spacing: ZodiakSpacing.s8) {
                if let icon = item.icon {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .regular))
                        .frame(width: 20)
                        .foregroundColor(iconColor(for: item))
                }
                Text(LocalizedStringKey(item.label))
                    .font(ZodiakTypography.bodyMedium)
                    .foregroundColor(labelColor(for: item))
                    .tracking(ZodiakTypography.BodySize.m.tracking)
                Spacer(minLength: 0)
            }
            .padding(.horizontal, ZodiakSpacing.s16)
            .frame(height: 44)
            .contentShape(Rectangle())
        }
        .disabled(item.isDisabled)
        .accessibilityLabel(item.label)
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(item.isDisabled ? "shared.state.unavailable" : "")
        .zodiakA11yID("mini-menu")
    }

    private func labelColor(for item: ZodiakMiniMenuItem) -> Color {
        if item.isDisabled { return ZodiakColors.textDisabled }
        if item.isDestructive { return ZodiakColors.actionWarningSecondary }
        return ZodiakColors.textPrimary
    }

    private func iconColor(for item: ZodiakMiniMenuItem) -> Color {
        if item.isDisabled { return ZodiakColors.textDisabled }
        if item.isDestructive { return ZodiakColors.actionWarningSecondary }
        return ZodiakColors.actionPrimary
    }
}

// MARK: - Previews

#Preview("Mini Menu") {
    ZStack {
        ZodiakColors.background.ignoresSafeArea()
        ZodiakMiniMenu(items: [
            .init(id: "edit", label: "shared.action.edit", icon: "pencil", action: {}),
            .init(id: "share", label: "Partilhar", icon: "square.and.arrow.up", action: {}),
            .init(id: "copy", label: "Copiar link", icon: "link", action: {}),
            .init(id: "disabled", label: "Exportar", icon: "arrow.down.circle", isDisabled: true, action: {}),
            .init(id: "delete", label: "Eliminar", icon: "trash", isDestructive: true, action: {})
        ])
        .frame(width: 220)
        .padding(ZodiakSpacing.s16)
    }
}
