import SwiftUI

struct BreadcrumbPaginationGalleryView: View {
    @State private var currentPage = 3

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.breadcrumb_pagination",
                subtitle: "catalog.breadcrumb_pagination.subtitle",
                figmaRef: "Breadcrumb / Pagination"
            )

            // MARK: Breadcrumb
            gallerySectionCard(title: "catalog.section.breadcrumb") {
                Text("catalog.breadcrumbpagination.desc_0")
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)

                    ZodiakBreadcrumb(items: [
                        .init(title: "catalog.breadcrumb.demo.home", action: {}),
                        .init(title: "catalog.home.tab_components", action: {}),
                        .init(title: "catalog.section.navigation")
                    ])

                    ZodiakBreadcrumb(items: [
                        .init(title: "Dashboard", action: {}),
                        .init(title: "Projetos", action: {}),
                        .init(title: "Zodiak App", action: {}),
                        .init(title: "Releases", action: {}),
                        .init(title: "v2.4.0")
                    ])
            }

            // MARK: Pagination interativa
            gallerySectionCard(title: LocalizedStringKey(String(
                format: String(localized: "shared.format.pagination"),
                currentPage))) {
                    Text("catalog.breadcrumbpagination.desc_1")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textSecondary)

                    ZodiakPagination(currentPage: $currentPage, totalPages: 12)
                        .frame(maxWidth: .infinity)
            }

            // MARK: Pagination variantes
            gallerySectionCard(title: "catalog.section.variantes_de_total") {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                        Text("catalog.breadcrumbpagination.desc_2")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                        ZodiakPagination(currentPage: .constant(3), totalPages: 5)
                    }
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                        Text("catalog.breadcrumbpagination.desc_3")
                            .font(ZodiakTypography.captionLarge)
                            .foregroundColor(ZodiakColors.textSecondary)
                        ZodiakPagination(currentPage: .constant(50), totalPages: 100)
                    }
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    Text("catalog.spec.breadcrumb")
                        .font(ZodiakTypography.bodySmall.bold())
                        .foregroundColor(ZodiakColors.textPrimary)
                    ZodiakInfoRow(
                        "catalog.spec.lbl.separador",
                        value: "catalog.spec.val.chevronright_10pt",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.ativo_ultimo",
                        value: "catalog.spec.val.caption_semibold_textprimary",
                        style: .spec()
                    )
                    ZodiakInfoRow(
                        "catalog.spec.lbl.anterior",
                        value: "catalog.spec.val.caption_regular_textlink",
                        style: .spec()
                    )

                    Text("catalog.spec.pagination")
                        .font(ZodiakTypography.bodySmall.bold())
                        .foregroundColor(ZodiakColors.textPrimary)
                    ZodiakInfoRow(
                        "catalog.spec.lbl.pagina_ativa",
                        value: "catalog.spec.val.circle_fill_actionprimary_textinverse",
                        style: .spec()
                    )
                    ZodiakInfoRow("catalog.spec.lbl.dot_size", value: "catalog.spec.val.3232pt", style: .spec())
                    ZodiakInfoRow(
                        "catalog.spec.lbl.ellipsis",
                        value: "catalog.spec.val.quando_paginas_maxvisible",
                        style: .spec()
                    )
            }
        }
        .zodiakPage(title: "catalog.component_name.breadcrumb_pagination")
    }
}

#Preview { NavigationStack { BreadcrumbPaginationGalleryView() } }
