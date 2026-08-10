import SwiftUI

// MARK: - Borders Gallery View

struct BordersGalleryView: View {
    private let weights: [(name: String, value: CGFloat, desc: String)] = [
        ("hairline", ZodiakBorders.hairline, "catalog.borders.hairline_desc"),
        ("default", ZodiakBorders.default, "catalog.borders.default_desc"),
        ("strong", ZodiakBorders.strong, "catalog.borders.strong_desc")
    ]

    private let colorTokens: [(name: String, color: Color, label: String)] = [
        ("borderPrimary", ZodiakColors.borderPrimary, "catalog.borders.color_primary_desc"),
        ("borderSecondary", ZodiakColors.borderSecondary, "catalog.borders.color_secondary_desc")
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.borders",
                subtitle: "catalog.borders.subtitle",
                figmaRef: "FOUNDATIONS · BORDERS"
            )

            gallerySectionCard(title: "catalog.borders.section_weights") {
                ForEach(weights, id: \.name) { token in
                    borderWeightRow(token)
                    if token.name != weights.last?.name {
                        Divider()
                    }
                }
            }

            gallerySectionCard(title: "catalog.borders.section_colors") {
                ForEach(colorTokens, id: \.name) { token in
                    borderColorRow(token)
                    if token.name != colorTokens.last?.name {
                        Divider()
                    }
                }
            }

            gallerySectionCard(title: "catalog.borders.section_in_context") {
                ZodiakLayoutGrid(
                    columns: 3,
                    horizontalSpacing: ZodiakSpacing.s8,
                    verticalSpacing: ZodiakSpacing.s8
                ) {
                    borderContextCard(
                        label: "catalog.borders.ctx.hairline",
                        weight: ZodiakBorders.hairline,
                        color: ZodiakColors.borderSecondary
                    )
                    borderContextCard(
                        label: "catalog.borders.ctx.default",
                        weight: ZodiakBorders.default,
                        color: ZodiakColors.borderPrimary
                    )
                    borderContextCard(
                        label: "catalog.borders.ctx.strong",
                        weight: ZodiakBorders.strong,
                        color: ZodiakColors.actionPrimary
                    )
                }
            }

            gallerySectionCard(title: "catalog.borders.section_spec") {
                ZodiakInfoRow(
                    "catalog.borders.spec.hairline",
                    value: "catalog.borders.spec.val.hairline",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.borders.spec.default",
                    value: "catalog.borders.spec.val.default",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.borders.spec.strong",
                    value: "catalog.borders.spec.val.strong",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.borders.spec.color_primary",
                    value: "catalog.borders.spec.val.color_primary",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.borders.spec.color_secondary",
                    value: "catalog.borders.spec.val.color_secondary",
                    style: .spec()
                )
            }
        }
        .zodiakPage(title: "catalog.component.borders")
    }
}

// MARK: - Helpers

private extension BordersGalleryView {
    func borderWeightRow(_ token: (name: String, value: CGFloat, desc: String)) -> some View {
        HStack(spacing: ZodiakSpacing.s8) {
            Rectangle()
                .fill(ZodiakColors.borderPrimary)
                .frame(width: max(token.value * 2, 2), height: 40)
                .cornerRadius(1)
            VStack(alignment: .leading, spacing: 2) {
                Text(verbatim: "ZodiakBorders.\(token.name)")
                    .font(ZodiakTypography.bodySmall.monospaced())
                    .foregroundColor(ZodiakColors.textPrimary)
                Text(LocalizedStringKey(token.desc))
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
            }
            Spacer()
            Text(verbatim: String(format: "%.1fpt", token.value))
                .font(ZodiakTypography.captionLarge.monospaced())
                .foregroundColor(ZodiakColors.actionPrimary)
                .padding(.horizontal, ZodiakSpacing.s4)
                .padding(.vertical, 2)
                .background(ZodiakColors.actionPrimary.opacity(0.1))
                .cornerRadius(ZodiakRadii.xs)
        }
        .padding(.vertical, ZodiakSpacing.s4)
    }

    func borderColorRow(_ token: (name: String, color: Color, label: String)) -> some View {
        HStack(spacing: ZodiakSpacing.s8) {
            RoundedRectangle(cornerRadius: ZodiakRadii.xs)
                .stroke(token.color, lineWidth: ZodiakBorders.default)
                .frame(width: 40, height: 40)
            VStack(alignment: .leading, spacing: 2) {
                Text(verbatim: "ZodiakColors.\(token.name)")
                    .font(ZodiakTypography.bodySmall.monospaced())
                    .foregroundColor(ZodiakColors.textPrimary)
                Text(LocalizedStringKey(token.label))
                    .font(ZodiakTypography.captionLarge)
                    .foregroundColor(ZodiakColors.textSecondary)
            }
            Spacer()
        }
        .padding(.vertical, ZodiakSpacing.s4)
    }

    func borderContextCard(label: String, weight: CGFloat, color: Color) -> some View {
        VStack(spacing: ZodiakSpacing.s8) {
            RoundedRectangle(cornerRadius: ZodiakRadii.s)
                .fill(ZodiakColors.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: ZodiakRadii.s)
                        .stroke(color, lineWidth: weight)
                )
                .frame(height: 56)
            Text(LocalizedStringKey(label))
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(ZodiakSpacing.s8)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.s)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack { BordersGalleryView() }
}

#Preview("Dark") {
    NavigationStack { BordersGalleryView() }
        .preferredColorScheme(.dark)
}
