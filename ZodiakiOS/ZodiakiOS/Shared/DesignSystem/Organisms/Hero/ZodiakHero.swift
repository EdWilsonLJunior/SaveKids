import SwiftUI

// MARK: - Zodiak Hero
// Adaptação SwiftUI das famílias de hero do Zodiak para iPhone/iPad.

enum ZodiakHeroStyle {
    case small
    case large
    case split
    case fullscreen
    case typographic(shape: ZodiakHeroTypographicShape = .v1)
}

enum ZodiakHeroTypographicShape: Int, CaseIterable {
    case v1, v2, v3, v4, v5
}

struct ZodiakHeroAction {
    let title: String
    let action: () -> Void
    var isSecondary: Bool = false
}

struct ZodiakHeroMetric: Identifiable {
    let id = UUID()
    let value: String
    let label: String
}

struct ZodiakHero: View {
    let eyebrow: String?
    let title: String
    let summary: String
    var style: ZodiakHeroStyle = .large
    var background: LinearGradient = ZodiakGradients.brand
    var mediaSystemImage: String?
    var primaryAction: ZodiakHeroAction?
    var secondaryAction: ZodiakHeroAction?
    var metrics: [ZodiakHeroMetric] = []

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.redactionReasons) private var redactionReasons

    private var isRegularWidth: Bool { horizontalSizeClass == .regular }

    var body: some View {
        Group {
            switch style {
            case .small:
                smallHero

            case .large:
                largeHero

            case .split:
                splitHero

            case .fullscreen:
                fullscreenHero

            case .typographic(let shape):
                typographicHero(shape: shape)
            }
        }
        .background {
            // LinearGradient doesn't redact natively — suppress it in skeleton mode.
            if redactionReasons.contains(.placeholder) {
                ZodiakColors.borderPrimary
            } else {
                background
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
    }

    private var smallHero: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            heroContent(maxTextWidth: nil)
        }
        .padding(ZodiakSpacing.s16)
    }

    private var largeHero: some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s24) {
            heroContent(maxTextWidth: isRegularWidth ? 720 : nil)

            if !metrics.isEmpty {
                metricsRow
            }
        }
        .padding(isRegularWidth ? ZodiakSpacing.s32 : ZodiakSpacing.s16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .bottomTrailing) {
            heroArtwork
                .padding(ZodiakSpacing.s16)
        }
    }

    private var splitHero: some View {
        Group {
            if isRegularWidth {
                HStack(spacing: ZodiakSpacing.s32) {
                    heroContent(maxTextWidth: 520)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    heroArtwork
                        .frame(maxWidth: .infinity)
                }
            } else {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s24) {
                    heroContent(maxTextWidth: nil)
                    heroArtwork
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(isRegularWidth ? ZodiakSpacing.s32 : ZodiakSpacing.s16)
    }

    private func heroContent(maxTextWidth: CGFloat?) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            if let eyebrow {
                ZodiakEyebrow(text: eyebrow, size: .medium, background: .onHeavy)
            }

            Text(LocalizedStringKey(title))
                .font(isRegularWidth ? ZodiakTypography.titleLarge : ZodiakTypography.titleMedium)
                .foregroundColor(ZodiakColors.textAlwaysWhite)
                .fixedSize(horizontal: false, vertical: true)

            Text(LocalizedStringKey(summary))
                .font(isRegularWidth ? ZodiakTypography.bodyLarge : ZodiakTypography.bodyMedium)
                .foregroundColor(ZodiakColors.textAlwaysWhite.opacity(0.88))
                .fixedSize(horizontal: false, vertical: true)

            if primaryAction != nil || secondaryAction != nil {
                HStack(spacing: ZodiakSpacing.s8) {
                    if let primaryAction {
                        ZodiakButtonPrimary(title: LocalizedStringKey(primaryAction.title), action: primaryAction.action)
                    }
                    if let secondaryAction {
                        if secondaryAction.isSecondary {
                            ZodiakButtonSecondary(
                                title: LocalizedStringKey(secondaryAction.title),
                                action: secondaryAction.action
                            )
                        } else {
                            ZodiakButtonTertiary(
                                title: LocalizedStringKey(secondaryAction.title),
                                action: secondaryAction.action
                            )
                        }
                    }
                }
                .padding(.top, ZodiakSpacing.s4)
            }
        }
        .frame(maxWidth: maxTextWidth, alignment: .leading)
    }

    private var metricsRow: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: ZodiakSpacing.s8), count: isRegularWidth ? 4 : 2),
            spacing: ZodiakSpacing.s8
        ) {
            ForEach(metrics) { metric in
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    Text(metric.value)
                        .font(ZodiakTypography.titleSmall)
                        .foregroundColor(ZodiakColors.textAlwaysWhite)
                    Text(LocalizedStringKey(metric.label))
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textAlwaysWhite.opacity(0.75))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(ZodiakSpacing.s8)
                .background(Color.white.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.s, style: .continuous))
            }
        }
    }

    // MARK: - Fullscreen Hero

    private var fullscreenHero: some View {
        ZStack(alignment: .bottomLeading) {
            // Overlay escuro sobre o background (gradiente/imagem)
            LinearGradient(
                colors: [Color.black.opacity(0.55), Color.black.opacity(0.15)],
                startPoint: .bottom,
                endPoint: .top
            )

            VStack(alignment: .leading, spacing: ZodiakSpacing.s24) {
                heroContent(maxTextWidth: isRegularWidth ? 760 : nil)
            }
            .padding(isRegularWidth ? ZodiakSpacing.s32 : ZodiakSpacing.s16)
            .padding(.bottom, ZodiakSpacing.s24)
        }
        .frame(minHeight: isRegularWidth ? 560 : 420)
    }

    // MARK: - Typographic Hero

    private func typographicHero(shape: ZodiakHeroTypographicShape) -> some View {
        ZStack(alignment: .bottomTrailing) {
            // Shape geométrico decorativo — cada variante usa uma forma diferente
            typographicShape(shape)

            VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
                heroContent(maxTextWidth: isRegularWidth ? 640 : nil)
                if !metrics.isEmpty {
                    metricsRow
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(isRegularWidth ? ZodiakSpacing.s32 : ZodiakSpacing.s16)
        }
        .frame(minHeight: isRegularWidth ? 340 : 280)
    }

    @ViewBuilder
    private func typographicShape(_ shape: ZodiakHeroTypographicShape) -> some View {
        let accent = ZodiakColors.brandOrange
        switch shape {
        case .v1: typographicShapeV1(accent: accent)
        case .v2: typographicShapeV2(accent: accent)
        case .v3: typographicShapeV3(accent: accent)
        case .v4: typographicShapeV4(accent: accent)
        case .v5: typographicShapeV5(accent: accent)
        }
    }

    @ViewBuilder
    private func typographicShapeV1(accent: Color) -> some View {
        Circle()
            .fill(accent.opacity(0.18))
            .frame(width: 320, height: 320)
            .offset(x: 80, y: 80)
    }

    @ViewBuilder
    private func typographicShapeV2(accent: Color) -> some View {
        Circle()
            .strokeBorder(accent.opacity(0.22), lineWidth: 40)
            .frame(width: 280, height: 280)
            .offset(x: 60, y: 60)
    }

    @ViewBuilder
    private func typographicShapeV3(accent: Color) -> some View {
        RoundedRectangle(cornerRadius: ZodiakRadii.m, style: .continuous)
            .fill(accent.opacity(0.15))
            .frame(width: 240, height: 400)
            .rotationEffect(.degrees(25))
            .offset(x: 60, y: -20)
    }

    @ViewBuilder
    private func typographicShapeV4(accent: Color) -> some View {
        ZStack {
            Circle()
                .fill(accent.opacity(0.12))
                .frame(width: 260, height: 260)
                .offset(x: 30, y: 30)
            Circle()
                .strokeBorder(accent.opacity(0.18), lineWidth: 24)
                .frame(width: 180, height: 180)
                .offset(x: 80, y: 80)
        }
    }

    @ViewBuilder
    private func typographicShapeV5(accent: Color) -> some View {
        VStack(spacing: ZodiakSpacing.s16) {
            ForEach(0..<5, id: \.self) { _ in
                Rectangle()
                    .fill(accent.opacity(0.14))
                    .frame(height: 3)
            }
        }
        .frame(width: 200)
        .rotationEffect(.degrees(-15))
        .offset(x: 60, y: 0)
    }

    @ViewBuilder
    private var heroArtwork: some View {
        if let mediaSystemImage {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.08))
                    .frame(width: isRegularWidth ? 240 : 160, height: isRegularWidth ? 240 : 160)
                Image(systemName: mediaSystemImage)
                    .font(.system(size: isRegularWidth ? 72 : 52, weight: .light))
                    .foregroundColor(ZodiakColors.brandOrange)
            }
        }
    }
}

