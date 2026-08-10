import SwiftUI

// MARK: - Zodiak Pin
// Figma: Organisms > Feedback and Status > Pin
// An annotation pin used to mark points on images, maps or canvas surfaces.

// MARK: - Pin Style

enum ZodiakPinStyle {
    case primary     // filled brand color
    case secondary   // surface + border
    case danger      // negative / error
    case success     // positive
}

// MARK: - ZodiakPin (single annotated dot)

struct ZodiakPin: View {
    var label: String?
    var icon: String?        // SF Symbol; shown inside pin if no label
    var style: ZodiakPinStyle = .primary
    var size: ZodiakPinSize = .medium
    var isSelected: Bool = false
    var onTap: (() -> Void)?

    enum ZodiakPinSize {
        case small, medium, large
        var diameter: CGFloat {
            switch self {
            case .small: return 28
            case .medium: return 36
            case .large: return 48
            }
        }
        var tailHeight: CGFloat { diameter * 0.45 }
        var labelFont: Font {
            switch self {
            case .small: return ZodiakTypography.captionLarge
            default: return ZodiakTypography.bodySmall
            }
        }
    }

    private var fillColor: Color {
        switch style {
        case .primary:   return ZodiakColors.actionPrimary
        case .secondary: return ZodiakColors.surface
        case .danger:    return ZodiakColors.surfaceNegative
        case .success:   return ZodiakColors.surfacePositive
        }
    }

    private var contentColor: Color {
        switch style {
        case .primary:   return ZodiakColors.textInverse    // branco sobre azul marca
        case .secondary: return ZodiakColors.textPrimary    // escuro sobre branco
        case .danger:    return ZodiakColors.textNegative   // vermelho escuro sobre vermelho claro
        case .success:   return ZodiakColors.textPrimary    // escuro sobre verde claro
        }
    }

    private var borderColor: Color {
        isSelected ? ZodiakColors.actionPrimary : (style == .secondary ? ZodiakColors.borderPrimary : fillColor)
    }

    var body: some View {
        Button {
            onTap?()
        } label: {
            ZStack(alignment: .top) {
                // 1. Forma unificada (círculo + tail) — fill
                PinShape()
                    .fill(fillColor)
                    .shadow(
                        color: fillColor.opacity(0.4),
                        radius: isSelected ? 6 : 3,
                        x: 0,
                        y: 2
                    )

                // 2. Borda: stroke na forma unificada (secondary apenas)
                //    Nunca há artefacto porque é o mesmo path do fill.
                if style == .secondary {
                    PinShape()
                        .stroke(borderColor, lineWidth: 1.5)
                }

                // 3. Estado selecionado: ring branco interno (apenas na bolha)
                if isSelected {
                    Circle()
                        .strokeBorder(ZodiakColors.surface, lineWidth: 2)
                        .padding(1)
                        .frame(width: size.diameter, height: size.diameter)
                }

                // 4. Conteúdo centralizado na bolha (área superior diameter × diameter)
                Group {
                    if let label {
                        Text(LocalizedStringKey(label))
                            .font(size.labelFont)
                            .foregroundColor(contentColor)
                            .lineLimit(1)
                    } else if let icon {
                        Image(systemName: icon)
                            .font(.system(size: size.diameter * 0.38, weight: .medium))
                            .foregroundColor(contentColor)
                    } else {
                        Circle()
                            .fill(contentColor.opacity(0.9))
                            .frame(width: size.diameter * 0.25, height: size.diameter * 0.25)
                    }
                }
                .frame(width: size.diameter, height: size.diameter)
            }
            .frame(width: size.diameter, height: size.diameter + size.tailHeight)
            .scaleEffect(isSelected ? 1.15 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.65), value: isSelected)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Text(label ?? icon ?? "catalog.component_name.pin"))
        .accessibilityAddTraits(onTap != nil ? .isButton : [])
    }
}

// MARK: - PinShape (path único: arco do círculo + tail triangular)
//
// Desenha o contorno completo do pin como um único path contínuo:
//   1. Arco do ponto de junção direito, passando pelo topo, até ao ponto de junção esquerdo
//   2. Linha até à ponta inferior do tail
//   3. Fecha (linha de volta ao ponto de junção direito)
//
// Recebe rect onde width == diameter e height == diameter + tailHeight.

private struct PinShape: Shape {
    /// Largura do tail no ponto de junção como fração do diâmetro.
    var tailWidthRatio: CGFloat = 0.36

