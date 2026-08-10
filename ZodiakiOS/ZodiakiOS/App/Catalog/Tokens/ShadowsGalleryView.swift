import SwiftUI

// MARK: - Shadows Gallery View

struct ShadowsGalleryView: View {
    @State private var showShadow = true

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.shadows",
                subtitle: "catalog.shadow.subtitle",
                figmaRef: "FOUNDATIONS · SHADOWS"
            )

            gallerySectionCard(title: "catalog.shadow.static_examples") {
                HStack(spacing: ZodiakSpacing.s8) {
                    shadowStaticCard(label: "catalog.shadow.without_label", hasShadow: false)
                    shadowStaticCard(label: "catalog.shadow.with_label", hasShadow: true)
                }
                .padding(ZodiakSpacing.s8)
                .frame(maxWidth: .infinity)
                .background(ZodiakColors.background)
                .cornerRadius(ZodiakRadii.s)
                ZodiakText("catalog.shadow.flat_note", style: .caption())
                    .fixedSize(horizontal: false, vertical: true)
            }

            gallerySectionCard(title: "catalog.radii.shadow_title") {
                ZodiakText("catalog.shadow.single_desc", style: .body(color: .secondary))
                    .fixedSize(horizontal: false, vertical: true)
                ZodiakSwitch(label: "catalog.shadow.show_label", isOn: $showShadow)
                VStack(spacing: ZodiakSpacing.s8) {
                    ZodiakText("catalog.shadow.without_label", style: .body())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(ZodiakSpacing.s16)
                        .background(ZodiakColors.surfaceSmoke)
                        .cornerRadius(ZodiakRadii.s)
                        .overlay(
                            RoundedRectangle(cornerRadius: ZodiakRadii.s)
                                .stroke(ZodiakColors.borderPrimary, lineWidth: ZodiakBorders.default)
                        )

                    if showShadow {
                        ZodiakText("catalog.shadow.with_label", style: .body())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(ZodiakSpacing.s16)
                            .background(ZodiakColors.surface)
                            .cornerRadius(ZodiakRadii.s)
                            .shadow(
                                color: ZodiakShadows.color,
                                radius: ZodiakShadows.radius,
                                x: ZodiakShadows.x,
                                y: ZodiakShadows.y
                            )
                    }
                }
                .padding(ZodiakSpacing.s8)
                .frame(maxWidth: .infinity)
                .background(ZodiakColors.background)
                .cornerRadius(ZodiakRadii.s)
                .animation(.easeInOut(duration: 0.2), value: showShadow)
            }

            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow(
                    "catalog.shadow.spec.color",
                    value: "catalog.shadow.spec.val.color",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.shadow.spec.blur",
                    value: "catalog.shadow.spec.val.blur",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.shadow.spec.x_offset",
                    value: "catalog.shadow.spec.val.x_offset",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.shadow.spec.y_offset",
                    value: "catalog.shadow.spec.val.y_offset",
                    style: .spec()
                )
                ZodiakInfoRow(
                    "catalog.shadow.spec.spread",
                    value: "catalog.shadow.spec.val.spread",
                    style: .spec()
                )
            }

            gallerySectionCard(title: "catalog.shadow.section_tokens") {
                tokenRow(label: "ZodiakShadows.color",
                         value: "rgba(0,0,0,0.03)")
                Divider()
                tokenRow(label: "ZodiakShadows.radius",
                         value: "35pt")
                Divider()
                tokenRow(label: "ZodiakShadows.x",
                         value: "4pt")
                Divider()
                tokenRow(label: "ZodiakShadows.y",
                         value: "0pt")
            }
        }
        .zodiakPage(title: "catalog.component.shadows")
    }
}

// MARK: - Helpers

private extension ShadowsGalleryView {
    func shadowStaticCard(label: String, hasShadow: Bool) -> some View {
        ZodiakText(label, style: .body())
            .frame(maxWidth: .infinity, minHeight: 64, alignment: .center)
            .padding(ZodiakSpacing.s16)
            .background(hasShadow ? ZodiakColors.surface : ZodiakColors.surfaceSmoke)
            .cornerRadius(ZodiakRadii.s)
            .overlay(
                RoundedRectangle(cornerRadius: ZodiakRadii.s)
                    .stroke(
                        hasShadow ? Color.clear : ZodiakColors.borderPrimary,
                        lineWidth: ZodiakBorders.default
                    )
            )
            .shadow(
                color: hasShadow ? ZodiakShadows.color : .clear,
                radius: ZodiakShadows.radius,
                x: ZodiakShadows.x,
                y: ZodiakShadows.y
            )
    }

    func tokenRow(label: String, value: String) -> some View {
        HStack {
            Text(verbatim: label)
                .font(ZodiakTypography.bodySmall.monospaced())
                .foregroundColor(ZodiakColors.textPrimary)
            Spacer()
            Text(verbatim: value)
                .font(ZodiakTypography.captionLarge.monospaced())
                .foregroundColor(ZodiakColors.actionPrimary)
                .padding(.horizontal, ZodiakSpacing.s4)
                .padding(.vertical, 2)
                .background(ZodiakColors.actionPrimary.opacity(0.1))
                .cornerRadius(ZodiakRadii.xs)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack { ShadowsGalleryView() }
}

#Preview("Dark") {
    NavigationStack { ShadowsGalleryView() }
        .preferredColorScheme(.dark)
}
