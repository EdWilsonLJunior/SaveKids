import SwiftUI

// MARK: - Zodiak Alert
// Figma: "catalog.component_name.alert" — inline status banner (info / success / warning / error)

/// Variante visual do alerta: controla cor de fundo, cor do ícone e próprio ícone.
public enum ZodiakAlertVariant {
    /// Variantes disponíveis: informação, sucesso, aviso e erro.
    case info, success, warning, error

    var icon: String {
        switch self {
        case .info:    return "info.circle.fill"
        case .success: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .error:   return "xmark.circle.fill"
        }
    }

    func tintColor(for scheme: ColorScheme) -> Color {
        switch self {
        case .info:    return ZodiakColors.actionPrimary
        case .success: return ZodiakColors.textPositive
        case .warning: return scheme == .dark ? ZodiakPrimitives.Yellow.shade400 : ZodiakPrimitives.Orange.shade600
        case .error:   return ZodiakColors.actionWarning
        }
    }

    func backgroundColor(for scheme: ColorScheme) -> Color {
        switch self {
        case .info:    return ZodiakColors.surfaceAzur.opacity(0.10)
        case .success: return ZodiakColors.surfacePositive
        case .warning: return scheme == .dark ? ZodiakPrimitives.Yellow.shade900 : ZodiakPrimitives.Yellow.shade200
        case .error:   return ZodiakColors.surfaceNegative
        }
    }
}

public struct ZodiakAlert: View {
    private let titleLabel: Text
    private let messageLabel: Text?
    let variant: ZodiakAlertVariant
    let isDismissible: Bool
    var onDismiss: (() -> Void)?
    @State private var isVisible = true
    @Environment(\.colorScheme) private var colorScheme

    /// Localizable init — use for static string keys from xcstrings.
    public init(
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        variant: ZodiakAlertVariant = .info,
        isDismissible: Bool = false,
        onDismiss: (() -> Void)? = nil
    ) {
        self.titleLabel = Text(title)
        self.messageLabel = message.map { Text($0) }
        self.variant = variant
        self.isDismissible = isDismissible
        self.onDismiss = onDismiss
    }

    /// Verbatim init — use for dynamic strings (server errors, user-generated content).
    public init(
        verbatim title: String,
        message: String? = nil,
        variant: ZodiakAlertVariant = .info,
        isDismissible: Bool = false,
        onDismiss: (() -> Void)? = nil
    ) {
        self.titleLabel = Text(verbatim: title)
        self.messageLabel = message.map { Text(verbatim: $0) }
        self.variant = variant
        self.isDismissible = isDismissible
        self.onDismiss = onDismiss
    }

    public var body: some View {
        if isVisible {
            HStack(alignment: .top, spacing: ZodiakSpacing.s8) {
                Image(systemName: variant.icon)
                    .font(.system(size: 18))
                    .foregroundColor(variant.tintColor(for: colorScheme))
                    .padding(.top, 1)

                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    titleLabel
                        .font(ZodiakTypography.bodySmall.bold())
                        .foregroundColor(ZodiakColors.textPrimary)
                    if let messageLabel {
                        messageLabel
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
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
                            .padding(ZodiakSpacing.s4)
                            .contentShape(Rectangle())
                    }
                    .accessibilityLabel(Text("shared.action.dismiss"))
                }
            }
            .padding(ZodiakSpacing.s8 + ZodiakSpacing.s4)
            .background(
                RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous)
                    .fill(variant.backgroundColor(for: colorScheme))
                    .overlay(
                        RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous)
                            .strokeBorder(variant.tintColor(for: colorScheme).opacity(0.25), lineWidth: 1)
                    )
            )
            .transition(.opacity.combined(with: .move(edge: .top)))
        }
    }
}
