import SwiftUI

// MARK: - Author Card Gallery View
// Zodiak DS — Organisms > Card Variants > Author Card

struct AuthorCardGalleryView: View {
    @State private var showSkeleton = false

    private let items: [ZodiakAuthorCardItem] = [
        .init(
            name: "Alice Martin",
            role: "Lead Designer",
            date: "23 Apr 2026",
            headline: "Why design tokens matter at the platform level",
            articleImageName: "paintpalette",
            actionLabel: "Read more"
        ),
        .init(
            name: "Tom Kowalski",
            role: "Front-end Dev",
            date: "15 Apr 2026",
            headline: "Composable architectures in Swift",
            articleImageName: "swift",
            actionLabel: "Read more"
        ),
        .init(
            name: "Sara Chen",
            role: "UX Researcher",
            date: "10 Apr 2026",
            headline: "Accessibility as a quality gate, not an afterthought",
            articleImageName: "figure.and.child.holdinghands"
        ),
        .init(
            name: "Luca Rossi",
            role: "Architect",
            date: "5 Apr 2026",
            headline: "iOS architecture patterns compared: MVVM vs TCA",
            articleImageName: "iphone",
            actionLabel: "Read more"
        )
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.author_card",
                subtitle: "catalog.author_card.subtitle",
                figmaRef: "Card grid — Author"
            )

            // MARK: Grid
            gallerySectionCard(title: "catalog.section.grid") {
                Text("catalog.cardvariants.desc_0")
                    .font(ZodiakTypography.bodySmall)
                    .foregroundColor(ZodiakColors.textSecondary)
                ZodiakAuthorCardGrid(items: items)
            }

            // MARK: Item individual
            gallerySectionCard(title: "catalog.section.item_individual") {
                ZodiakAuthorCard(item: items[0])
                ZodiakAuthorCard(item: items[2])
            }

            // MARK: Loading state
            gallerySectionCard(title: "catalog.skeletonloader.section.loading_state") {
                Toggle(isOn: $showSkeleton) {
                    Text("catalog.skeletonloader.desc_0")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textPrimary)
                }
                .tint(ZodiakColors.actionPrimary)
                ZodiakAuthorCard(item: items[0])
                    .zodiakSkeleton(active: showSkeleton)
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow(
                    "catalog.spec.lbl.layout",
                    value: "catalog.spec.val.grid_2_colunas_flexivel",
                    style: .spec()
                )

                ZodiakInfoRow(
                    "catalog.spec.lbl.author",
                    value: "catalog.spec.val.zodiak_author_size_s",
                    style: .spec()
                )

                ZodiakInfoRow("Imagem artigo", value: "100pt height · SF Symbol placeholder", style: .spec())

                ZodiakInfoRow(
                    "catalog.authorcard.spec.action_btn",
                    value: "Opcional · bodySmall · actionPrimary underline",
                    style: .spec()
                )
            }
        }
        .zodiakPage(title: "catalog.component_name.author_card")
    }
}

#Preview { NavigationStack { AuthorCardGalleryView() } }
