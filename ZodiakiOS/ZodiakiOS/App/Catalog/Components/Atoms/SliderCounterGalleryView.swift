import SwiftUI

// MARK: - Slider Counter Gallery View
// Figma: "Slider counter"

struct SliderCounterGalleryView: View {
    @State private var cardIndex = 0
    @State private var index3 = 0
    @State private var index9 = 0

    private let slides = [
        "Design Tokens",
        "catalog.home.tab_components",
        "catalog.component.typography",
        "catalog.component.spacing",
        "feature.theme_toggle.colors_section"
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.slider_counter",
                subtitle: "catalog.slider_counter.subtitle",
                figmaRef: "Slider counter"
            )

            // MARK: Uso com carrossel
            gallerySectionCard(title: "catalog.section.integrado_com_carrossel") {
                Text("catalog.slidercounter.desc_0")
                    .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)

                // Slide display
                ZStack {
                    RoundedRectangle(cornerRadius: ZodiakRadii.m)
                        .fill(ZodiakColors.surfaceSmoke)
                        .frame(height: 100)
                    Text(slides[cardIndex])
                        .font(ZodiakTypography.titleSmall)
                        .foregroundColor(ZodiakColors.textPrimary)
                        .animation(.easeInOut, value: cardIndex)
                }

                ZodiakSliderCounter(totalItems: slides.count, currentIndex: $cardIndex)
            }

            // MARK: Com contador
            gallerySectionCard(title: "catalog.section.com_contador_numerico") {
                ZodiakSliderCounter(totalItems: 5, currentIndex: $cardIndex)
            }

            // MARK: Sem contador
            gallerySectionCard(title: "catalog.section.sem_contador_numerico") {
                ZodiakSliderCounter(totalItems: 5, currentIndex: $cardIndex, showCounter: false)
            }

            // MARK: Variantes de quantidade
            gallerySectionCard(title: "catalog.section.2_a_9_itens") {
                VStack(spacing: ZodiakSpacing.s8) {
                    ForEach([2, 3, 5, 7, 9], id: \.self) { total in
                        HStack {
                            Text(verbatim: "\(total) itens")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                                .frame(width: 50, alignment: .leading)
                            ZodiakSliderCounter(
                                totalItems: total,
                                currentIndex: Binding(
                                    get: { cardIndex % total },
                                    set: { _ in }
                                ),
                                showCounter: false
                            )
                            .allowsHitTesting(false)
                        }
                    }
                }
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow(
                    "catalog.spec.lbl.componente",
                    value: "catalog.spec.val.zodiakslidercounter",
                    style: .spec()
                )

                ZodiakInfoRow("catalog.spec.lbl.totalitems", value: "catalog.spec.val.int_29", style: .spec())

                ZodiakInfoRow("catalog.spec.lbl.currentindex", value: "catalog.spec.val.bindingint", style: .spec())

                ZodiakInfoRow(
                    "catalog.spec.lbl.showcounter",
                    value: "catalog.spec.val.bool_1_n_label_opcional",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.navegacao",
                    value: "catalog.spec.val.circular_wrap_nos_extremos",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.animacao",
                    value: "catalog.spec.val.springresponse_035_dampingfraction_085",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.barra",
                    value: "catalog.spec.val.4pt_bordersecondary_actionprimary",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.zodiak_ds",
                    value: "catalog.spec.val.navigation_slider_counter",
                    style: .spec()
                )
            }
        }
        .zodiakPage(title: "catalog.component_name.slider_counter")
    }
}

#Preview {
    NavigationStack {
        SliderCounterGalleryView()
    }
}
