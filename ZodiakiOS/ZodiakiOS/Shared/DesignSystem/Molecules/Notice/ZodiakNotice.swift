import SwiftUI

// MARK: - Zodiak Notice
// Fonte: Zodiak Design System – Capgemini | Página "Notice"
// Specs: Category Warning / Success / Information
// Warning:     fill rgba(0.98,0.95,0.95) ≈ surfaceNegative — borda actionWarningSecondary
// Success:     fill branco/surface — borda textPositive
// Information: fill rgba(0.94,0.94,0.96) ≈ surfaceSmoke — borda actionPrimary

enum ZodiakNoticeCategory {
    case warning, success, information

    var icon: String {
        switch self {
        case .warning:     return "exclamationmark.triangle.fill"
        case .success:     return "checkmark.circle.fill"
        case .information: return "info.circle.fill"
        }
    }

    var iconColor: Color {
        switch self {
        case .warning:     return ZodiakColors.actionWarningSecondary
        case .success:     return ZodiakColors.textPositive
        case .information: return ZodiakColors.actionActive
        }
    }

    var backgroundColor: Color {
        switch self {
        case .warning:     return ZodiakColors.surfaceNegative
        case .success:     return ZodiakColors.surface
        case .information: return ZodiakColors.background
        }
    }

    var borderColor: Color {
        switch self {
        case .warning:     return ZodiakColors.actionWarningSecondary
        case .success:     return ZodiakColors.textPositive
        case .information: return ZodiakColors.actionActive
        }
    }

    var accessibilityCategory: String {
        switch self {
        case .warning:     return "shared.state.warning_label"
        case .success:     return "shared.state.success_label"
        case .information: return "shared.state.info_label"
        }
    }
}

struct ZodiakNotice: View {
    let title: String
    var message: String?
    var category: ZodiakNoticeCategory = .information
    var isDismissible: Bool = false
    var action: (() -> Void)?
    var actionLabel: String?
    var onDismiss: (() -> Void)?

    @State private var isVisible = true

    var body: some View {
        if isVisible {
            VStack(alignment: .leading, spacing: 0) {
                // Left accent bar
                HStack(alignment: .top, spacing: 0) {
                    Rectangle()
                        .fill(category.borderColor)
                        .frame(width: 4)

                    HStack(alignment: .top, spacing: ZodiakSpacing.s8) {
                        Image(systemName: category.icon)
                            .font(.system(size: 18))
                            .foregroundColor(category.iconColor)
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
                                ZodiakTextLink(label: actionLabel, action: action, font: ZodiakTypography.captionLarge)
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
                            .accessibilityLabel(Text("shared.action.close_notice"))
                            .zodiakA11yID("notice")
                        }
                    }
                    .padding(ZodiakSpacing.s8)
                }
            }
            .background(category.backgroundColor)
            .cornerRadius(ZodiakRadii.xs)
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                    .stroke(category.borderColor.opacity(0.3), lineWidth: 1)
            )
            .accessibilityElement(children: .combine)
            .accessibilityLabel(
                Text(verbatim: String(
                    format: "shared.format.label_value_suffix",
                    category.accessibilityCategory,
                    title,
                    message.map { ". \($0)" } ?? ""
                ))
            )
        }
    }
}

// MARK: - Previews

#Preview("Notice") {
    ScrollView {
        VStack(spacing: ZodiakSpacing.s16) {
            ZodiakNotice(
                title: "Aviso importante",
                message: "Esta ação pode afetar os dados existentes. Revise antes de continuar.",
                category: .warning,
                isDismissible: true
            )
            ZodiakNotice(
                title: "Operação concluída",
                message: "Seus dados foram salvos com sucesso.",
                category: .success
            )
            ZodiakNotice(
                title: "Saiba mais",
                message: "Esta funcionalidade está disponível apenas para contas premium.",
                category: .information,
                isDismissible: true,
                action: {},
                actionLabel: "Ver planos"
            )
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
