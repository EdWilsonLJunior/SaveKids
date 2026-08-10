import SwiftUI

struct StepIndicatorGalleryView: View {
    @State private var currentStep = 1

    private let steps3 = [
        "catalog.step.personal_data",
        "catalog.step.address",
        "catalog.step.confirmation"
    ]
    private let steps4 = [
        "catalog.step.account",
        "catalog.step.plan",
        "catalog.step.payment",
        "shared.state.review"
    ]
    private let steps5 = [
        "catalog.step.type",
        "catalog.step.data",
        "catalog.step.documents",
        "shared.state.review",
        "catalog.step.submission"
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.step_indicator",
                subtitle: "catalog.step_indicator.subtitle",
                figmaRef: "Stepper"
            )

            // MARK: Playground interativo
            // swiftlint:disable:next line_length
            gallerySectionCard(title: LocalizedStringKey(String(format: String(localized: "shared.format.playground_progress"), currentStep + 1, steps3.count))) {
                    ZodiakStepIndicator(steps: steps3, currentStep: currentStep)

                    HStack(spacing: ZodiakSpacing.s8) {
                        ZodiakButtonSecondary(title: "shared.action.previous") {
                            if currentStep > 0 { currentStep -= 1 }
                        }
                        ZodiakButtonPrimary(title: "shared.action.next") {
                            if currentStep < steps3.count - 1 { currentStep += 1 }
                        }
                    }
            }

            // MARK: 4 steps
            gallerySectionCard(title: "catalog.section.4_steps") {
                    ZodiakStepIndicator(steps: steps4, currentStep: 2)
            }

            // MARK: 5 steps concluidos
            gallerySectionCard(title: "catalog.section.5_steps_todos_concluidos") {
                    ZodiakStepIndicator(steps: steps5, currentStep: 5)
            }

            // MARK: Estados
            gallerySectionCard(title: "catalog.section.estados_de_cada_step") {
                    HStack(spacing: ZodiakSpacing.s32) {
                        stateExample(
                            "shared.state.completed",
                            "catalog.step.completed_desc",
                            "checkmark.circle.fill",
                            ZodiakColors.actionPrimary
                        )
                        stateExample(
                            "catalog.step.current_label",
                            "catalog.step.current_desc",
                            "circle",
                            ZodiakColors.actionPrimary
                        )
                        stateExample(
                            "catalog.step.future_label",
                            "catalog.step.future_desc",
                            "circle.dashed",
                            ZodiakColors.textDisabled
                        )
                    }
                    .frame(maxWidth: .infinity)
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow("catalog.spec.lbl.dot_size", value: "catalog.spec.val.2828pt", style: .spec())

                    ZodiakInfoRow(
                        "catalog.spec.lbl.connector",
                        value: "catalog.spec.val.rectangle_height_2pt",
                        style: .spec()
                    )

                    ZodiakInfoRow("catalog.spec.lbl.numero", value: "catalog.spec.val.12pt_semibold", style: .spec())

                    ZodiakInfoRow(
                        "catalog.spec.lbl.label",
                        value: "catalog.spec.val.caption_multilinetextalignment_center",
                        style: .spec()
                    )
            }

            // MARK: Accessibility
            gallerySectionCard(title: "Accessibility") {
                    ZodiakInfoRow(
                        "VoiceOver label",
                        value: "\"Step indicator\" (shared.label.step_indicator)",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "VoiceOver value",
                        value: "\"Step N of M: <label>\" (shared.format.step_progress)",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "children",
                        value: "catalog.stepindicator.spec.a11y_children",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "Identifier",
                        value: "zodiak.step.indicator",
                        style: .spec()
                    )
            }
        }
        .zodiakPage(title: "catalog.component_name.step_indicator")
    }

    private func stateExample(_ label: String, _ desc: String, _ icon: String, _ color: Color) -> some View {
        VStack(spacing: ZodiakSpacing.s4) {
            Image(systemName: icon).foregroundColor(color).font(.system(size: 22))
            ZodiakText(label, style: .caption(bold: true))
                .multilineTextAlignment(.center)
            ZodiakText(desc, style: .caption())
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview { NavigationStack { StepIndicatorGalleryView() } }
