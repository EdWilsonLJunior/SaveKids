import SwiftUI

// MARK: - Card Arrow Indicator Size
// Spec "Arrow button": 4 tamanhos com altura, largura default/hover/pressed e stroke proporcionais.
// S: 12px/1px | M: 18px/1.4px | L: 24px/1.8px | XL: 40px/2.8px

enum ZodiakArrowButtonSize {
    case small, medium, large, xLarge

    var dimension: CGFloat {
        switch self {
        case .small:  return 12
        case .medium: return 18
        case .large:  return 24
        case .xLarge: return 40
        }
    }

    var pressedWidth: CGFloat {
        switch self {
        case .small:  return 16
        case .medium: return 23
        case .large:  return 30
        case .xLarge: return 50
        }
    }

    var strokeWidth: CGFloat {
        switch self {
        case .small:  return 1.0
        case .medium: return 1.4
        case .large:  return 1.8
        case .xLarge: return 2.8
        }
    }
}

// MARK: - Card Arrow Indicator Surface
// onLite: usa actionPrimary (#1d365a light / #fff dark).
// onHeavy / onPhoto: usa actionPrimaryOnHeavy (#fff both modes).

enum ZodiakArrowButtonSurface {
    case onLite, onHeavy, onPhoto
}

// MARK: - Zodiak Card Arrow Indicator
// Spec "Arrow button": ícone de seta puro, sem label, fundo transparente.
// Uso: em cards totalmente clicáveis onde alinhamento com texto importa.
// NÃO é substituto de ZodiakTertiaryButton — não tem label nem padding de botão.
// Animação: largura da seta cresce no pressed (aproximação iOS via GestureState).

struct ZodiakArrowButton: View {
    let action: () -> Void
    var size: ZodiakArrowButtonSize = .medium
    var surface: ZodiakArrowButtonSurface = .onLite
    var isEnabled: Bool = true
    /// Localized accessibility label. Default: `shared.action.navigate`.
    /// Override to provide context-specific descriptions (e.g. "Next slide", "View details").
    var accessibilityLabelKey: LocalizedStringKey = "shared.action.navigate"

    @GestureState private var isPressed = false
    @FocusState private var isFocused: Bool

    private var arrowColor: Color {
        guard isEnabled else { return ZodiakColors.actionDisabled }
        switch surface {
        case .onLite:
            return isPressed ? ZodiakColors.actionPressed : ZodiakColors.actionPrimary

        case .onHeavy, .onPhoto:
            return isPressed ? ZodiakColors.actionPressedOnHeavy : ZodiakColors.actionPrimaryOnHeavy
        }
    }

    private var currentWidth: CGFloat {
        isPressed ? size.pressedWidth : size.dimension
    }

    var body: some View {
        Button(action: action) {
            Canvas { context, canvasSize in
                let height = canvasSize.height
                let width = canvasSize.width
                let stroke = size.strokeWidth
                let midY = height / 2

                var path = Path()
                path.move(to: CGPoint(x: 0, y: midY))
                path.addLine(to: CGPoint(x: width - stroke, y: midY))
                let tipX = width - stroke / 2
                let armLen = height * 0.35
                path.move(to: CGPoint(x: tipX - armLen, y: midY - armLen))
                path.addLine(to: CGPoint(x: tipX, y: midY))
                path.addLine(to: CGPoint(x: tipX - armLen, y: midY + armLen))

                context.stroke(
                    path,
                    with: .color(arrowColor),
                    style: StrokeStyle(lineWidth: stroke, lineCap: .round, lineJoin: .round)
                )
            }
            .frame(width: currentWidth, height: size.dimension)
            .zodiakAnimation(.easeInOut(duration: 0.12), value: isPressed)
            .contentShape(Rectangle().inset(by: -12))
        }
        .buttonStyle(.plain)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .updating($isPressed) { _, state, _ in state = true }
        )
        .focused($isFocused)
        .disabled(!isEnabled)
        .overlay(
            RoundedRectangle(cornerRadius: 2)
                .stroke(ZodiakColors.actionFocus, lineWidth: 1)
                .opacity(isFocused ? 1 : 0)
                .padding(-3)
        )
        .accessibilityLabel(Text(accessibilityLabelKey))
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(isEnabled ? "" : "shared.state.unavailable")
        .zodiakA11yID("button", role: "arrow", context: surface == .onLite ? "lite" : "heavy")
    }
}

// MARK: - Previews

#Preview {
    VStack(spacing: ZodiakSpacing.s32) {
        GroupBox("onLite — S / M / L / XL / disabled") {
            HStack(spacing: ZodiakSpacing.s32) {
                ZodiakArrowButton(action: {}, size: .small)
                ZodiakArrowButton(action: {}, size: .medium)
                ZodiakArrowButton(action: {}, size: .large)
                ZodiakArrowButton(action: {}, size: .xLarge)
                ZodiakArrowButton(action: {}, size: .medium, isEnabled: false)
            }
            .padding(ZodiakSpacing.s8)
        }
        ZStack {
            RoundedRectangle(cornerRadius: ZodiakRadii.m)
                .fill(ZodiakColors.surfaceInk)
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                Text("onHeavy")
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textInverse)
                HStack(spacing: ZodiakSpacing.s32) {
                    ZodiakArrowButton(action: {}, size: .small, surface: .onHeavy)
                    ZodiakArrowButton(action: {}, size: .medium, surface: .onHeavy)
                    ZodiakArrowButton(action: {}, size: .large, surface: .onHeavy)
                    ZodiakArrowButton(action: {}, size: .xLarge, surface: .onHeavy)
                }
            }
            .padding(ZodiakSpacing.s16)
        }
        .frame(height: 100)
    }
    .padding(ZodiakSpacing.s16)
}
