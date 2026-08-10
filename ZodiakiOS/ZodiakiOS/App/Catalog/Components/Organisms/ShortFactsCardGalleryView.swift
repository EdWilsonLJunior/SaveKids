import SwiftUI

// MARK: - Short Facts Card Gallery View
// Zodiak DS — Organisms > Card Variants > Short Facts Card

struct ShortFactsCardGalleryView: View {
    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.short_facts_card",
                subtitle: "catalog.short_facts_card.subtitle",
                figmaRef: "Card grid — Short Facts"
            )

            // MARK: Grid 2 colunas (padrão)
            gallerySectionCard(title: "catalog.section.grid_2_colunas") {
                Text("catalog.cardvariants.desc_5")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)
                ZodiakShortFactsCard(items: [
                    .init(icon: "person.3", value: "3 200", label: "Consultores"),
                    .init(
                        icon: "globe.europe.africa", value: "18",
                        label: "catalog.shortfacts.demo.countries",
                        color: ZodiakColors.surfacePositive
                    ),
                    .init(
                        icon: "building.2", value: "42",
                        label: "catalog.shortfacts.demo.offices",
                        color: ZodiakColors.brand
                    ),
                    .init(
                        icon: "star", value: "94%",
                        label: "catalog.shortfacts.demo.satisfaction",
                        color: ZodiakColors.surfaceAzur
                    ),
                    .init(
                        icon: "checkmark.shield", value: "ISO 27001",
                        label: "catalog.shortfacts.demo.certification",
                        color: ZodiakColors.actionPrimary
                    ),
                    .init(icon: "bolt", value: "48h", label: "Onboarding", color: ZodiakColors.surfacePositive)
                ])
            }

            // MARK: Grid 3 colunas
            gallerySectionCard(title: "catalog.section.grid_3_colunas") {
                Text("catalog.shortfacts.spec.columns_note")
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                ZodiakShortFactsCard(
                    items: [
                        .init(icon: "clock", value: "8 anos", label: "catalog.shortfacts.demo.experience"),
                        .init(
                            icon: "trophy", value: "12",
                            label: "catalog.shortfacts.demo.awards", color: ZodiakColors.actionWarningSecondary
                        ),
                        .init(
                            icon: "heart", value: "NPS 72",
                            label: "catalog.shortfacts.demo.satisfaction",
                            color: ZodiakColors.textPositive
                        )
                    ],
                    columns: 3
                )
            }

            // MARK: Cores de ícone
            gallerySectionCard(title: "catalog.section.cores_de_icone") {
                Text("Cada item aceita cor independente via color param")
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                ZodiakShortFactsCard(items: [
                    .init(icon: "paintpalette", value: "Design", label: "actionPrimary",
                          color: ZodiakColors.actionPrimary),
                    .init(icon: "checkmark.circle", value: "Done", label: "textPositive",
                          color: ZodiakColors.textPositive),
                    .init(icon: "exclamationmark.triangle", value: "Warn", label: "actionWarning",
                          color: ZodiakColors.actionWarningSecondary),
                    .init(icon: "drop.fill", value: "Brand", label: "brand", color: ZodiakColors.brand)
                ])
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow(
                    "catalog.spec.lbl.icone",
                    value: "catalog.spec.val.3636_pt_fundo_12_opacidade_cor",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.grid",
                    value: "catalog.spec.val.2_colunas_flexiblegrid",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.shortfacts.spec.columns_label",
                    value: "catalog.shortfacts.spec.columns_value",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.shortfacts.spec.icon_color_label",
                    value: "catalog.shortfacts.spec.icon_color_value",
                    style: .spec()
                )
            }
        }
        .zodiakPage(title: "catalog.component_name.short_facts_card")
    }
}

#Preview { NavigationStack { ShortFactsCardGalleryView() } }
