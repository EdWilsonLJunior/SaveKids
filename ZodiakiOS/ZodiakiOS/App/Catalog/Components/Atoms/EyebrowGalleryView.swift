import SwiftUI

// MARK: - Eyebrow Gallery View
// Zodiak DS — Atoms > Eyebrow

struct EyebrowGalleryView: View {
    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "catalog.component_name.eyebrow",
                subtitle: "catalog.eyebrow.subtitle",
                figmaRef: "Eyebrow"
            )

            // MARK: onLite — Medium
            gallerySectionCard(title: "catalog.section.on_lite_medium") {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                    ZodiakEyebrow(text: "Design Systems", size: .medium, background: .onLite)
                    ZodiakEyebrow(text: "Engineering", size: .medium, background: .onLite)
                    ZodiakEyebrow(text: "Case Study", size: .medium, background: .onLite)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            // MARK: onLite — Small
            gallerySectionCard(title: "catalog.section.on_lite_small") {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                    ZodiakEyebrow(text: "Design Systems", size: .small, background: .onLite)
                    ZodiakEyebrow(text: "Engineering", size: .small, background: .onLite)
                    ZodiakEyebrow(text: "Case Study", size: .small, background: .onLite)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            // MARK: onHeavy — Medium
            gallerySectionCard(title: "catalog.section.on_heavy_medium") {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                    ZodiakEyebrow(text: "Design Systems", size: .medium, background: .onHeavy)
                    ZodiakEyebrow(text: "Engineering", size: .medium, background: .onHeavy)
                    ZodiakEyebrow(text: "Case Study", size: .medium, background: .onHeavy)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(ZodiakSpacing.s8)
                .background(ZodiakColors.surfaceInk)
                .cornerRadius(ZodiakRadii.s)
            }

            // MARK: onHeavy — Small
            gallerySectionCard(title: "catalog.section.on_heavy_small") {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s8) {
                    ZodiakEyebrow(text: "Design Systems", size: .small, background: .onHeavy)
                    ZodiakEyebrow(text: "Engineering", size: .small, background: .onHeavy)
                    ZodiakEyebrow(text: "Case Study", size: .small, background: .onHeavy)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(ZodiakSpacing.s8)
                .background(ZodiakColors.surfaceInk)
                .cornerRadius(ZodiakRadii.s)
            }

            // MARK: In context — above headline
            gallerySectionCard(title: "catalog.section.in_context") {
                VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
                    ZodiakEyebrow(text: "Research", size: .medium, background: .onLite)
                    Text("Why semantic tokens matter at scale")
                        .font(ZodiakTypography.titleSmall)
                        .foregroundColor(ZodiakColors.textPrimary)
                    Text("A practical look at how consistent token layers reduce design debt.")
                        .font(ZodiakTypography.bodySmall)
                        .foregroundColor(ZodiakColors.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .zodiakPage(title: "catalog.component_name.eyebrow")
    }
}

#Preview { NavigationStack { EyebrowGalleryView() } }
