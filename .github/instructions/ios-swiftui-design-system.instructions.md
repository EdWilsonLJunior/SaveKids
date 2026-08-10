---
description: "Use when creating or updating SwiftUI views, components, forms, layout, spacing, typography, colors, dark mode behavior, or localization-facing UI in ZodiakiOS. Enforces Design System reuse and avoids hardcoded visual styles."
name: "SwiftUI Design System Rules"
applyTo: "ZodiakiOS/**/*.swift"
---

# SwiftUI Design System Rules

## Primary Goal

<rules>
- Keep UI changes consistent with the existing Atomic Design system and Zodiak theme tokens.
</rules>

## Reuse Before Creating

<rules>
- Reuse existing components in ZodiakiOS/Shared/DesignSystem before introducing new UI primitives.
- Prefer composing Atoms, Molecules, Organisms, Compositions, and Templates over custom ad-hoc views.
- If a new reusable UI element is needed, place it in the correct Design System layer, not inside a feature screen.
</rules>

### Atomic Design Layers (in order)
| Layer | Folder | Examples |
|---|---|---|
| Atoms | `Shared/DesignSystem/Atoms/` | `ZodiakButton`, `ZodiakBadge`, `ZodiakDivider` |
| Molecules | `Shared/DesignSystem/Molecules/` | `ZodiakCardItem`, `ZodiakInfoRow`, `ZodiakTextField` |
| Organisms | `Shared/DesignSystem/Organisms/` | `ZodiakCardGrid`, `ZodiakHero`, `ZodiakCarousel` |
| Templates | `Shared/DesignSystem/Templates/` | `ZodiakAdaptiveTemplate`, `ZodiakLayoutGrid` |
| Compositions | `App/Catalog/Components/Compositions/` | Gallery views combining multiple organisms into full-screen sections |

## Component Discovery Catalog

Before writing any SwiftUI code, scan this catalog to find the correct DS component. Always prefer the highest applicable layer. Full API + guidelines in `.github/skills/ios-zodiak-ds/references/`.

### Screen Templates (always use as root in `Features/`)
| Component | When to use |
|---|---|
| `ZodiakActivityTemplate` | Standard feature screen with title, optional eyebrow/intro, scrollable content |
| `ZodiakListTemplate` | Feature screen that renders a list of items with built-in empty state |
| `ZodiakInputOutputTemplate` | Feature screen with input fields and a pinned submit button at the bottom |
| `ZodiakAdaptiveTemplate` | Same as ActivityTemplate but always centers content (max 1024pt) — for iPad-first screens |

#### `ZodiakActivityTemplate` — slot rules
- **`content` slot** (main): receives `ZodiakSpacing.screenPad` horizontal padding automatically. Use for forms, text sections, and heroes.
- **`edgeToEdgeContent` slot**: cancels horizontal padding — full bleed. Use only for `ZodiakChipGroup` filter strips and edge-to-edge images.
- ⚠️ Hero components must go in the `content` slot, **not** `edgeToEdgeContent`; otherwise the hero loses its inset and renders flush against the edges.

### Buttons
| Component | When to use |
|---|---|
| `ZodiakButton` | Primary CTA — filled, pill, 48pt. Max 1–2 per screen |
| `ZodiakSecondaryButton` | Secondary action — outlined, pill. Max ~4 per screen |
| `ZodiakTertiaryButton` | Low-priority action — underlined text only. No limit. ⚠️ Not allowed on photo backgrounds |
| `ZodiakDangerButton` | Destructive action (delete, cancel account). Always follow with confirmation |
| `ZodiakSmallButton` | Same as primary but 38pt height — compact layouts |
| `ZodiakIconButton` | Icon-only action. Sizes: `.small` 32pt / `.medium` 40pt / `.large` 48pt |
| `ZodiakArrowButton` | Inline navigation arrow with text label |
| `ZodiakCircularArrowButton` | Circular nav arrow (card navigation, hero prev/next). Use when entire card is clickable and visual alignment with text matters |
| `ZodiakFilterButton` | Filter trigger with active-count badge |
| `ZodiakMenuButton` | Groups multiple related actions under one control (opens SwiftUI Menu) |
| `ZodiakSystemButton` | Compact rectangular button for complex system UIs only — ⚠️ not for regular pages |
| `ZodiakMediaButton` | Audio/video playback controls (play, pause, skip, volume, etc.) |
| `ZodiakVideoPreviewButton` | Pause/resume an auto-playing video preview — always bottom-right of video |

