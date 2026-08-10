import SwiftUI

// MARK: - Texts Gallery View

struct TextsGalleryView: View {
    @State private var sampleText = ""
    @State private var selectedTab = 0

    private let tabLabels = [
        "catalog.texts.tab.headings",
        "catalog.texts.tab.body_tab",
        "catalog.texts.tab.specs",
        "catalog.texts.tab.a11y"
    ]

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component.texts",
                subtitle: "catalog.texts.subtitle",
                figmaRef: "Typography"
            )
            ZodiakTabs(tabs: tabLabels, selectedIndex: $selectedTab)
            if selectedTab == 0 {
                playgroundSection
                displayHeadingsSection
                standardHeadingsSection
            } else if selectedTab == 1 {
                bodySection
                italicSection
                alignmentSection
                colorsSection
            } else if selectedTab == 2 {
                TextsSpecsView()
            } else {
                TextsA11yView()
            }
        }
        .zodiakPage(title: "catalog.component.texts")
    }

    // MARK: - Tab 0: Gallery

    private var playgroundSection: some View {
        gallerySectionCard(title: "catalog.section.playground") {
            ZodiakText("catalog.texts.desc.playground", style: .caption(color: .secondary))
            ZodiakTextField(
                label: "catalog.texts.playground_label",
                placeholder: "catalog.texts.playground_placeholder",
                text: $sampleText
            )
            ZodiakText("catalog.texts.playground_hint", style: .body(color: .secondary))
        }
    }

    private var displayHeadingsSection: some View {
        gallerySectionCard(title: "catalog.section.display_headings") {
            ZodiakText("catalog.texts.desc.display", style: .caption(color: .secondary))
            let preview = sampleText.isEmpty ? "catalog.texts.preview_fallback" : sampleText
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                textRow(label: ".headline6XL()") { ZodiakText(preview, style: .headline6XL()) }
                textRow(label: ".headline6XL(weight: .regular)") {
                    ZodiakText(preview, style: .headline6XL(weight: .regular))
                }
                textRow(label: ".headline5XL()") { ZodiakText(preview, style: .headline5XL()) }
                textRow(label: ".headline5XL(weight: .regular)") {
                    ZodiakText(preview, style: .headline5XL(weight: .regular))
                }
                textRow(label: ".headline4XL()") { ZodiakText(preview, style: .headline4XL()) }
                textRow(label: ".headline3XL()") { ZodiakText(preview, style: .headline3XL()) }
                textRow(label: ".headline3XL(weight: .regular)") {
                    ZodiakText(preview, style: .headline3XL(weight: .regular))
                }
                textRow(label: ".headline2XL()") { ZodiakText(preview, style: .headline2XL()) }
                textRow(label: ".headlineXL()") { ZodiakText(preview, style: .headlineXL()) }
            }
        }
    }

    private var standardHeadingsSection: some View {
        gallerySectionCard(title: "catalog.section.standard_headings") {
            ZodiakText("catalog.texts.desc.standard", style: .caption(color: .secondary))
            let preview = sampleText.isEmpty ? "catalog.texts.preview_fallback" : sampleText
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                textRow(label: ".headline") { ZodiakText(preview, style: .headline) }
                textRow(label: ".title1") { ZodiakText(preview, style: .title1) }
                textRow(label: ".title2") { ZodiakText(preview, style: .title2) }
                textRow(label: ".title3") { ZodiakText(preview, style: .title3) }
                textRow(label: ".subtitleSmall") { ZodiakText(preview, style: .subtitleSmall) }
            }
        }
    }

    private var bodySection: some View {
        gallerySectionCard(title: "catalog.section.body_styles") {
            ZodiakText("catalog.texts.desc.body", style: .caption(color: .secondary))
            let preview = sampleText.isEmpty ? "catalog.texts.preview_fallback" : sampleText
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                textRow(label: ".bodyXL()") { ZodiakText(preview, style: .bodyXL()) }
                textRow(label: ".bodyXL(bold: true)") { ZodiakText(preview, style: .bodyXL(bold: true)) }
                textRow(label: ".bodyLarge()") { ZodiakText(preview, style: .bodyLarge()) }
                textRow(label: ".bodyLarge(bold: true)") { ZodiakText(preview, style: .bodyLarge(bold: true)) }
                textRow(label: ".body()") { ZodiakText(preview, style: .body()) }
                textRow(label: ".body(bold: true)") { ZodiakText(preview, style: .body(bold: true)) }
                textRow(label: ".bodySmall()") { ZodiakText(preview, style: .bodySmall()) }
                textRow(label: ".bodySmall(bold: true)") { ZodiakText(preview, style: .bodySmall(bold: true)) }
                textRow(label: ".caption()") { ZodiakText(preview, style: .caption()) }
                textRow(label: ".caption(bold: true)") { ZodiakText(preview, style: .caption(bold: true)) }
            }
        }
    }

    private var italicSection: some View {
        gallerySectionCard(title: "catalog.section.italic") {
            ZodiakText("catalog.texts.desc.italic", style: .caption(color: .secondary))
            let preview = sampleText.isEmpty ? "catalog.texts.preview_fallback" : sampleText
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                textRow(label: ".italic()") { ZodiakText(preview, style: .italic()) }
                textRow(label: ".italic(size: .xl)") { ZodiakText(preview, style: .italic(size: .xl)) }
                textRow(label: ".italic(size: .l)") { ZodiakText(preview, style: .italic(size: .l)) }
                textRow(label: ".italic(size: .s)") { ZodiakText(preview, style: .italic(size: .s)) }
                textRow(label: ".italic(size: .xs, color: .secondary)") {
                    ZodiakText(preview, style: .italic(size: .xs, color: .secondary))
                }
            }
        }
    }

    private var alignmentSection: some View {
        gallerySectionCard(title: "catalog.section.alinhamento") {
            ZodiakText("catalog.texts.desc.alignment", style: .caption(color: .secondary))
            let preview = sampleText.isEmpty ? "catalog.texts.preview_fallback" : sampleText
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                textRow(label: "alignment: .leading (default)") {
                    ZodiakText(preview, style: .body())
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                textRow(label: "alignment: .center") {
                    ZodiakText(preview, style: .body(), alignment: .center)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                textRow(label: "alignment: .trailing") {
                    ZodiakText(preview, style: .body(), alignment: .trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                textRow(label: "lineLimit: 1") { ZodiakText(preview, style: .body(), lineLimit: 1) }
                textRow(label: "lineLimit: 2") { ZodiakText(preview, style: .body(), lineLimit: 2) }
            }
        }
    }

    private var colorsSection: some View {
        gallerySectionCard(title: "catalog.section.cores_de_texto") {
            ZodiakText("catalog.texts.desc.colors", style: .caption(color: .secondary))
            VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                colorTextRow(label: ".primary", colorToken: .primary, onBg: ZodiakColors.surface)
                colorTextRow(label: ".secondary", colorToken: .secondary, onBg: ZodiakColors.surface)
                colorTextRow(label: ".disabled", colorToken: .disabled, onBg: ZodiakColors.surface)
                colorTextRow(label: ".negative", colorToken: .negative, onBg: ZodiakColors.surface)
                colorTextRow(label: ".link", colorToken: .link, onBg: ZodiakColors.surface)
                colorTextRow(label: ".linkHover", colorToken: .linkHover, onBg: ZodiakColors.surface)
                colorTextRow(label: ".linkPressed", colorToken: .linkPressed, onBg: ZodiakColors.surface)
                colorTextRow(
                    label: ".linkInverse", colorToken: .linkInverse,
                    onBg: ZodiakColors.surfaceInk, chipBg: ZodiakColors.surfaceInk
                )
                .environment(\.colorScheme, .light)
                colorTextRow(
                    label: ".inverse", colorToken: .inverse,
                    onBg: ZodiakColors.surfaceInk, chipBg: ZodiakColors.surfaceInk
                )
                .environment(\.colorScheme, .light)
            }
        }
    }

    // MARK: - Helpers

    private func textRow<Content: View>(label: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
            Text(verbatim: label)
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(ZodiakColors.actionPrimary)
                .padding(.horizontal, ZodiakSpacing.s8)
                .padding(.vertical, 2)
                .background(ZodiakColors.background)
                .cornerRadius(ZodiakRadii.l)
            content()
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(ZodiakSpacing.s8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ZodiakColors.surface)
        .cornerRadius(ZodiakRadii.xs)
    }

    private func colorTextRow(
        label: String,
        colorToken: ZodiakTextColor,
        onBg: Color,
        chipBg: Color = ZodiakColors.background
    ) -> some View {
        HStack {
            ZodiakText(verbatim: "Texto \(label)", style: .body(color: colorToken))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(verbatim: label)
                .font(ZodiakTypography.captionLarge)
                .foregroundColor(colorToken.resolvedColor)
                .padding(.horizontal, ZodiakSpacing.s8)
                .padding(.vertical, 2)
                .background(chipBg)
                .overlay(
                    RoundedRectangle(cornerRadius: ZodiakRadii.l)
                        .stroke(colorToken.resolvedColor.opacity(0.75), lineWidth: 1)
                )
                .cornerRadius(ZodiakRadii.l)
        }
        .padding(ZodiakSpacing.s8)
        .background(onBg)
        .cornerRadius(ZodiakRadii.xs)
    }
}

#Preview {
    NavigationStack {
        TextsGalleryView()
    }
}
