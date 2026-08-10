import SwiftUI

struct SearchFieldGalleryView: View {
    @State private var query1 = ""
    @State private var query2 = "React Native"

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.search_field",
                subtitle: "catalog.search_field.subtitle",
                figmaRef: "Search field"
            )

            // MARK: Playground
            gallerySectionCard(title: "catalog.section.playground") {
                    ZodiakSearchField(text: $query1, placeholder: "catalog.component_search.placeholder")
                    if !query1.isEmpty {
                        Text(verbatim: "Query: \"\(query1)\"")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                    }
            }

            // MARK: Estados
            gallerySectionCard(title: "catalog.section.estados") {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                        Text("catalog.searchfield.desc_0")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                        ZodiakSearchField(text: .constant(""), placeholder: "shared.placeholder.search")
                    }

                    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                        Text("catalog.searchfield.desc_1")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                        ZodiakSearchField(text: $query2)
                    }
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.forma",
                        value: "catalog.spec.val.pill_cornerradius_full",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.altura",
                        value: "catalog.spec.val.48pt_textfieldheight",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.icone_leading",
                        value: "catalog.spec.val.magnifyingglass_16pt",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.clear_button",
                        value: "catalog.spec.val.aparece_quando_text_nao_vazio",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.foco",
                        value: "catalog.spec.val.borda_actionprimary_15pt_icone_animado",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.repouso",
                        value: "catalog.spec.val.borda_borderprimary_1pt",
                        style: .spec()
                    )
            }
        }
        .zodiakPage(title: "catalog.component_name.search_field")
    }
}

#Preview { NavigationStack { SearchFieldGalleryView() } }