### Text & Labels
| Component | When to use |
|---|---|
| `ZodiakText` | All text. Use `ZodiakTextStyle` — never SwiftUI `Text` with raw fonts in features |
| `ZodiakEyebrow` | Short 1–2 word category label above a headline. Never a link. Never standalone |
| `ZodiakTextLink` | Inline tappable link within body text |
| `ZodiakTooltip` / `.zodiakTooltip()` | Brief contextual info on tap. Short text only — never critical info |

#### ZodiakText — correct usage patterns

```swift
// ✅ Localization key (static literal)
ZodiakText("feature.my_feature.title", style: .title2)

// ✅ Verbatim — runtime value, not a localization key
ZodiakText(verbatim: user.name, style: .body())

// ✅ Format string with Int interpolation (xcstrings key: "feature.key %lld")
ZodiakText("feature.my_feature.table_title \(tableNumber)", style: .title2)

// ❌ Never: Text with raw font/color in features or catalog galleries
Text("feature.my_feature.title")
    .font(ZodiakTypography.bodyLarge)
    .foregroundStyle(ZodiakColors.textPrimary)
```

Exception: `Text` with `.textCase(.uppercase)` + `.tracking(...)` (section headers in catalog gallery views)
when `ZodiakText` doesn't expose those modifiers — acceptable only in catalog, not in feature screens.

### Badges & Status
| Component | When to use |
|---|---|
| `ZodiakSuccessBadge` / `ZodiakErrorBadge` / `ZodiakWarningBadge` | Semantic status pill — use the correct variant, never hardcode color |
| `ZodiakBadge` | Custom-color badge when no semantic variant fits |
| `ZodiakChip` | Selectable filter tag — shows checkmark when active. Tap toggles |
| `ZodiakChipGroup` | Group of selectable chips (single or multi-select) |

### Input & Forms
| Component | When to use |
|---|---|
| `ZodiakTextField` | Free-text input with label, helper text, error state |
| `ZodiakSearchField` | Search-specific text input with magnifying glass icon |
| `ZodiakPasswordField` | Secure text input with show/hide toggle |
| `ZodiakLabelledField` | High-level text field molecule (label + field + error) — prefer over raw ZodiakTextField in forms |
| `ZodiakDropdown` | Select one option from a short/medium predefined list |
| `ZodiakCombobox` | Select one option from a long or dynamic list (with search/filter) |
| `ZodiakMultiselect` | Select multiple options from a predefined list |
| `ZodiakPhoneInput` | Phone number input with flag/country-code dropdown |
| `ZodiakCounterControl` | Increment/decrement numeric value with min/max |
| `ZodiakCheckbox` / `ZodiakCheckboxGroup` | Multi-select when all options must be visible simultaneously |
| `ZodiakRadioButton` / `ZodiakRadioGroup` | Single-select, ≤5 options needing quick comparison |
| `ZodiakSwitch` | Binary toggle with immediate effect (no Save button needed) |
| `ZodiakInputWizard` | Multi-step form flow with back/next navigation |
| `ZodiakSlideToSubmit` | Slide-gesture confirmation for high-stakes actions |
| `ZodiakFormWrapper` | Wraps form fields with consistent spacing |

