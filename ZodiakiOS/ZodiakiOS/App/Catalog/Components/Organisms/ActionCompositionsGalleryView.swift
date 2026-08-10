import SwiftUI

struct ActionCompositionsGalleryView: View {
    private let linkItems: [ZodiakLinkRibbonItem] = [
        .init(label: "shared.nav.home", icon: "house", action: {}),
        .init(label: "shared.nav.about", icon: "info.circle", action: {}),
        .init(label: "shared.nav.services", icon: "briefcase", action: {}),
        .init(label: "shared.nav.contact", icon: "envelope", action: {}),
        .init(label: "shared.nav.careers", icon: "person.badge.plus", action: {})
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.composition_name.action_compositions",
                subtitle: "catalog.action_compositions.subtitle",
                figmaRef: "10 ▪️ ACTIONS"
            )

            // Link Ribbon
            gallerySectionCard(title: "catalog.section.link_ribbon") {
                    Text("catalog.actioncompositions.desc_0")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textSecondary)

                    ZodiakLinkRibbon(title: "catalog.action.demo.quick_links", links: linkItems)

                    ZodiakInfoRow(
                        "catalog.spec.lbl.separator",
                        value: "catalog.spec.val.zodiakdivider_hierarquia_primaria_secund",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.tap_target",
                        value: "catalog.spec.val.44pt_minimo_por_item",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.chevron",
                        value: "catalog.spec.val.indicador_de_navegacao_a_direita",
                        style: .spec()
                    )
            }

            // Professional Contact
            gallerySectionCard(title: "catalog.section.professional_contact") {
                    Text("catalog.actioncompositions.desc_1")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textSecondary)

                    ZodiakProfessionalContact(
                        contact: .init(
                            name: "Marie Dupont",
                            role: "Lead UX Designer",
                            company: "Capgemini France",
                            email: "marie.dupont@capgemini.com",
                            phone: "+33 6 12 34 56 78",
                            linkedIn: "linkedin.com/in/marie-dupont"
                        ),
                        onEmailTap: {},
                        onPhoneTap: {}
                    )

                    ZodiakProfessionalContact(
                        contact: .init(
                            name: "Carlos Ferreira",
                            role: "Senior iOS Engineer",
                            company: "Capgemini Portugal",
                            email: "carlos.ferreira@capgemini.com",
                            avatarSystemImage: "person.crop.circle.fill"
                        )
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.avatar",
                        value: "catalog.spec.val.6464_pt_sf_symbol_fallback",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.actions",
                        value: "catalog.spec.val.e_mail_telefone_linkedin_opcionais",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.border",
                        value: "catalog.spec.val.zodiakcolorsbordersecondary_cornerradius",
                        style: .spec()
                    )
            }

            // Share Story
            gallerySectionCard(title: "catalog.section.share_story") {
                    Text("catalog.actioncompositions.desc_2")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textSecondary)

                    ZodiakShareStory(
                        item: .init(
                            eyebrow: "shared.content.news",
                            title: "Design systems reduce delivery friction by 40%",
                            // swiftlint:disable:next line_length
                            summary: "A new study by Capgemini Research Institute shows that unified design languages save teams thousands of hours annually.",
                            artworkSystemName: "newspaper.fill",
                            shareLabel: "shared.action.share",
                            shareAction: {},
                            readMoreLabel: "shared.action.read_more",
                            readMoreAction: {}
                        )
                    )

                    ZodiakShareStory(
                        item: .init(
                            eyebrow: "shared.content.podcast",
                            title: "Designing at Capgemini Scale",
                            summary: "catalog.action.demo.summary",
                            artworkSystemName: "mic.fill",
                            shareLabel: "shared.action.share",
                            shareAction: {}
                        )
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.artwork",
                        value: "catalog.spec.val.180_pt_alto_gradiente_brandmarine",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.overlay",
                        value: "catalog.spec.val.gradiente_escuro_para_legibilidade",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.botoes",
                        value: "catalog.spec.val.primary_share_optional_secondary",
                        style: .spec()
                    )
            }
        }
        .zodiakPage(title: "catalog.composition_name.action_compositions")
    }
}

// MARK: - Preview

#Preview { NavigationStack { ActionCompositionsGalleryView() } }
