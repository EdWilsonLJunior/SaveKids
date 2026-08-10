import SwiftUI

// MARK: - Share Gallery View
// Figma: "catalog.component_name.share"

struct ShareGalleryView: View {
    @State private var selectedTab = 0
    @State private var showAuthorDemo = true

    private let tabs = [
        "catalog.tab.demo",
        "catalog.tab.guidelines",
        "catalog.tab.specs"
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.share",
                subtitle: "catalog.share.subtitle",
                figmaRef: "catalog.component_name.share"
            )

            ZodiakTabs(tabs: tabs, selectedIndex: $selectedTab)
                .padding(.top, ZodiakSpacing.s8)

            tabContent
                .id(selectedTab)
                .animation(.easeInOut(duration: 0.2), value: selectedTab)
        }
        .zodiakPage(title: "catalog.component_name.share")
    }

    // MARK: - Tab routing

    @ViewBuilder
    private var tabContent: some View {
        switch selectedTab {
        case 1: guidelinesSection
        case 2: specsSection
        default: demoSection
        }
    }

    // MARK: - Demo

    @ViewBuilder
    private var demoSection: some View {
        gallerySectionCard(title: "catalog.section.estados") {
            ZodiakText("catalog.share.desc_0", style: .caption())

            HStack(alignment: .top, spacing: ZodiakSpacing.s32) {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    ZodiakText("shared.state.active", style: .caption(color: .secondary))
                    ZodiakShare(
                        options: [
                            .init(title: "Email", icon: .mail, action: {}),
                            .init(title: "LinkedIn", icon: .linkedin, action: {}),
                            .init(title: "catalog.share.option.copy_link", icon: .copy, action: {})
                        ]
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    ZodiakText("catalog.section.desabilitado", style: .caption(color: .disabled))
                    ZodiakShare(
                        options: [.init(title: "Email", icon: .mail, action: {})],
                        isEnabled: false
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }

        gallerySectionCard(title: "catalog.section.label_customizado") {
            ZodiakNotice(title: "catalog.share.tip_label", category: .information)

            ZodiakShare(
                options: [
                    .init(title: "WhatsApp", icon: .whatsapp, action: {}),
                    .init(title: "Telegram", icon: .share, action: {}),
                    .init(title: "catalog.share.option.copy_article_link", icon: .copy, action: {}),
                    .init(title: "catalog.share.option.print", icon: .printer, action: {})
                ],
                label: "catalog.share.label_article"
            )
        }

        gallerySectionCard(title: "catalog.section.uso_comum_com_zodiakauthor") {
            HStack(alignment: .top) {
                ZodiakText("catalog.share.desc_1", style: .caption())
                    .frame(maxWidth: .infinity, alignment: .leading)
                ZodiakButtonTertiary(
                    title: LocalizedStringKey(
                        showAuthorDemo ? "catalog.share.toggle_hide" : "catalog.share.toggle_show"
                    ),
                    action: {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                            showAuthorDemo.toggle()
                        }
                    },
                    size: .small
                )
            }

            HStack {
                if showAuthorDemo {
                    ZodiakAuthor(name: "Ana Silva", role: "Design Lead", date: "24 Abr 2026")
                        .transition(.move(edge: .leading).combined(with: .opacity))
                }
                Spacer()
                ZodiakShare(
                    options: [
                        .init(title: "LinkedIn", icon: .linkedin, action: {}),
                        .init(title: "catalog.share.option.copy_link", icon: .copy, action: {})
                    ],
                    label: "shared.action.share"
                )
            }
        }
    }

    // MARK: - Guidelines

    @ViewBuilder
    private var guidelinesSection: some View {
        gallerySectionCard(title: "catalog.section.composicao_com_download") {
            ZodiakNotice(title: "catalog.share.rule_download_position", category: .warning)

            HStack(spacing: ZodiakSpacing.s8) {
                ZodiakShare(
                    options: [
                        .init(title: "Email", icon: .mail, action: {}),
                        .init(title: "LinkedIn", icon: .linkedin, action: {})
                    ]
                )
                ZodiakDownloadButton(
                    options: [.init(title: "PDF", icon: "doc.richtext", onTap: {})],
                    label: "Download"
                )
            }
        }

        gallerySectionCard(title: "catalog.section.contextos_de_uso") {
            HStack(alignment: .top, spacing: ZodiakSpacing.s32) {
                usageRow("catalog.share.usage.articles", "catalog.share.usage.articles_desc", .fileDocument)
                    .frame(maxWidth: .infinity, alignment: .leading)
                usageRow("catalog.share.usage.author", "catalog.share.usage.author_desc", .user)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack(alignment: .top, spacing: ZodiakSpacing.s32) {
                usageRow("catalog.share.usage.events", "catalog.share.usage.events_desc", .calendarDays)
                    .frame(maxWidth: .infinity, alignment: .leading)
                usageRow("catalog.share.usage.media", "catalog.share.usage.media_desc", .image)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }

    // MARK: - Specs

    private var specsSection: some View {
        gallerySectionCard(title: "catalog.section.especificacoes") {
            ZodiakInfoRow("catalog.spec.lbl.componente", value: "catalog.spec.val.zodiakshare", style: .spec())
            ZodiakInfoRow(
                "catalog.spec.lbl.options",
                value: "catalog.spec.val.zodiakshareoption_title_icon_action",
                style: .spec()
            )
            ZodiakInfoRow(
                "catalog.spec.lbl.label_1",
                value: "catalog.spec.val.string_padrao_compartilhar",
                style: .spec()
            )
            ZodiakInfoRow(
                "catalog.spec.lbl.sheet",
                value: "catalog.spec.val.mediumlarge_detents_drag_indicator",
                style: .spec()
            )
            ZodiakInfoRow(
                "catalog.spec.lbl.icone_trigger",
                value: "catalog.spec.val.squareandarrowup",
                style: .spec()
            )
            ZodiakInfoRow(
                "catalog.spec.lbl.similar_a",
                value: "catalog.spec.val.zodiakdownloadbutton_mesmo_padrao_de_she",
                style: .spec()
            )
            ZodiakInfoRow("catalog.spec.lbl.zodiak_ds", value: "catalog.spec.val.utilities_share", style: .spec())
            ZodiakInfoRow(
                "catalog.spec.lbl.max_opcoes",
                value: "catalog.spec.val.seis_opcoes_maximo",
                style: .spec()
            )
            ZodiakInfoRow(
                "catalog.spec.lbl.max_chars",
                value: "catalog.spec.val.vinte_cinco_chars_por_opcao",
                style: .spec()
            )
            ZodiakInfoRow(
                "catalog.spec.lbl.posicao_download",
                value: "catalog.spec.val.share_esquerda_do_download",
                style: .spec()
            )
            ZodiakInfoRow(
                "catalog.spec.lbl.cor_padrao",
                value: "catalog.spec.val.textsecondary_hover_textprimary",
                style: .spec()
            )
        }
    }

    // MARK: - Private

    private func usageRow(_ title: String, _ desc: String, _ icon: ZodiakIcon) -> some View {
        HStack(spacing: ZodiakSpacing.s8) {
            ZodiakIconView(icon, size: .small, color: ZodiakColors.actionPrimary)
            VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                ZodiakText(title, style: .bodySmall(bold: true))
                ZodiakText(desc, style: .caption())
            }
        }
        .padding(.vertical, ZodiakSpacing.s4)
    }
}

#Preview {
    NavigationStack {
        ShareGalleryView()
    }
}