#Preview("Hero") {
    ScrollView {
        VStack(spacing: ZodiakSpacing.s32) {
            ZodiakHero(
                eyebrow: "Featured",
                title: "A reusable hero for editorial and product surfaces.",
                // swiftlint:disable:next line_length
                summary: "Esse organismo cobre os padrões small, large e split sem depender de assets externos para funcionar no app.",
                style: .large,
                mediaSystemImage: "sparkles.rectangle.stack",
                primaryAction: .init(title: "Explorar", action: {}),
                secondaryAction: .init(title: "Saiba mais", action: {}, isSecondary: false),
                metrics: [
                    .init(value: "26", label: "blocos portados"),
                    .init(value: "167", label: "páginas mapeadas"),
                    .init(value: "100%", label: "SwiftUI"),
                    .init(value: "iPad", label: "layout adaptativo")
                ]
            )

            ZodiakHero(
                eyebrow: "Editorial",
                title: "Split hero optimized for larger layouts.",
                summary: "No iPad ele abre lado a lado; no iPhone empilha naturalmente sem exigir outra API.",
                style: .split,
                background: ZodiakGradients.marine,
                mediaSystemImage: "newspaper"
            )

            ZodiakHero(
                eyebrow: "Imersivo",
                title: "Hero fullscreen para páginas de alto impacto.",
                summary: "Ocupa todo o espaço disponível e aplica um overlay escuro para legibilidade.",
                style: .fullscreen,
                background: ZodiakGradients.azur,
                primaryAction: .init(title: "shared.action.watch", action: {}),
                secondaryAction: .init(title: "Saiba mais", action: {}, isSecondary: true)
            )

            ZodiakHero(
                eyebrow: "Artigo",
                title: "Hero tipográfico para páginas editoriais sem foto.",
                summary: "Forma geométrica e tipografia são os protagonistas desta variante.",
                style: .typographic(shape: .v1),
                background: ZodiakGradients.brand,
                primaryAction: .init(title: "Ler artigo", action: {})
            )

            ForEach(ZodiakHeroTypographicShape.allCases, id: \.rawValue) { shape in
                ZodiakHero(
                    eyebrow: "Shape V\(shape.rawValue + 1)",
                    title: "Variante tipográfica \(shape.rawValue + 1).",
                    summary: "Cada variante usa uma forma geométrica distinta como elemento decorativo.",
                    style: .typographic(shape: shape)
                )
            }
        }
        .padding(ZodiakSpacing.s16)
    }
    .background(ZodiakColors.background)
}
