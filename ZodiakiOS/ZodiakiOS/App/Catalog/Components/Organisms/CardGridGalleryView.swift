import SwiftUI

// MARK: - Card Grid Gallery View
// Figma: "Card grid standard"

struct CardGridGalleryView: View {
    @State private var columns = 2
    @State private var initialCount = 4
    @State private var showSkeleton = false

    private let sampleCards: [ZodiakCardItem] = [
        .init(
            title: "catalog.home.zodiak_ds_full",
            subtitle: "Capgemini · 5 min",
            description: "catalog.cardgrid.demo.ds_desc",
            imageName: "paintpalette",
            tag: "Design"
        ),
        .init(
            title: "iOS Development Best Practices",
            subtitle: "Interno · 8 min",
            description: "catalog.cardgrid.demo.swiftui_guide",
            imageName: "iphone",
            tag: "Dev"
        ),
        .init(
            title: "catalog.cardgrid.demo.a11y_title",
            subtitle: "UX · 6 min",
            description: "Como garantir WCAG 2.1 AA em aplicativos iOS e Android.",
            imageName: "figure.and.child.holdinghands",
            tag: "UX"
        ),
        .init(
            title: "Design Tokens Explicados",
            subtitle: "Design · 4 min",
            description: "catalog.cardgrid.demo.tokens_desc",
            imageName: "slider.horizontal.3",
            tag: "Design"
        ),
        .init(
            title: "Figma para Desenvolvedores",
            subtitle: "Tools · 7 min",
            description: "Como extrair specs e recursos do Figma de forma eficiente.",
            imageName: "square.grid.2x2",
            tag: "Tools"
        ),
        .init(
            title: "Dark Mode: guia completo",
            subtitle: "Design · 5 min",
            description: "catalog.cardgrid.demo.darkmode_desc",
            imageName: "moon.stars",
            tag: "Design"
        ),
        .init(
            title: "SwiftUI Navigation Patterns",
            subtitle: "Dev · 9 min",
            description: "catalog.cardgrid.demo.nav_desc",
            imageName: "arrow.triangle.branch",
            tag: "Dev"
        ),
        .init(
            title: "UX Writing para Interfaces",
            subtitle: "UX · 6 min",
            description: "Como escrever textos claros e efetivos em produtos digitais.",
            imageName: "text.bubble",
            tag: "UX"
        ),
        .init(
            title: "Performance no SwiftUI",
            subtitle: "Dev · 11 min",
            description: "catalog.cardgrid.demo.perf_desc",
            imageName: "bolt",
            tag: "Dev"
        )
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.card_grid",
                subtitle: "catalog.card_grid.subtitle",
                figmaRef: "Card grid standard"
            )

            // MARK: Playground
            gallerySectionCard(title: LocalizedStringKey(String(
                format: String(localized: "shared.format.playground_cards"),
                sampleCards.count, initialCount))) {
                    HStack {
                        Picker("catalog.spec.label_columns", selection: $columns) {
                            Text("catalog.cardgrid.desc_0").tag(1)
                            Text("catalog.cardgrid.desc_1").tag(2)
                        }
                        .pickerStyle(.segmented)
                    }

                    Stepper(
                        "catalog.spec.initials_label \(initialCount)",
                        value: $initialCount,
                        in: 2...(sampleCards.count - 1)
                    )
                        .font(ZodiakTypography.bodySmall)
                        .tint(ZodiakColors.actionPrimary)

                    ZodiakCardGrid(items: sampleCards, columns: columns, initialCount: initialCount)
            }

            // MARK: Card anatomy
            gallerySectionCard(title: "catalog.section.anatomia_do_card") {
                    ZodiakCard(item: .init(
                        title: "Exemplo de card",
                        subtitle: "Categoria · Tempo de leitura",
                        description: "catalog.cardgrid.spec.desc_rule",
                        imageName: "star",
                        tag: "Tag",
                        actionLabel: "Read more"
                    ))
                    .frame(maxWidth: 260)

                    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                        anatomyRow("catalog.spec.lbl.area_imagem", "catalog.cardgrid.spec.image_val")
                        anatomyRow("Eyebrow", "heading-xs, textPrimary, em-dash prefix, opcional")
                        anatomyRow("catalog.spec.lbl.titulo", "catalog.cardgrid.spec.title_val")
                        anatomyRow("catalog.spec.lbl.subtitulo", "catalog.cardgrid.spec.subtitle_val")
                        anatomyRow("catalog.spec.lbl.descricao", "catalog.cardgrid.spec.desc_val")
                        anatomyRow("catalog.spec.lbl.botao_terciario", "catalog.cardgrid.spec.btn_val")
                    }
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.grid",
                        value: "catalog.spec.val.lazyvgrid_com_griditemflexible",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.colunas",
                        value: "catalog.spec.val.configuravel_1_ou_2_mobile",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.card_radius",
                        value: "catalog.spec.val.zodiakradiis_16pt",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.show_more",
                        value: "catalog.spec.val.botao_integrado_quando_items_initialcoun",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.animacao",
                        value: "catalog.spec.val.springresponse_035_damping_085",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.card_shadow",
                        value: "catalog.spec.val.colorblackopacity006_radius_8",
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

                LazyVGrid(
                    columns: [GridItem(.flexible()), GridItem(.flexible())],
                    spacing: ZodiakSpacing.s8
                ) {
                    ForEach(Array(sampleCards.prefix(4))) { item in
                        ZodiakCard(item: item)
                            .zodiakSkeleton(active: showSkeleton)
                    }
                }
            }
        }
        .zodiakPage(title: "catalog.component_name.card_grid")
    }

    private func anatomyRow(_ part: String, _ desc: String) -> some View {
        HStack(alignment: .top, spacing: ZodiakSpacing.s4) {
            Image(systemName: "arrow.right")
                .font(.system(size: 10))
                .foregroundColor(ZodiakColors.actionPrimary)
                .padding(.top, 2)
            VStack(alignment: .leading, spacing: 1) {
                Text(LocalizedStringKey(part))
                    .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textPrimary)
                Text(LocalizedStringKey(desc))
                    .font(ZodiakTypography.captionLarge).foregroundColor(ZodiakColors.textSecondary)
            }
        }
    }
}

#Preview { NavigationStack { CardGridGalleryView() } }
