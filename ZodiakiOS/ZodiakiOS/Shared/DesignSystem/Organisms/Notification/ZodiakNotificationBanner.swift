import SwiftUI

// MARK: - Zodiak Notification Banner
// Figma: "Notification"
// Banner destacado para mensagens globais, diferente de toast e de notice inline.

enum ZodiakNotificationVariant {
    /// Informação — bg surfaceCloudLite (#eff0f4), accent actionActive (#3573c0)
    case information
    /// Positivo/sucesso — bg surface (branco), accent actionActive (#3573c0)
    case positive
    /// Aviso/negativo — bg surfaceNegative (#fbf2f3), accent textNegative (#9e0029)
    case warning

    var icon: String {
        switch self {
        case .information: return "info.circle.fill"
        case .positive:    return "checkmark.circle.fill"
        case .warning:     return "exclamationmark.triangle.fill"
        }
    }

    var accent: Color {
        switch self {
        case .information: return ZodiakColors.actionActive
        case .positive:    return ZodiakColors.actionActive
        case .warning:     return ZodiakColors.textNegative
        }
    }

    var background: Color {
        switch self {
        case .information: return ZodiakColors.background
        case .positive:    return ZodiakColors.surface
        case .warning:     return ZodiakColors.surfaceNegative
        }
    }
}

struct ZodiakNotificationBanner: View {
    let title: String
    var message: String?
    var variant: ZodiakNotificationVariant = .information
    var actionLabel: String?
    var action: (() -> Void)?
    var isDismissible: Bool = true
    /// Called when the dismiss (X) button is tapped.
    var onDismiss: (() -> Void)?

    @State private var isVisible = true

    var body: some View {
        if isVisible {
            HStack(alignment: .top, spacing: ZodiakSpacing.s8) {
                Image(systemName: variant.icon)
                    .font(.system(size: 18))
                    .foregroundColor(variant.accent)
                    .padding(.top, 1)

                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    Text(LocalizedStringKey(title))
                        .font(ZodiakTypography.bodySmall.bold())
                        .foregroundColor(ZodiakColors.textPrimary)

                    if let message {
                        Text(LocalizedStringKey(message))
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    if let actionLabel, let action {
                        ZodiakTextLink(
                            label: actionLabel,
                            action: action,
                            showIcon: false,
                            font: ZodiakTypography.captionLarge
                        )
                            .padding(.top, ZodiakSpacing.s4)
                    }
                }

                Spacer(minLength: 0)

                if isDismissible {
                    Button {
                        withAnimation(.easeOut(duration: 0.2)) { isVisible = false }
                        onDismiss?()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(ZodiakColors.textSecondary)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(Text("shared.action.close_notification"))
                }
            }
            .padding(ZodiakSpacing.s16)
            .background(variant.background)
            .overlay(alignment: .leading) {
                Rectangle()
                    .fill(variant.accent)
                    .frame(width: 4)
            }
            .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous)
                    .stroke(variant.accent.opacity(0.2), lineWidth: 1)
            )
        }
    }
}

#Preview("Notification Banner") {
    ScrollView {
        VStack(spacing: ZodiakSpacing.s16) {
            ZodiakNotificationBanner(
                title: "Atualização disponível",
                message: "Uma nova versão do catálogo já pode ser instalada.",
                variant: .information,
                actionLabel: "Atualizar",
                action: {}
            )

            ZodiakNotificationBanner(
                title: "Sincronização concluída",
                message: "Todos os dados foram enviados com sucesso.",
                variant: .positive
            )

            ZodiakNotificationBanner(
                title: "Atenção necessária",
                message: "Revise os campos destacados antes de continuar.",
                variant: .warning
            )
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
