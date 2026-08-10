import SwiftUI

// MARK: - Zodiak Banner
// Figma: "catalog.component_name.banner" — full-width promotional or status strip, typically pinned at top/bottom

/// Variante visual do banner: controla cor de fundo e ícone exibido.
public enum ZodiakBannerVariant {
    /// Variantes disponíveis: marca, informação, sucesso, aviso e erro.
    case brand, info, success, warning, error

    var backgroundColor: Color {
        switch self {
        case .brand:   return ZodiakColors.surfaceInk
        case .info:    return ZodiakColors.surfaceMarine
        case .success: return ZodiakColors.bannerSuccess
        case .warning: return ZodiakColors.bannerWarning
        case .error:   return ZodiakColors.bannerError
        }
    }

    var icon: String? {
        switch self {
        case .brand:   return nil
        case .info:    return "info.circle.fill"
        case .success: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .error:   return "xmark.circle.fill"
        }
    }
}

public struct ZodiakBanner: View {
    let message: String
    let variant: ZodiakBannerVariant
    let cta: (label: String, action: () -> Void)?
    let isDismissible: Bool

    @State private var isVisible = true

    public init(
        message: String,
        variant: ZodiakBannerVariant = .brand,
        cta: (label: String, action: () -> Void)? = nil,
        isDismissible: Bool = false
    ) {
        self.message = message
        self.variant = variant
        self.cta = cta
        self.isDismissible = isDismissible
    }

    public var body: some View {
        if isVisible {
            HStack(spacing: ZodiakSpacing.s8) {
                if let icon = variant.icon {
                    Image(systemName: icon)
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                }

                Text(LocalizedStringKey(message))
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer(minLength: 0)

                if let cta {
                    Button(cta.label, action: cta.action)
                        .font(ZodiakTypography.captionLarge.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, ZodiakSpacing.s4)
                        .padding(.vertical, ZodiakSpacing.s4)
                        .overlay(
                            RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                                .stroke(.white.opacity(0.5), lineWidth: 1)
                        )
                        .zodiakA11yID("banner", role: "cta")
                }

                if isDismissible {
                    Button {
                        withAnimation(.easeOut(duration: 0.2)) { isVisible = false }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .zodiakA11yID("banner")
                }
            }
            .padding(.horizontal, ZodiakSpacing.s16)
            .padding(.vertical, ZodiakSpacing.s8)
            .background(variant.backgroundColor)
            .transition(.move(edge: .top).combined(with: .opacity))
        }
    }
}
