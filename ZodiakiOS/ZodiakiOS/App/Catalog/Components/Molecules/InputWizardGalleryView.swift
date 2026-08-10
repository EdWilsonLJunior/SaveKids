import SwiftUI

struct InputWizardGalleryView: View {
    @State private var completed = false

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.composition_name.input_wizard",
                subtitle: "catalog.input_wizard.subtitle",
                figmaRef: "Input › Input wizard"
            )

                if completed {
                    VStack(spacing: ZodiakSpacing.s4) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 48, weight: .light))
                            .foregroundColor(ZodiakColors.surfacePositive)
                        Text("catalog.inputwizard.desc_0")
                            .font(ZodiakTypography.titleSmall)
                            .foregroundColor(ZodiakColors.textPrimary)
                        Button("shared.action.restart") { completed = false }
                            .buttonStyle(.borderedProminent)
                            .tint(ZodiakColors.actionPrimary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(ZodiakSpacing.s32)
                    .cardStyle()
                } else {
                    ZodiakInputWizard(
                        title: "catalog.spec.new_project",
                        steps: [
                            ZodiakWizardStep(
                                title: "catalog.spec.basic_info",
                                subtitle: "catalog.spec.fill_name_desc_hint"
                            ) {
                                VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                                    ZodiakLabelledField(
                                        label: "Nome do projeto",
                                        placeholder: "shared.placeholder.ex_project_name",
                                        text: .constant("")
                                    )
                                    ZodiakLabelledField(
                                        label: "catalog.inputwizard.demo.description",
                                        placeholder: "shared.placeholder.project_summary",
                                        text: .constant("")
                                    )
                                }
                            },
                            ZodiakWizardStep(
                                title: "catalog.spec.label_team",
                                subtitle: "catalog.spec.add_owners_hint"
                            ) {
                                VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                                    ZodiakLabelledField(
                                        label: "catalog.inputwizard.demo.tech_lead",
                                        placeholder: "shared.label.name",
                                        text: .constant("")
                                    )
                                    ZodiakLabelledField(
                                        label: "catalog.inputwizard.demo.designer",
                                        placeholder: "shared.label.name",
                                        text: .constant("")
                                    )
                                    ZodiakLabelledField(
                                        label: "Product Owner",
                                        placeholder: "shared.label.name",
                                        text: .constant("")
                                    )
                                }
                            },
                            ZodiakWizardStep(
                                title: "app.settings.title",
                                subtitle: "catalog.spec.set_deadline_hint"
                            ) {
                                VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                                    ZodiakLabelledField(
                                        label: "Prazo de entrega",
                                        placeholder: "shared.placeholder.date",
                                        text: .constant("")
                                    )
                                    ZodiakLabelledField(
                                        label: "Plataformas",
                                        placeholder: "shared.placeholder.platforms",
                                        text: .constant("")
                                    )
                                    ZodiakLabelledField(
                                        label: "Budget estimado (€)",
                                        placeholder: "shared.placeholder.decimal_zero",
                                        text: .constant("")
                                    )
                                }
                            },
                            ZodiakWizardStep(
                                title: "shared.state.review",
                                subtitle: "catalog.spec.confirm_before_create"
                            ) {
                                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                                    reviewRow("shared.label.name", "Redesign Zodiak")
                                    // swiftlint:disable:next line_length
                                    reviewRow("catalog.inputwizard.demo.description", "catalog.inputwizard.demo.review_desc")
                                    reviewRow("catalog.inputwizard.demo.lead_label", "—")
                                    reviewRow("Prazo", "30/06/2026")
                                    reviewRow("Plataformas", "iOS, iPadOS")
                                }
                            }
                        ],
                        onComplete: { completed = true },
                        onCancel: {},
                        submitLabel: "shared.action.create_project"
                    )
                }

            // Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.progresso",
                        value: "catalog.spec.val.barra_dots_numerados_persistentes_no_hea",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.navegacao",
                        value: "catalog.spec.val.botao_voltar_steps_2_proximoconcluir",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.animacao",
                        value: "catalog.spec.val.slide_horizontal_entre_steps_easeinout_0",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.conteudo",
                        value: "catalog.spec.val.viewbuilder_generico_por_step",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.steps",
                        value: "catalog.spec.val.1n_titulo_subtitle_conteudo_livre",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.dots",
                        value: "catalog.spec.val.numerados_concluido_checkmark_verde",
                        style: .spec()
                    )
            }
        }
        .zodiakPage(title: "catalog.composition_name.input_wizard")
    }

    @ViewBuilder
    private func reviewRow(_ label: String, _ value: String) -> some View {
        HStack(alignment: .top) {
            Text(LocalizedStringKey(label))
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
                .frame(width: 80, alignment: .leading)
            Text(LocalizedStringKey(value))
                .font(ZodiakTypography.bodySmall)
                .foregroundColor(ZodiakColors.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview { NavigationStack { InputWizardGalleryView() } }
