import SwiftUI

// MARK: - Zodiak Toast
// Figma: "Toast / Snackbar" — transient overlay notification with auto-dismiss

/// Variante visual do toast: controla cor do tint e ícone exibido.
public enum ZodiakToastVariant {
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
}

/// Configuração completa para exibição de um toast transiente.
public struct ZodiakToastConfig {
    /// Texto principal exibido no toast.
    public let message: String
    /// Variante visual que define cor e ícone.
    public let variant: ZodiakToastVariant
    /// Duração em segundos antes do auto-dismiss.
    public let duration: TimeInterval
    /// Ação CTA opcional; `nil` quando não há botão de ação.
    public let action: (label: String, handler: () -> Void)?

    /// Cria uma configuração de toast com os parâmetros especificados.
    public init(
        message: String,
        variant: ZodiakToastVariant = .info,
        duration: TimeInterval = 3.0,
        action: (label: String, handler: () -> Void)? = nil
    ) {
        self.message = message
        self.variant = variant
        self.duration = duration
        self.action = action
    }
}

// MARK: Toast View

struct ZodiakToastView: View {
    let config: ZodiakToastConfig
    let onDismiss: () -> Void
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        HStack(spacing: ZodiakSpacing.s8) {
            Image(systemName: config.variant.icon)
                .font(.system(size: 17))
                .foregroundColor(config.variant.tintColor(for: colorScheme))

            Text(config.message)
                .font(ZodiakTypography.bodySmall)
                .foregroundColor(ZodiakColors.textInverse)
                .lineLimit(2)

            Spacer(minLength: 0)

            if let action = config.action {
                Button(action.label, action: action.handler)
                    .font(ZodiakTypography.captionLarge.bold())
                    .foregroundColor(config.variant.tintColor(for: colorScheme))
            }

            Button {
                onDismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white.opacity(0.6))
            }
        }
        .padding(.horizontal, ZodiakSpacing.s16)
        .padding(.vertical, ZodiakSpacing.s8 + ZodiakSpacing.s4)
        .background(
            RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous)
                .fill(ZodiakColors.surfaceInk)
                .shadow(color: .black.opacity(0.25), radius: 12, y: 4)
        )
        .padding(.horizontal, ZodiakSpacing.s16)
    }
}

// MARK: ZodiakToastModifier

struct ZodiakToastModifier: ViewModifier {
    @Binding var toast: ZodiakToastConfig?
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content

            ZStack {
                if let t = toast {
                    ZodiakToastView(config: t) {
                        withAnimation(reduceMotion ? nil : .spring(response: 0.3)) { toast = nil }
                    }
                    .transition(reduceMotion ? .opacity : .move(edge: .bottom).combined(with: .opacity))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + t.duration) {
                            withAnimation(self.reduceMotion ? nil : .spring(response: 0.3)) { toast = nil }
                        }
                    }
                }
            }
            .zodiakAnimation(.spring(response: 0.4, dampingFraction: 0.85), value: toast == nil)
            .padding(.bottom, ZodiakSpacing.s16)
        }
    }
}

public extension View {
    /// Adiciona um toast ao elemento com configuração reativa via binding.
    func zodiakToast(_ toast: Binding<ZodiakToastConfig?>) -> some View {
        modifier(ZodiakToastModifier(toast: toast))
    }
}
