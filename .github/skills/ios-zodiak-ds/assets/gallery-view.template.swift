// TEMPLATE: Zodiak Catalog Gallery View
// Copy this file and replace all <Placeholder> values.
// Source of truth for DS components: ZodiakiOS/Shared/DesignSystem/
// Scaffolding helpers: App/Catalog/ZodiakGalleryShell.swift + CatalogGalleryHelpers.swift
//
// Replace:
//   <ComponentName>     → e.g. "ZodiakBadge"
//   <component_name>    → e.g. "badge"
//   <Layer>             → Atoms / Molecules / Organisms
//   <subtitle>          → short description for galleryHeader
//   <FigmaRef>          → Figma component name (e.g. "Badge")

import SwiftUI

// MARK: - <ComponentName> Gallery View
struct <ComponentName>GalleryView: View {

    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(
                title: "<ComponentName>",
                subtitle: String(localized: "catalog.<component_name>.subtitle"),
                figmaRef: "<FigmaRef>"
            )

            // MARK: Variants
            // Show all visual variants of the component.
            // Use components from Shared/DesignSystem/ ONLY.
            gallerySectionCard(title: "catalog.section.variantes") {
                VStack(spacing: ZodiakSpacing.twoXSmall) {
                    // <ComponentName>(...)   ← default variant
                    // <ComponentName>(...)   ← other variant
                }
            }

            // MARK: States (include only if component has interactive states)
            gallerySectionCard(title: "catalog.section.estados") {
                VStack(spacing: ZodiakSpacing.twoXSmall) {
                    // enabled state
                    // disabled state
                }
            }

            // MARK: Specifications
            // Use ZodiakInfoRow(.spec()) — never a private func specRow
            gallerySectionCard(title: "catalog.section.especificacoes") {
                VStack(spacing: ZodiakSpacing.threeXSmall) {
                    ZodiakInfoRow("Altura", value: "<height>pt", style: .spec())
                    ZodiakInfoRow("Raio", value: "ZodiakRadii.<token> (<value>pt)", style: .spec())
                    ZodiakInfoRow("Tipografia", value: "ZodiakTypography.<token>", style: .spec())
                    ZodiakInfoRow("Cor", value: "ZodiakColors.<token>", style: .spec())
                    ZodiakInfoRow("Espaçamento", value: "ZodiakSpacing.<token> (<value>pt)", style: .spec())
                }
            }
        }
        // .zodiakPage is the ONLY way to set navigation title in gallery views
        .zodiakPage(title: "catalog.component_name.<component_name>")
    }
}

#Preview {
    NavigationStack {
        <ComponentName>GalleryView()
    }
}

// MARK: - Localization keys to add in Localizable.xcstrings
// catalog.<component_name>.subtitle = "<en description>" / "<pt-BR description>"