### Cards & Content
| Component | When to use |
|---|---|
| `ZodiakCardGrid` | Responsive grid of standard cards (2–9 cards, optional ShowMore) |
| `ZodiakHorizontalCard` | Card with image on left + text on right — compact list layout |
| `ZodiakTallCard` | Card with tall image — use in groups of 3 for visual impact |
| `ZodiakRevealCard` | Card with hidden content behind blur overlay, revealed on tap |
| `ZodiakTypographicCard` | Text-only card with optional icon/number — no image required |
| `ZodiakAuthorCard` | Card with author attribution — use when expert/credibility matters |
| `ZodiakShortFactsCard` | Grid of icon + value + label facts (key metrics, stats) |

### Lists & Data
| Component | When to use |
|---|---|
| `ZodiakInfoRow` | Label + value display row — use `.data` style in features, `.spec()` in catalog |
| `ZodiakListingRow` / `ZodiakListingGroup` | Editorial list rows with eyebrow, title, summary, image. Chevron implies navigation — only use when tapping navigates |
| `ZodiakFAQList` | Accordion-based FAQ section |
| `ZodiakList` | Bulleted or numbered plain text list |
| `ZodiakResultCard` | Highlights a computed value (title + value + subtitle) |
| `ZodiakKeyFigures` | Grid of key metric items (value + label + detail) |
| `ZodiakShowMore` | Progressively reveals more items without page change |

### Feedback & Overlays
| Component | When to use |
|---|---|
| `ZodiakAlert` | Inline status message (info / success / warning / error) inside a form or section |
| `ZodiakNotice` | Brief contextual notification (warning / success / information) — dismissible |
| `ZodiakBanner` | Full-width top banner for global messages |
| `ZodiakNotificationBanner` | App notification with optional CTA — variants: `.information` / `.positive` / `.warning` |
| `.zodiakToast()` | Ephemeral floating message — applied as a view modifier on the screen root |
| `.zodiakModal()` / `ZodiakModal` | Modal overlay for critical decisions, required input, or permissions |
| `ZodiakBottomSheet` | Sheet drawer from bottom — lighter than a modal |
| `ZodiakEmptyState` | Empty list or error state with icon, title, optional action |
| `ZodiakFormInDrawer` | Full form in a slide-out drawer — for data collection that would overwhelm a modal |

### Media & Rich Content
| Component | When to use |
|---|---|
| `ZodiakHero` | Large hero section at page top. Styles: `.small` / `.large` / `.split` / `.fullscreen` / `.typographic` |
| `ZodiakImageBlock` | Single image with title/summary |
| `ZodiakCarousel` | Horizontally scrollable image tiles |
| `ZodiakMasonryGrid` | Variable-height image grid |
| `ZodiakPreamble` | Article intro with eyebrow, title, summary — used at top of content pages |
| `ZodiakTextBlock` | Rich text section with optional large/small heading and 1 or 2 column layout |
| `ZodiakQuote` | Pull quote with optional author |
| `ZodiakHeadlineSection` | Section title with optional filter/intro |

### Navigation & Progress
| Component | When to use |
|---|---|
| `ZodiakTabs` / `ZodiakTabContainer` | 2–7 mutually exclusive content sections. No nested tabs |
| `ZodiakStepIndicator` | Multi-step progress bar |
| `ZodiakProgressBar` | Linear progress (0.0–1.0) |
| `ZodiakProgressRing` | Circular progress with optional label |
| `ZodiakSpinner` | Indeterminate loading indicator |
| `ZodiakBreadcrumb` | Hierarchical navigation path |
| `ZodiakPagination` | Page number navigation |
| `ZodiakSkeletonLine` / `ZodiakSkeletonRect` / `ZodiakSkeletonCircle` | Loading placeholder shapes |

