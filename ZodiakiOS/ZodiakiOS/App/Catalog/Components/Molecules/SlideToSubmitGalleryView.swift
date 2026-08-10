import SwiftUI

// MARK: - Slide To Submit Gallery View
// Figma: "Button slide to submit"

struct SlideToSubmitGalleryView: View {
    @State private var submitKey = UUID()   // used to force reset
    @State private var isEnabled = true
    @State private var lastSubmitTime: Date?
    @State private var showConfirmation = false

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.slide_to_submit",
                subtitle: "catalog.slide_to_submit.subtitle",
                figmaRef: "Button slide to submit"
            )

            // MARK: Playground
            gallerySectionCard(title: "catalog.section.playground") {
                    if let time = lastSubmitTime {
                        HStack(spacing: ZodiakSpacing.s4) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(ZodiakColors.surfacePositive)
                            Text(String(
                                format: String(localized: "shared.format.confirmed_at"),
                                time.formatted(date: .omitted, time: .shortened)))
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }
                    }

                    ZodiakSlideToSubmit(
                        label: "shared.action.slide_to_confirm",
                        onSubmit: {
                            lastSubmitTime = .now
                            showConfirmation = true
                        },
                        isEnabled: isEnabled
                    )
                    .id(submitKey)

                    Toggle("catalog.section.enabled", isOn: $isEnabled)
                        .tint(ZodiakColors.actionPrimary)
                        .font(ZodiakTypography.bodySmall)

                    Button("shared.action.reset") {
                        submitKey = UUID()
                        lastSubmitTime = nil
                    }
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.actionPrimary)
            }

            // MARK: Casos de uso
            gallerySectionCard(title: "catalog.section.casos_de_uso") {
                    Text("catalog.slidetosubmit.desc_0")
                        .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                    ForEach(useCases, id: \.0) { label, icon in
                        HStack(spacing: ZodiakSpacing.s8) {
                            Image(systemName: icon)
                                .font(.system(size: 14))
                                .foregroundColor(ZodiakColors.actionPrimary)
                                .frame(width: 20)
                            Text(label)
                                .font(ZodiakTypography.bodySmall)
                                .foregroundColor(ZodiakColors.textPrimary)
                        }
                        .padding(.vertical, ZodiakSpacing.s4)
                    }
            }

            // MARK: Behaviors
            gallerySectionCard(title: "catalog.section.comportamentos") {
                    behaviorRow("Arraste incompleto (< 90%)", "Thumb retorna com spring animation")

                    behaviorRow(
                        "Arraste completo (≥ 90%)",
                        "Trava no fim + haptic UIImpactFeedbackGenerator(.heavy) + callback onSubmit"
                    )

                    behaviorRow("Label", "Fade proporcional ao progresso do arraste")

                    behaviorRow("catalog.section.disabled", "Gesto inativo — bg actionDisabled")
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.altura_total",
                        value: "catalog.spec.val.52pt_44pt_thumb_4pt_padding_2",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.thumb",
                        value: "catalog.spec.val.44pt_circular_actionprimary",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.track",
                        value: "catalog.spec.val.borderradius_l_999pt_pill",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.icone_thumb",
                        value: "catalog.spec.val.chevronright2_checkmark_apos_completar",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.threshold",
                        value: "catalog.spec.val.90_do_comprimento_da_track",
                        style: .spec()
                    )
            }
        }
        .zodiakPage(title: "catalog.component_name.slide_to_submit")
        .alert("shared.state.confirmed", isPresented: $showConfirmation) {
            Button("shared.action.ok") {}
        } message: {
            Text("catalog.slidetosubmit.desc_1")
        }
    }

    private let useCases: [(String, String)] = [
        ("Confirmar pagamento", "creditcard"),
        ("Enviar proposta", "paperplane"),
        ("Excluir conta", "trash"),
        ("Assinar contrato", "signature"),
        ("catalog.slidesubmit.demo.publish", "arrow.up.circle")
    ]

    private func behaviorRow(_ title: String, _ detail: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title).font(ZodiakTypography.bodySmall).foregroundColor(ZodiakColors.textPrimary)
            Text(detail).font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)
        }
        .padding(.vertical, ZodiakSpacing.s4)
    }
}

#Preview { NavigationStack { SlideToSubmitGalleryView() } }
