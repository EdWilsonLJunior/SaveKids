import SwiftUI

struct RadioButtonGalleryView: View {
    @State private var selectedPlan: String? = "pro"
    @State private var selectedSize: String?
    @State private var singleSelected = true

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.radio_button",
                subtitle: "catalog.radio_button.subtitle",
                figmaRef: "Radio"
            )

            // MARK: Radio Group
            gallerySectionCard(title: "catalog.section.radio_group_plano_de_assinatura") {
                    ZodiakRadioGroup(
                        title: "Escolha seu plano",
                        options: [
                            ("Starter — Gratuito", "starter"),
                            ("catalog.radio.option.pro", "pro"),
                            ("Enterprise — Sob consulta", "enterprise")
                        ],
                        selection: $selectedPlan
                    )

                    if let plan = selectedPlan {
                        Text(String(format: String(localized: "shared.format.selected"), plan))
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                    }
            }

            // MARK: Radio Group desabilitado
            gallerySectionCard(title: "catalog.section.desabilitado") {
                    ZodiakRadioGroup(
                        options: [
                            ("catalog.radio.option.a", "a"),
                            ("catalog.radio.option.b", "b"),
                            ("catalog.radio.option.c", "c")
                        ],
                        selection: .constant("b"),
                        isDisabled: true
                    )
            }

            // MARK: Radio individual
            gallerySectionCard(title: "catalog.section.botoes_individuais") {
                    ZodiakRadioGroup(
                        title: "Tamanho de camiseta",
                        options: [("P", "p"), ("M", "m"), ("G", "g"), ("GG", "gg"), ("XGG", "xgg")],
                        selection: $selectedSize
                    )
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.anel_externo",
                        value: "catalog.spec.val.2020pt_stroke_15pt_2pt_quando_ativo",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.ponto_interno",
                        value: "catalog.spec.val.1010pt_fill_actionprimary",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.animacao",
                        value: "catalog.spec.val.springresponse_02_dampingfraction_075",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.desabilitado",
                        value: "catalog.spec.val.actiondisabledcontent_textdisabled",
                        style: .spec()
                    )
            }

            // MARK: Accessibility
            gallerySectionCard(title: "Accessibility") {
                    ZodiakInfoRow(
                        "VoiceOver value",
                        value: "\"Selected\" / \"Not selected\" via accessibilityValue",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "Hint (disabled)",
                        value: "\"Unavailable\" lido pelo VoiceOver quando isDisabled",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "Identifier",
                        value: "zodiak.radio.<selected|unselected>.<label>",
                        style: .spec()
                    )

                    ZodiakRadioGroup(
                        title: "Demo VoiceOver",
                        options: [
                            ("catalog.radio.option.a_selected", "a"),
                            ("catalog.radio.option.b", "b")
                        ],
                        selection: .constant("a")
                    )
            }
        }
        .zodiakPage(title: "catalog.component_name.radio_button")
    }
}

#Preview { NavigationStack { RadioButtonGalleryView() } }
