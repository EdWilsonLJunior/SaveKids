---
description: "Create a new Zodiak catalog gallery view. Use when adding a component gallery to App/Catalog/. Enforces ZodiakGalleryShell + gallerySectionCard structure, Zodiak token conformance, and intentional visual quality."
argument-hint: "Component name (e.g. ZodiakBadge)"
agent: "agent"
tools: [read, edit, search]
---

Create a new Zodiak catalog gallery view for the component: $input

## Step 1 — Load DS knowledge

Read `.github/skills/ios-zodiak-ds/SKILL.md` → sections "Gallery View Procedure", "Catalog Scaffolding", and "Zodiak Aesthetic Intent".
Read `.github/skills/ios-zodiak-ds/assets/gallery-view.template.swift` for the canonical template.

## Step 2 — Read the DS component

Locate `ZodiakiOS/Shared/DesignSystem/` → find the folder containing `$input.swift`.
Read the component file in full to extract:
- **Init signature(s)** — all parameters, types, and defaults
- **Variants / styles** — enum cases for `style:`, `variant:`, `size:` parameters
- **States** — enabled, disabled, loading, selected, etc.

**Never** infer API from existing Catalog files or Features/ — read the component source directly.

## Step 3 — Plan the section layout

Design sections before writing code:

| Section | Content |
|---|---|
| `galleryHeader` | Component name, one-line description, Figma ref (if known) |
| Variants | All style/variant cases with `ZodiakText(.caption)` labels |
| States | Enabled, disabled, and interactive states |
| Specs | Key parameters documented with `ZodiakInfoRow` + `.spec()` |

Also apply **Zodiak Aesthetic Intent** to the gallery itself:
- Use `.title3` or `.caption(bold: true)` for demonstration labels — not `.body()` for everything
- Vary spacing: `s8` (8pt) within card rows, `s24` (24pt) between section cards
- Use `ZodiakColors.brand` on at most one featured element (e.g., a "Featured" badge or a primary variant strip)

## Step 4 — Structure (mandatory)

Every gallery view MUST use this exact shell:

```swift
struct <Name>GalleryView: View {
    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(title: "<title>", subtitle: "<subtitle>", figmaRef: "<FigmaComponentName>")
            gallerySectionCard(title: "catalog.section.variantes") { ... }
            gallerySectionCard(title: "catalog.section.especificacoes") {
                ZodiakInfoRow("Label", value: "valor", style: .spec())
            }
        }
        .zodiakPage(title: "catalog.component_name.<name>")
    }
}
```

- `ZodiakGalleryShell` is defined in `ZodiakiOS/App/Catalog/ZodiakGalleryShell.swift`
- `gallerySectionCard` and `galleryHeader` are in `ZodiakiOS/App/Catalog/CatalogGalleryHelpers.swift`

### Source of truth
All components shown inside sections MUST come from `ZodiakiOS/Shared/DesignSystem/` ONLY.

### Forbidden patterns
- `ScrollView { VStack { ... } }` as root — use `ZodiakGalleryShell` instead
- `.navigationTitle(...)` — use `.zodiakPage(title:)` instead
- `private func specRow(...)` — use `ZodiakInfoRow("key", value: "value", style: .spec())` directly
- Hardcoded colors — use `ZodiakColors.*` tokens only
- Hardcoded spacing — use `ZodiakSpacing.*` tokens only
- Overlay modifiers (`.sheet`, `.alert`) inside `ZodiakGalleryShell` — chain after `.zodiakPage(title:)`

## Step 5 — Localization

All user-facing strings use `String(localized: ...)` or `LocalizedStringKey`.
New keys follow namespace: `catalog.<component_name>.*`
Add new keys to **both** localization files:
- `ZodiakiOS/en.lproj/Localizable.strings`
- `ZodiakiOS/pt-BR.lproj/Localizable.strings`

## Step 6 — Register in catalog navigation

Search for the catalog's component list in `App/Catalog/`.
Add `$inputGalleryView` as a navigation destination in the correct Atomic Design section.

## Step 7 — Run SwiftLint

```
swiftlint lint --fix --config .swiftlint.yml ZodiakiOS/App/Catalog/
```

## Output
1. Confirm component API read from `Shared/DesignSystem/`
2. File created: `App/Catalog/Components/<Layer>/<Name>GalleryView.swift`
3. Sections implemented: [list]
4. Localization keys added: N keys in both files
5. SwiftLint: clean / N remaining violations
