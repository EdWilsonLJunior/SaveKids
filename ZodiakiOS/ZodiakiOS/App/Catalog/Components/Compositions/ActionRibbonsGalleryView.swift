import SwiftUI

// MARK: - Action Ribbons Gallery

struct ActionRibbonsGalleryView: View {
    @State private var showSkeleton = false

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
                title: "catalog.action_ribbons.title",
                subtitle: "catalog.action_ribbons.subtitle",
                figmaRef: "10 ▪️ ACTIONS"
            )

            // MARK: Link Ribbon
            gallerySectionCard(title: "catalog.section.link_ribbon") {
                Text("catalog.action_ribbons.desc_ribbon")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)

                ZodiakLinkRibbon(title: "LINKS RÁPIDOS", links: linkItems)

                ZodiakLinkRibbon(title: nil, links: Array(linkItems.prefix(3)))

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
                    "catalog.spec.lbl.titulo",
                    value: "catalog.spec.val.link_ribbon_titulo_opcional",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.chevron",
                    value: "catalog.spec.val.indicador_de_navegacao_a_direita",
                    style: .spec()
                )
            }

            // MARK: Professional Contact
            gallerySectionCard(title: "catalog.section.professional_contact") {
                Text("catalog.action_ribbons.desc_contact")
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

            // MARK: Share Story
            gallerySectionCard(title: "catalog.section.share_story") {
                Text("catalog.action_ribbons.desc_story")
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
                        summary: "A conversa explora como sistemas de design evoluem com organizações que crescem.",
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

            // MARK: Especificações
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow(
                    "catalog.spec.lbl.link_ribbon",
                    value: "catalog.spec.val.action_link_ribbon_footer_nav",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.professional_contact",
                    value: "catalog.spec.val.action_contact_email_phone_linkedin",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.spec.lbl.share_story",
                    value: "catalog.spec.val.action_story_share_read_more",
                    style: .spec()
                )
            }

            gallerySectionCard(title: LocalizedStringKey("catalog.skeletonloader.section.loading_state")) {
                Toggle(isOn: $showSkeleton) {
                    Text("catalog.skeletonloader.desc_0")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textPrimary)
                }
                .tint(ZodiakColors.actionPrimary)

                ZodiakCard(item: ZodiakCardItem(
                    title: "Action example",
                    subtitle: "Ribbon · Composition",
                    imageName: "link"
                ))
                .zodiakSkeleton(active: showSkeleton)
            }
        }
        .zodiakPage(title: "catalog.action_ribbons.title")
    }
}

// MARK: - Preview

#Preview("Action Ribbons — Light") {
    NavigationStack { ActionRibbonsGalleryView() }
}

#Preview("Action Ribbons — Dark") {
    NavigationStack { ActionRibbonsGalleryView() }
        .preferredColorScheme(.dark)
}
