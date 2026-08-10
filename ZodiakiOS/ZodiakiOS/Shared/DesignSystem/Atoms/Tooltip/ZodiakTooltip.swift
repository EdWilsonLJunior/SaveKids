import SwiftUI

// MARK: - Zodiak Tooltip
// Figma: "catalog.component_name.tooltip" — contextual hint bubble anchored to a target

/// Posicionamento do tooltip em relação ao elemento âncora.
public enum ZodiakTooltipPlacement {
    /// Posições disponíveis: acima, abaixo, à esquerda e à direita.
    case top, bottom, leading, trailing
}

public struct ZodiakTooltip<Anchor: View>: View {
    let message: String
    let placement: ZodiakTooltipPlacement
    @ViewBuilder let anchor: () -> Anchor

    @State private var isVisible = false

    public init(
        _ message: String,
        placement: ZodiakTooltipPlacement = .top,
        @ViewBuilder anchor: @escaping () -> Anchor
    ) {
        self.message = message
        self.placement = placement
        self.anchor = anchor
    }

    public var body: some View {
        anchor()
            .onTapGesture {
                withAnimation(.spring(response: 0.25)) { isVisible.toggle() }
                if isVisible {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation(.spring(response: 0.25)) { isVisible = false }
                    }
                }
            }
            .overlay(alignment: overlayAlignment) {
                if isVisible {
                    tooltipBubble
                        .offset(tooltipOffset)
                        .transition(.opacity.combined(with: .scale(scale: 0.9, anchor: scaleAnchor)))
                }
            }
    }

    private var tooltipBubble: some View {
        Text(LocalizedStringKey(message))
            .font(ZodiakTypography.captionLarge)
            .foregroundColor(ZodiakColors.textInverse)
            .padding(.horizontal, ZodiakSpacing.s8)
            .padding(.vertical, ZodiakSpacing.s4)
            .frame(maxWidth: 230)
            .background(
                RoundedRectangle(cornerRadius: ZodiakRadii.xs, style: .continuous)
                    .fill(ZodiakColors.textPrimary)
                    .shadow(color: .black.opacity(0.20), radius: 6, y: 2)
            )
            .fixedSize(horizontal: false, vertical: true)
            .onTapGesture {
                withAnimation(.spring(response: 0.25)) { isVisible = false }
            }
    }

    private var overlayAlignment: Alignment {
        switch placement {
        case .top:      return .top
        case .bottom:   return .bottom
        case .leading:  return .leading
        case .trailing: return .trailing
        }
    }

    private var tooltipOffset: CGSize {
        switch placement {
        case .top:      return CGSize(width: 0, height: -36)
        case .bottom:   return CGSize(width: 0, height: 36)
        case .leading:  return CGSize(width: -8, height: 0)
        case .trailing: return CGSize(width: 8, height: 0)
        }
    }

    private var scaleAnchor: UnitPoint {
        switch placement {
        case .top:      return .bottom
        case .bottom:   return .top
        case .leading:  return .trailing
        case .trailing: return .leading
        }
    }
}

// MARK: View extension for ergonomic usage

public extension View {
    /// Adiciona um tooltip ao elemento com mensagem e posicionamento configuráveis.
    func zodiakTooltip(_ message: String, placement: ZodiakTooltipPlacement = .top) -> some View {
        ZodiakTooltip(message, placement: placement) { self }
    }
}