### Display Utilities
| Component | When to use |
|---|---|
| `ZodiakDivider` | Semantic horizontal separator |
| `ZodiakAvatar` | User/group/brand representation with initials or image |
| `ZodiakIconView` | Renders a `ZodiakIcon` with consistent size and color |
| `ZodiakFlagView` | Country flag by `ZodiakFlagCountry` |
| `ZodiakLogoView` | Capgemini logo variants |
| `ZodiakPin` | Map pin or location marker |
| `ZodiakRating` | Interactive star rating |
| `ZodiakRatingDisplay` | Read-only fractional star display |
| `ZodiakAuthor` | Author attribution molecule (avatar + name + optional meta) |

## Selection Component Decision Tree

When you need the user to choose from options:

```
1 option, list ≤20 items, static    → ZodiakDropdown
1 option, list long or dynamic      → ZodiakCombobox (has built-in search)
Multiple options, list known        → ZodiakMultiselect
1 option, ≤5 items, quick compare   → ZodiakRadioGroup
Multiple, all options visible       → ZodiakCheckboxGroup
Binary, immediate effect            → ZodiakSwitch  (no Save needed)
Binary, needs confirmation          → ZodiakDangerButton + ZodiakModal
```

## Button Hierarchy Rules

```
Primary   (ZodiakButton)          max 1–2 per screen — the main CTA
Secondary (ZodiakSecondaryButton) max ~4 per screen
Tertiary  (ZodiakTertiaryButton)  no limit — ⚠️ never on photo backgrounds
Danger    (ZodiakDangerButton)    always requires confirmation dialog
Spacing between buttons: always ZodiakSpacing.s16 (16pt)
```

## Styling Constraints

<rules>
- Do not hardcode colors for production UI.
- Prefer semantic/theme-based colors already available in the project and asset catalog.
- Keep spacing, radius, and typography aligned with existing tokens/patterns from the design system.
</rules>

## Blur
- Use `ZodiakBlur` tokens (`ZodiakBlur.radius`, `.pageOverlay`, `.colorOverlay`) — defined in `Shared/DesignSystem/Tokens/ZodiakBlur.swift`.
- Apply blur always in 2 steps: `image.overlay(ZodiakBlur.pageOverlay)` on the photo, then `.zodiakBlurBackground()` on the content container.
- Content over blur must always be light (`ZodiakColors.textInverse`, light buttons). Never place dark text or dark buttons on blur.
- Do not use SwiftUI's raw `.blur(radius:)` — it bypasses the DS token and the official color overlay.
- Do not apply blur over solid-color backgrounds — only over photographic images.

## Dark Mode Safety

<rules>
- Avoid fixed foreground/background combinations that can break contrast in dark mode.
- When touching status chips, badges, or cards, verify contrast and adaptive behavior in light and dark appearances.
- If a visual change may impact known dark-mode hotspots, check the audit: [dark-mode-audit.md](../../docs/dark-mode-audit.md)
</rules>

### `textInverse` vs `textAlwaysWhite` — critical distinction
- `ZodiakColors.textInverse` is **adaptive**: white in light mode, near-black (`#171a22`) in dark mode.
- `ZodiakColors.textAlwaysWhite` is **always white** regardless of color scheme.
- ⚠️ **On dark surfaces** (`.onHeavy` eyebrow, `.azur` card background, hero with gradient), always use `textAlwaysWhite`. Using `textInverse` will make text invisible in dark mode.
- Affected components to check: `ZodiakEyebrow(.onHeavy)`, `ZodiakHero` title/summary/metrics, `ZodiakTypographicCard(.azur/.heavy)`.

## Input And Keyboard UX
- For form and input screens, preserve keyboard dismissal behavior already standardized in shared templates/modifiers.
- Prefer existing input components and modifiers instead of creating alternate keyboard handling paths.
- For historical context and troubleshooting, use: [index.md](../../docs/keyboard/index.md)

## Localization-Aware UI