    func path(in rect: CGRect) -> Path {
        let d  = rect.width
        let r  = d / 2
        let cx = rect.midX
        let cy = r  // centro do círculo no topo do rect

        // Ângulo de junção tail-círculo:
        //   cos(θ) = halfTailWidth / r = (tailWidthRatio * d / 2) / r = tailWidthRatio
        //   Erro anterior: usava tailWidthRatio/2 (factor de 2 errado)
        let cosA = tailWidthRatio
        let sinA = sqrt(max(0, 1 - cosA * cosA))

        // Ângulos em coordenadas SwiftUI (0° = direita, 90° = baixo, CW na tela)
        let startAngle = Angle(radians: atan2(Double(sinA), Double(cosA)))  // junção direita (~69°)
        let endAngle   = Angle(radians: atan2(Double(sinA), -Double(cosA)))  // junção esquerda (~111°)

        var path = Path()
        // clockwise: true → em SwiftUI y-down aparece ANTI-HORÁRIO no ecrã
        //   → percorre o arco LONGO (pelo topo), de ~69° até ~111° passando por 270°(topo)
        // clockwise: false (erro anterior) → percorria o arco CURTO pelo fundo (~20°),
        //   resultando só num pequeno triângulo sem bolha visível
        path.addArc(
            center: CGPoint(x: cx, y: cy),
            radius: r,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )
        // Linha da junção esquerda à ponta inferior do tail
        path.addLine(to: CGPoint(x: cx, y: rect.maxY))
        // Fecha: volta da ponta à junção direita (lado direito do tail)
        path.closeSubpath()
        return path
    }
}

// MARK: - ZodiakPinMap (overlay container that positions pins on an image)
// Place pins by setting their relative position (0–1 range for x/y).

struct ZodiakPinMapItem: Identifiable {
    let id: UUID
    let relativeX: CGFloat   // 0.0 – 1.0
    let relativeY: CGFloat   // 0.0 – 1.0
    let pin: ZodiakPin
    let callout: String?

    init(
        id: UUID = UUID(),
        relativeX: CGFloat,
        relativeY: CGFloat,
        pin: ZodiakPin,
        callout: String? = nil
    ) {
        self.id = id
        self.relativeX = relativeX
        self.relativeY = relativeY
        self.pin = pin
        self.callout = callout
    }
}

struct ZodiakPinMap: View {
    let backgroundSystemImage: String
    let pins: [ZodiakPinMapItem]
    var aspectRatio: CGFloat = 16 / 9

    @State private var activePinID: UUID?

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                // Background
                ZStack {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [ZodiakColors.surfaceSmoke, ZodiakColors.surfaceAzur],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    Image(systemName: backgroundSystemImage)
                        .font(.system(size: 64, weight: .ultraLight))
                        .foregroundColor(ZodiakColors.textSecondary.opacity(0.2))
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()

                // Pins
                ForEach(pins) { item in
                    let x = item.relativeX * geo.size.width
                    let y = item.relativeY * geo.size.height

                    ZStack(alignment: .bottom) {
                        item.pin

                        // Callout bubble above pin
                        if let callout = item.callout, activePinID == item.id {
                            Text(callout)
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textPrimary)
                                .padding(.horizontal, ZodiakSpacing.s4)
                                .padding(.vertical, ZodiakSpacing.s4)
                                .background(ZodiakColors.surface)
                                .cornerRadius(ZodiakRadii.xs)
                                .shadow(color: Color.black.opacity(0.12), radius: 4, x: 0, y: 2)
                                .fixedSize()
                                .offset(y: -(item.pin.size.diameter + item.pin.size.tailHeight + 8))
                        }
                    }
                    .position(x: x, y: y)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            activePinID = activePinID == item.id ? nil : item.id
                        }
                    }
                }
            }
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s))
    }
}

// MARK: - Previews

#Preview("Pins") {
    VStack(spacing: ZodiakSpacing.s8) {
        HStack(spacing: ZodiakSpacing.s8) {
            ZodiakPin(icon: "mappin", style: .primary, size: .medium)
            ZodiakPin(label: "A", style: .secondary, size: .medium)
            ZodiakPin(icon: "exclamationmark", style: .danger, size: .medium)
            ZodiakPin(icon: "checkmark", style: .success, size: .medium)
            ZodiakPin(label: "1", style: .primary, size: .large, isSelected: true)
        }
        .padding()

        ZodiakPinMap(
            backgroundSystemImage: "map.fill",
            pins: [
                .init(relativeX: 0.2, relativeY: 0.3,
                      pin: ZodiakPin(icon: "building.2", style: .primary, size: .medium),
                      callout: "Paris HQ"),
                .init(relativeX: 0.55, relativeY: 0.5,
                      pin: ZodiakPin(label: "B", style: .secondary, size: .medium),
                      callout: "Lyon Office"),
                .init(relativeX: 0.75, relativeY: 0.25,
                      pin: ZodiakPin(icon: "star", style: .success, size: .small),
                      callout: "Partner site")
            ]
        )
        .padding()
    }
}
