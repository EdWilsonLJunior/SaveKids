import SwiftUI

// MARK: - Typography Gallery View

private struct TypographyStyle {
    let name: String
    let font: Font
    let tracking: CGFloat
    let size: String
    let weight: String
}

struct TypographyGalleryView: View {
    @State private var sampleText = ""
    @State private var selectedTab = 0

    private let tabLabels = [
        "catalog.typography.tab.preview",
        "catalog.typography.tab.specs",
        "catalog.typography.tab.combinations"
    ]

    private let styles: [TypographyStyle] = [
        TypographyStyle(
            name: "Headline",
            font: ZodiakTypography.titleLarge,
            tracking: 0,
            size: "32pt",
            weight: "Light (300)"
        ),
        TypographyStyle(
            name: "Title 1",
            font: ZodiakTypography.titleMedium,
            tracking: ZodiakTypography.HeadingSize.medium.tracking(for: .light),
            size: "24pt",
            weight: "Light (300)"
        ),
        TypographyStyle(
            name: "Title 2",
            font: ZodiakTypography.titleSmall,
            tracking: ZodiakTypography.HeadingSize.small.tracking(for: .regular),
            size: "18pt",
            weight: "Regular (400)"
        ),
        TypographyStyle(
            name: "Title 3",
            font: ZodiakTypography.labelLarge,
            tracking: ZodiakTypography.HeadingSize.xSmall.tracking(for: .regular),
            size: "16pt",
            weight: "Regular (400)"
        ),
        TypographyStyle(
            name: "Body XL",
            font: ZodiakTypography.bodyXL,
            tracking: ZodiakTypography.BodySize.xl.tracking,
            size: "24pt",
            weight: "Regular (400)"
        ),
        TypographyStyle(
            name: "Body Large",
            font: ZodiakTypography.bodyLarge,
            tracking: ZodiakTypography.BodySize.l.tracking,
            size: "18pt",
            weight: "Regular (400)"
        ),
        TypographyStyle(
            name: "Body",
            font: ZodiakTypography.bodyMedium,
            tracking: ZodiakTypography.BodySize.m.tracking,
            size: "16pt",
            weight: "Regular (400)"
        ),
        TypographyStyle(
            name: "Body Small",
            font: ZodiakTypography.bodySmall,
            tracking: ZodiakTypography.BodySize.s.tracking,
            size: "14pt",
            weight: "Regular (400)"
        ),
        TypographyStyle(
            name: "Subtitle Small",
            font: ZodiakTypography.labelMedium,
            tracking: ZodiakTypography.HeadingSize.twoXSmall.tracking(for: .regular),
            size: "14pt",
            weight: "Regular (400)"
        ),
        TypographyStyle(
            name: "Caption",
            font: ZodiakTypography.captionLarge,
            tracking: ZodiakTypography.BodySize.xs.tracking,
            size: "12pt",
            weight: "Regular (400)"
        ),
        TypographyStyle(
            name: "Button",
            font: ZodiakTypography.button,
            tracking: ZodiakTypography.BodySize.m.tracking,
            size: "16pt",
            weight: "Regular (400)"
        )
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.typography",
                subtitle: "catalog.typography.typeface_desc",
                figmaRef: "Typography"
            )
            ZodiakTabs(tabs: tabLabels, selectedIndex: $selectedTab)
            if selectedTab == 0 {
                gallerySectionCard(title: "catalog.typography.interactive_preview") {
                    ZodiakTextField(
                        label: "catalog.typography.custom_text_label",
                        placeholder: "catalog.typography.custom_text_placeholder",
                        text: $sampleText
                    )
                    ZodiakText("catalog.typography.preview_hint", style: .body(color: .secondary))
                }
                gallerySectionCard(title: "catalog.typography.scale_label") {
                    ForEach(styles, id: \.name) { style in
                        specimenCard(style)
                    }
                }
            } else if selectedTab == 1 {
                gallerySectionCard(title: "catalog.section.specifications") {
                    specsTable
                }
            } else {
                combinationsSection
            }
        }
        .zodiakPage(title: "catalog.component.typography")
    }

    // MARK: - Specimen Card

    private func specimenCard(_ style: TypographyStyle) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            Text(sampleText.isEmpty ? style.name : sampleText)
                .font(style.font)
                .tracking(style.tracking)
                .foregroundColor(ZodiakColors.textPrimary)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            HStack(spacing: ZodiakSpacing.s8) {
                Text(style.name)
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.actionPrimary)
                    .padding(.horizontal, ZodiakSpacing.s8)
                    .padding(.vertical, 2)
                    .background(ZodiakColors.background)
                    .cornerRadius(ZodiakRadii.l)
                Text(verbatim: "\(style.size) · \(style.weight)")
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
            }
        }
        .padding(ZodiakSpacing.s8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
    }

    // MARK: - Combinations Section

    private var combinationsSection: some View {
        TypographyCombinationsView()
    }

    // MARK: - Specs Table

    private var specsTable: some View {
        VStack(spacing: 1) {
            HStack {
                Text(LocalizedStringKey("catalog.spec.label_style"))
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(LocalizedStringKey("catalog.typography.desc_0"))
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                    .frame(width: 48, alignment: .center)
                Text(LocalizedStringKey("catalog.spec.label_weight"))
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
                    .frame(width: 88, alignment: .center)
            }
            .padding(ZodiakSpacing.s8)
            .background(ZodiakColors.surfaceSmoke)

            ForEach(styles, id: \.name) { style in
                HStack {
                    Text(verbatim: style.name)
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(verbatim: style.size)
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textSecondary)
                        .frame(width: 48, alignment: .center)
                    Text(verbatim: style.weight)
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textSecondary)
                        .frame(width: 88, alignment: .center)
                }
                .padding(ZodiakSpacing.s8)
                .background(ZodiakColors.surface)
            }
        }
        .cornerRadius(ZodiakRadii.xs)
    }
}

#Preview {
    NavigationStack {
        TypographyGalleryView()
    }
}