<rules>
- Do not introduce user-facing hardcoded strings inside views.
- Use `String(localized: "key.literal")` for static keys.
- `String(localized:)` expects `String.LocalizationValue`, **not** `LocalizedStringKey`. Passing `LocalizedStringKey(someVar)` into it is a type error.
- For dynamic keys (e.g. enum `rawValue`), use `NSLocalizedString(rawValue, comment: "")`.
- Keep both localization files in sync when adding or changing keys.
</rules>

## Feature Boundary Rules

<rules>
- Keep business logic in ViewModels and Services, not in SwiftUI View bodies.
- Keep Feature folder structure consistent: Screen, ViewModel, Constants.
</rules>

## Visual Quality Standards

Zodiak token conformance is the **floor**, not the ceiling. Every screen must reflect intentional visual choices. Full guidance and composable patterns: [zodiak-ds SKILL → Zodiak Aesthetic Intent](../../.github/skills/ios-zodiak-ds/SKILL.md) and [references/visual-quality.md](../../.github/skills/ios-zodiak-ds/references/visual-quality.md).

### Typography hierarchy (required)
- Every screen must use **at minimum 2 distinct `ZodiakTextStyle` values** — never only `.body()` throughout.
- The primary value or hero result must use `.headline` or `.title1` — not `.body()`.
- Metadata, units, and secondary labels must use `.caption()` — earns its smaller size.
- Contrast of 3× or more in point size between hero text and descriptor text creates clear hierarchy.

### Color anchor (required)
- Every screen must have **one dominant surface** (`background` or `surface`) and **at most one accent color** (`brand` or `actionPrimary`) used as a single visual anchor.
- `ZodiakColors.brand` is used for Capgemini identity — apply it to at most one element per screen; never as a repeating card fill.
- `surfacePositive` / `surfaceNegative` communicate state only — never repurpose them for decoration.

### Spacing variation (required)
- Do not use the same spacing value for every `VStack` on a screen.
- Hero/focused screens: `ZodiakSpacing.s40` (40pt) or `xl` (48pt) between input and result sections.
- Dense/list screens: `ZodiakSpacing.s8` (8pt) between rows; `ZodiakSpacing.s24` (24pt) between sections.

### Animated state transitions (strongly recommended)
- Wrap result values in `if let` with `.transition(.opacity.combined(with: .scale(...)))` and `.animation(.spring(...), value:)`.
- Animate error message appearances with `.transition(.opacity)` and `.animation(.easeInOut(duration: 0.22), value:)`.
- Reset/clear transitions should use shorter duration (≤ 0.20s) — things leave faster than they arrive.

### Anti-slop verification
Before marking any SwiftUI change complete, verify:
- [ ] ≥ 2 distinct typography styles on the screen
- [ ] 1 dominant surface + ≤ 1 accent color identifiable at a glance
- [ ] Spacing varies between sections (not uniform)
- [ ] At least 1 animated transition (result, error, or reset)
- [ ] No hardcoded colors, spacing, or radii — all Zodiak tokens
- [ ] Verified in both light and dark mode
- [ ] All user-facing strings localized

## Catalog Gallery Views
Applies to all files under `ZodiakiOS/App/Catalog/Components/` (Atoms, Molecules, Organisms, Compositions).

### Structure
Every gallery view **must** use `ZodiakGalleryShell` as the layout root and chain `.zodiakPage(title:)` for navigation/keyboard behavior:

```swift
struct MyComponentGalleryView: View {
    var body: some View {
        ZodiakGalleryShell {
            galleryHeader(title: "Nome do Componente", subtitle: "...", figmaRef: "...")
            gallerySectionCard(title: "Variantes") { ... }
            gallerySectionCard(title: "Especificações") {
                ZodiakInfoRow("Label", value: "valor", style: .spec())
            }
        }
        .zodiakPage(title: "Nome do Componente")
    }
}
```

`ZodiakGalleryShell` is a **pure layout** component (background + scroll + vertical rhythm).
`.zodiakPage(title:)` is a **ViewModifier** that applies navigation title, toolbar and keyboard dismiss.

