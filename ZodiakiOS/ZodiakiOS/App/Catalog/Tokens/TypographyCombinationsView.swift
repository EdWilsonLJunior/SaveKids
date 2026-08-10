import SwiftUI

// MARK: - Typography Combinations View

struct TypographyCombinationsView: View {
    var body: some View {
        gallerySectionCard(title: "catalog.typography.tab.combinations") {
            VStack(spacing: 0) {
                combinationRow(
                    label: "catalog.typography.combination.title_subtitle",
                    usage: "catalog.typography.combination.title_subtitle.usage"
                ) {
                    annotatedRow("catalog.typography.example.article_title",
                                 font: ZodiakTypography.titleLarge,
                                 tracking: ZodiakTypography.HeadingSize.medium.tracking(for: .light),
                                 color: ZodiakColors.textPrimary,
                                 token: "titleLarge · Light 300")
                    annotatedRow("catalog.typography.example.article_subtitle",
                                 font: ZodiakTypography.bodyMedium,
                                 tracking: ZodiakTypography.BodySize.m.tracking,
                                 color: ZodiakColors.textSecondary,
                                 token: "bodyMedium · Regular 400")
                }

                ZodiakDivider(hierarchy: .secondary)

                combinationRow(
                    label: "catalog.typography.combination.card_title_description",
                    usage: "catalog.typography.combination.card_title_description.usage"
                ) {
                    annotatedRow("catalog.typography.example.card_title",
                                 font: ZodiakTypography.titleSmall,
                                 tracking: ZodiakTypography.HeadingSize.small.tracking(for: .regular),
                                 color: ZodiakColors.textPrimary,
                                 token: "titleSmall · Regular 400")
                    annotatedRow("catalog.typography.example.card_category",
                                 font: ZodiakTypography.captionLarge,
                                 tracking: ZodiakTypography.BodySize.xs.tracking,
                                 color: ZodiakColors.textSecondary,
                                 token: "captionLarge · Regular 400")
                    annotatedRow("catalog.typography.example.card_description",
                                 font: ZodiakTypography.bodySmall,
                                 tracking: ZodiakTypography.BodySize.s.tracking,
                                 color: ZodiakColors.textSecondary,
                                 token: "bodySmall · Regular 400")
                }

                ZodiakDivider(hierarchy: .secondary)

                combinationRow(
                    label: "catalog.typography.combination.form_label_helper",
                    usage: "catalog.typography.combination.form_label_helper.usage"
                ) {
                    annotatedRow("catalog.typography.example.form_label",
                                 font: ZodiakTypography.bodySmall,
                                 tracking: ZodiakTypography.BodySize.s.tracking,
                                 color: ZodiakColors.textPrimary,
                                 token: "bodySmall · Regular 400")
                    annotatedRow("catalog.typography.example.form_helper",
                                 font: ZodiakTypography.captionLarge,
                                 tracking: ZodiakTypography.BodySize.xs.tracking,
                                 color: ZodiakColors.textSecondary,
                                 token: "captionLarge · Regular 400")
                }

                ZodiakDivider(hierarchy: .secondary)

                combinationRow(
                    label: "catalog.typography.combination.button_secondary",
                    usage: "catalog.typography.combination.button_secondary.usage"
                ) {
                    annotatedRow("catalog.typography.example.button_label",
                                 font: ZodiakTypography.button,
                                 tracking: ZodiakTypography.BodySize.m.tracking,
                                 color: ZodiakColors.textPrimary,
                                 token: "button · Regular 400")
                    annotatedRow("catalog.typography.example.button_hint",
                                 font: ZodiakTypography.captionLarge,
                                 tracking: ZodiakTypography.BodySize.xs.tracking,
                                 color: ZodiakColors.textSecondary,
                                 token: "captionLarge · Regular 400")
                }

                ZodiakDivider(hierarchy: .secondary)

                combinationRow(
                    label: "catalog.typography.combination.display_body",
                    usage: "catalog.typography.combination.display_body.usage"
                ) {
                    annotatedRow("catalog.typography.example.display_text",
                                 font: ZodiakTypography.titleLarge,
                                 tracking: 0,
                                 color: ZodiakColors.textPrimary,
                                 token: "titleLarge · Light 300")
                    annotatedRow("catalog.typography.example.display_body",
                                 font: ZodiakTypography.bodyLarge,
                                 tracking: ZodiakTypography.BodySize.l.tracking,
                                 color: ZodiakColors.textSecondary,
                                 token: "bodyLarge · Regular 400")
                }
            }
        }
    }

    // MARK: - Combination Row

    @ViewBuilder
    private func combinationRow<Content: View>(
        label: LocalizedStringKey,
        usage: LocalizedStringKey,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
            Text(label)
                .font(ZodiakTypography.captionLarge)
                .tracking(ZodiakTypography.BodySize.xs.tracking)
                .foregroundColor(ZodiakColors.textSecondary)
            VStack(alignment: .leading, spacing: ZodiakSpacing.s16) {
                content()
            }
            Text(usage)
                .font(ZodiakTypography.captionLarge)
                .tracking(ZodiakTypography.BodySize.xs.tracking)
                .foregroundColor(ZodiakColors.textSecondary)
        }
        .padding(.vertical, ZodiakSpacing.s16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Annotated Row

    @ViewBuilder
    private func annotatedRow(
        _ text: LocalizedStringKey,
        font: Font,
        tracking: CGFloat,
        color: Color,
        token: String
    ) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            Text(text)
                .font(font)
                .tracking(tracking)
                .foregroundColor(color)
            Text(verbatim: token)
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.actionPrimary)
                .padding(.horizontal, ZodiakSpacing.s8)
                .padding(.vertical, 2)
                .background(ZodiakColors.background)
                .cornerRadius(ZodiakRadii.l)
        }
    }
}

#Preview {
    ZodiakGalleryShell {
        TypographyCombinationsView()
    }
}
