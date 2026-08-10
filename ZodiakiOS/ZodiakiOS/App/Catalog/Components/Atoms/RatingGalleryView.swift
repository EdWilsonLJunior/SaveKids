import SwiftUI

struct RatingGalleryView: View {
    @State private var rating = 3
    @State private var feedbackRating = 0
    @State private var showSkeleton = false

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.rating",
                subtitle: "catalog.rating.subtitle",
                figmaRef: "catalog.component_name.rating"
            )

            // MARK: Interativo
            gallerySectionCard(title: "catalog.section.rating_interativo") {
                    Text("catalog.rating.desc_0")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textSecondary)

                    ZodiakRating(rating: $rating, showLabel: true)

                    Text(String(format: String(localized: "shared.format.rating_value"), rating))
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textSecondary)
            }

            // MARK: Feedback form
            gallerySectionCard(title: "catalog.section.exemplo_em_contexto") {
                    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                        Text("catalog.rating.desc_1")
                            .font(ZodiakTypography.bodySmall)
                            .foregroundColor(ZodiakColors.textPrimary)
                        ZodiakRating(rating: $feedbackRating, size: 32, showLabel: true)
                        if feedbackRating > 0 {
                            ZodiakButtonPrimary(title: "shared.action.submit_rating") {}
                        }
                    }
            }

            // MARK: Display (read-only)
            gallerySectionCard(title: "catalog.section.display_read_only") {
                    Text("catalog.rating.desc_2")
                        .font(ZodiakTypography.captionLarge)
                        .foregroundColor(ZodiakColors.textSecondary)

                    ForEach([4.9, 4.5, 4.2, 3.7, 3.0, 2.5, 1.3], id: \.self) { value in
                        HStack {
                            ZodiakRatingDisplay(value: value, size: 14)
                            Text(String(format: String(localized: "shared.format.decimal"), value))
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }
                    }
            }

            // MARK: Tamanhos
            gallerySectionCard(title: "catalog.section.tamanhos") {
                    HStack(alignment: .bottom, spacing: ZodiakSpacing.s16) {
                        VStack(spacing: ZodiakSpacing.s4) {
                            ZodiakRatingDisplay(value: 4.5, size: 12, showValue: false)
                            Text("catalog.rating.desc_3")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }
                        VStack(spacing: ZodiakSpacing.s4) {
                            ZodiakRatingDisplay(value: 4.5, size: 16, showValue: false)
                            Text("catalog.rating.desc_4")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }
                        VStack(spacing: ZodiakSpacing.s4) {
                            ZodiakRatingDisplay(value: 4.5, size: 24, showValue: false)
                            Text("catalog.rating.desc_5")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }
                        VStack(spacing: ZodiakSpacing.s4) {
                            ZodiakRatingDisplay(value: 4.5, size: 32, showValue: false)
                            Text("catalog.rating.desc_6")
                                .font(ZodiakTypography.captionLarge)
                                .foregroundColor(ZodiakColors.textSecondary)
                        }
                    }
            }

            // MARK: Specs
            gallerySectionCard(title: "catalog.section.especificacoes") {
                    ZodiakInfoRow(
                        "catalog.spec.lbl.estrela_cheia",
                        value: "catalog.spec.val.starfill_f2b818_amarelo",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.meia_estrela",
                        value: "catalog.spec.val.starleadinghalffilled",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.vazia",
                        value: "catalog.spec.val.star_borderprimary",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.toggle",
                        value: "catalog.spec.val.toque_no_mesmo_star_desseleciona",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "catalog.spec.lbl.animacao",
                        value: "catalog.spec.val.springresponse_02",
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

                ZodiakRatingDisplay(value: 4.5, size: 24)
                    .zodiakSkeleton(active: showSkeleton)

                ZodiakRating(rating: .constant(4), maxStars: 5, isReadOnly: true)
                    .zodiakSkeleton(active: showSkeleton)
            }

            // MARK: Accessibility
            gallerySectionCard(title: "Accessibility") {
                    ZodiakInfoRow(
                        "VoiceOver label",
                        value: "\"Rating\" (shared.label.rating)",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "VoiceOver value",
                        value: "\"N stars out of M\" via shared.format.stars_rating",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "Adjustable action",
                        value: "Swipe up/down no VoiceOver incrementa/decrementa estrelas",
                        style: .spec()
                    )

                    ZodiakInfoRow(
                        "Identifier",
                        value: "zodiak.rating.<editable|readonly>",
                        style: .spec()
                    )
            }
        }
        .zodiakPage(title: "catalog.component_name.rating")
    }
}

#Preview { NavigationStack { RatingGalleryView() } }
