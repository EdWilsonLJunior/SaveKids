import SwiftUI

// MARK: - Accessibility Gallery

private struct ContrastPair {
    let token: String
    let hex: String
    let background: String
    let level: String
}

struct AccessibilityGalleryView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var demoAngle: Double = 0
    @State private var isAnimating = false

    private let contrastPairs: [ContrastPair] = [
        ContrastPair(token: "textPrimary", hex: "#101317", background: "background", level: "AAA"),
        ContrastPair(token: "textSecondary", hex: "#6B7280", background: "background", level: "AA"),
        ContrastPair(token: "textInverse", hex: "#FFFFFF", background: "surfaceInk", level: "AAA"),
        ContrastPair(token: "textLink", hex: "#0058AB", background: "background", level: "AA"),
        ContrastPair(token: "textNegative", hex: "#D93E4B", background: "background", level: "AA"),
        ContrastPair(token: "textPositive", hex: "#20B87E", background: "surfaceInk", level: "AA")
    ]

    private let touchTargets: [(label: String, size: CGFloat, token: String)] = [
        ("buttonHeightSmall", ZodiakSizing.buttonHeightSmall, "38pt"),
        ("buttonHeightMedium", ZodiakSizing.buttonHeightMedium, "48pt"),
        ("buttonHeightLarge", ZodiakSizing.buttonHeightLarge, "56pt"),
        ("textFieldHeight", ZodiakSizing.textFieldHeight, "48pt")
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.accessibility.title",
                subtitle: "catalog.accessibility.subtitle",
                figmaRef: "WCAG 2.1 AA"
            )

            // MARK: Nível de Conformidade
            gallerySectionCard(title: "catalog.section.nivel_wcag") {
                HStack(spacing: ZodiakSpacing.s8) {
                    VStack(spacing: ZodiakSpacing.s4) {
                        Text(verbatim: "AA")
                            .font(ZodiakTypography.titleLarge)
                            .foregroundColor(ZodiakColors.actionPrimary)
                        Text("catalog.accessibility.wcag_nivel")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(ZodiakSpacing.s8)
                    .background(ZodiakColors.surface)
                    .cornerRadius(ZodiakRadii.s)

                    VStack(spacing: ZodiakSpacing.s4) {
                        Text(verbatim: "4.5:1")
                            .font(ZodiakTypography.titleLarge)
                            .foregroundColor(ZodiakColors.actionPrimary)
                        Text("catalog.accessibility.contraste_texto")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(ZodiakSpacing.s8)
                    .background(ZodiakColors.surface)
                    .cornerRadius(ZodiakRadii.s)

                    VStack(spacing: ZodiakSpacing.s4) {
                        Text(verbatim: "3:1")
                            .font(ZodiakTypography.titleLarge)
                            .foregroundColor(ZodiakColors.actionPrimary)
                        Text("catalog.accessibility.contraste_ui")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(ZodiakSpacing.s8)
                    .background(ZodiakColors.surface)
                    .cornerRadius(ZodiakRadii.s)
                }

                ZodiakInfoRow(
                    "catalog.spec.lbl.wcag_versao",
                    value: "catalog.spec.val.wcag_2_1",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.plataforma",
                    value: "catalog.spec.val.accessibility_ios_ipados",
                    style: .spec()
                )
            }

            // MARK: Pares de Contraste
            gallerySectionCard(title: "catalog.section.contraste_de_cores") {
                VStack(spacing: ZodiakSpacing.s4) {
                    ForEach(contrastPairs, id: \.token) { pair in
                        HStack(spacing: ZodiakSpacing.s8) {
                            Text(pair.hex)
                                .font(ZodiakTypography.captionLarge.monospaced())
                                .foregroundColor(ZodiakColors.textSecondary)
                                .frame(width: 80, alignment: .leading)

                            Text(pair.token)
                                .font(ZodiakTypography.bodySmall)
                                .foregroundColor(ZodiakColors.textPrimary)

                            Spacer()

                            Text(pair.level)
                                .font(ZodiakTypography.captionLarge.bold())
                                .foregroundColor(
                                    pair.level == "AAA"
                                    ? ZodiakColors.textPositive
                                    : ZodiakColors.actionPrimary
                                )
                                .padding(.horizontal, ZodiakSpacing.s4)
                                .padding(.vertical, 2)
                                .background(
                                    pair.level == "AAA"
                                    ? ZodiakColors.surfacePositive
                                    : ZodiakColors.actionPrimary.opacity(0.1)
                                )
                                .cornerRadius(ZodiakRadii.xs)
                        }

                        if pair.token != contrastPairs.last?.token {
                            Divider()
                        }
                    }
                }

                ZodiakInfoRow(
                    "catalog.spec.lbl.aaa",
                    value: "catalog.spec.val.contraste_aaa_7_1",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.aa",
                    value: "catalog.spec.val.contraste_aa_4_5",
                    style: .spec()
                )
            }

            // MARK: Tamanho Mínimo de Toque
            gallerySectionCard(title: "catalog.section.toque_minimo") {
                Text("catalog.accessibility.desc_touch")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                VStack(spacing: ZodiakSpacing.s4) {
                    ForEach(touchTargets, id: \.label) { target in
                        HStack(alignment: .center, spacing: ZodiakSpacing.s8) {
                            RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                                .fill(ZodiakColors.actionPrimary.opacity(0.12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                                        .stroke(ZodiakColors.actionPrimary.opacity(0.35), lineWidth: 1)
                                )
                                .frame(width: 96, height: target.size)

                            VStack(alignment: .leading, spacing: 2) {
                                Text(target.label)
                                    .font(ZodiakTypography.bodySmall)
                                    .foregroundColor(ZodiakColors.textPrimary)
                                Text(target.token)
                                    .font(ZodiakTypography.captionLarge)
                                    .foregroundColor(ZodiakColors.textSecondary)
                            }

                            Spacer()

                            Image(systemName: target.size >= 44 ? "checkmark.circle.fill" : "exclamationmark.circle")
                                .foregroundColor(
                                    target.size >= 44
                                    ? ZodiakColors.textPositive
                                    : ZodiakColors.actionWarning
                                )
                        }

                        if target.label != touchTargets.last?.label {
                            Divider()
                        }
                    }
                }

                ZodiakInfoRow(
                    "catalog.spec.lbl.minimo_hig",
                    value: "catalog.spec.val.touch_44pt_hig",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.modifier",
                    value: "catalog.spec.val.touch_expandedTouchTarget",
                    style: .spec()
                )
            }

            // MARK: Reduce Motion
            gallerySectionCard(title: "catalog.section.reduce_motion") {
                Text("catalog.accessibility.desc_motion")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                HStack(spacing: ZodiakSpacing.s8) {
                    Image(systemName: "gear")
                        .font(.system(size: 48))
                        .foregroundColor(ZodiakColors.actionPrimary)
                        .rotationEffect(.degrees(isAnimating ? demoAngle : 0))
                        .animation(
                            reduceMotion ? nil : .linear(duration: 3).repeatForever(autoreverses: false),
                            value: isAnimating
                        )

                    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                        ZodiakText("catalog.accessibility.reduce_motion_status", style: .body())
                        Text(reduceMotion ? "feature.accessibility.activated" : "feature.accessibility.deactivated")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                        Text("catalog.accessibility.reduce_motion_hint")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                    }
                }
                .padding(ZodiakSpacing.s8)
                .background(ZodiakColors.surface)
                .cornerRadius(ZodiakRadii.s)
                .onAppear { isAnimating = true }

                ZodiakInfoRow(
                    "catalog.spec.lbl.env",
                    value: "catalog.spec.val.reduce_motion_env",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.uso",
                    value: "catalog.spec.val.reduce_motion_uso",
                    style: .spec()
                )
            }

            // MARK: Especificações
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow(
                    "catalog.spec.lbl.wcag",
                    value: "catalog.spec.val.wcag_2_1_aa",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.dynamic_type",
                    value: "catalog.spec.val.accessibility_dynamic_type",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.voiceover",
                    value: "catalog.spec.val.accessibility_voiceover",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.dark_mode",
                    value: "catalog.spec.val.accessibility_dark_mode_100",
                    style: .spec()
                )
            }
        }
        .zodiakPage(title: "catalog.accessibility.title")
    }
}

// MARK: - Preview

#Preview("Accessibility — Light") {
    NavigationStack { AccessibilityGalleryView() }
}

#Preview("Accessibility — Dark") {
    NavigationStack { AccessibilityGalleryView() }
        .preferredColorScheme(.dark)
}