Both are defined in:
- `ZodiakiOS/App/Catalog/ZodiakGalleryShell.swift`
- `ZodiakiOS/App/Catalog/CatalogGalleryHelpers.swift`
- `ZodiakiOS/Shared/DesignSystem/Utils/ZodiakViewModifiers.swift` (`.zodiakPage`)

### Rules

<never>
- **Never** use a raw `ScrollView + VStack + .background(ZodiakColors.background)` pattern — use `ZodiakGalleryShell` instead.
- **Never** use `VStack { ZodiakTitle2(...); content }.cardStyle()` for sections — use `gallerySectionCard(title:)` instead.
- **Never** define a file-level or struct-level `private func specRow` — use `ZodiakInfoRow("key", value: "value", style: .spec())` directly inside `gallerySectionCard`.
- **Never** use `.navigationTitle` or `.navigationBarTitleDisplayMode` directly in gallery views — `.zodiakPage(title:)` handles navigation configuration.
- **Never** use `.dismissKeyboardOnTap()` directly in gallery views — `.zodiakPage(title:)` applies it globally.
- **Never** pass `title:` to `ZodiakGalleryShell` — it is now a pure layout component with no title parameter.
- ViewModifiers that must overlay the entire screen (`.zodiakModal`, `.zodiakToast`, `.alert`, `.sheet`, `.background(ZodiakBottomSheet(...))`) must be chained **after** `.zodiakPage(title:)`, not inside `ZodiakGalleryShell`'s trailing closure.
</never>

### Dynamic titles
When a section title includes runtime data (e.g. counts), wrap with `LocalizedStringKey(...)` since the parameter expects `LocalizedStringKey`:
```swift
// Correto
gallerySectionCard(title: LocalizedStringKey(String(format: String(localized: "Items (%d)"), count))) { ... }
```

### Spec rows
Use `ZodiakInfoRow` with `.spec()` style inside `gallerySectionCard` — **never** a file-level `private func specRow`:
```swift
gallerySectionCard(title: "Especificações") {
    ZodiakInfoRow(String(localized: "catalog.spec.lbl.label"), value: String(localized: "catalog.spec.val.value"), style: .spec())
    Divider()
    ZodiakInfoRow(String(localized: "catalog.spec.lbl.outro"), value: "valor direto", style: .spec())
}
```

### Localization
All section titles passed to `gallerySectionCard` must be localized. Add new keys to both:
- `ZodiakiOS/en.lproj/Localizable.strings`
- `ZodiakiOS/pt-BR.lproj/Localizable.strings`

The localization convention is: key = pt-BR string, value = translated string.

### File placement
New gallery files go in the folder matching their Atomic Design layer:
- Atoms: `ZodiakiOS/App/Catalog/Components/Atoms/`
- Molecules: `ZodiakiOS/App/Catalog/Components/Molecules/`
- Organisms: `ZodiakiOS/App/Catalog/Components/Organisms/`
- Compositions (multi-organism sections): `ZodiakiOS/App/Catalog/Components/Compositions/`
- Token galleries (color, spacing, typography, accessibility, sizing, layout grid): `ZodiakiOS/App/Catalog/Tokens/`

## Implementation Checklist

<procedure>
- Reused existing Design System components where possible.
- No new hardcoded production colors introduced.
- Light and dark mode visual behavior considered.
- Localization pattern preserved for all user-facing strings.
- Keyboard/input behavior remains aligned with shared templates.
- Gallery views use `ZodiakGalleryShell` + `.zodiakPage(title:)` (no raw ScrollView/ZStack pattern).
- No file-level `specRow` defined (global one from CatalogGalleryHelpers used).
- Overlay modifiers (modal, toast, sheet) chained after `.zodiakPage(title:)`, not inside `ZodiakGalleryShell`.
</procedure>