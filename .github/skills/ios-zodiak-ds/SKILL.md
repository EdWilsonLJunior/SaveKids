---
name: zodiak-ds
description: "Zodiak Design System for ZodiakiOS. Use when creating or composing SwiftUI views, choosing components, applying tokens (colors, spacing, typography, radii, blur), building gallery views for App/Catalog/, creating new features, or reviewing/improving visual quality and aesthetic intent. Provides the complete API reference for all 110+ components in Shared/DesignSystem/ plus visual quality standards to ensure intentional hierarchy, depth, and motion — not just token conformance. Trigger phrases: which component, what token, how to compose, design system, zodiak, DS component, build gallery, create feature UI, visual quality, aesthetic, design review, typography, spacing, animation, depth."
argument-hint: "What are you building or improving? (e.g. 'card with rating and badge' or 'review typography hierarchy on TemperatureScreen')"
---

# Zodiak Design System — ZodiakiOS

## Source of Truth
**Only** `ZodiakiOS/Shared/DesignSystem/` is canonical.

| Path | Status |
|---|---|
| `Shared/DesignSystem/` | ✅ Canonical source — read this |
| `App/Catalog/` | ⚠️ Being refined — do NOT copy patterns from here |
| `Features/` | ❌ Usage examples only — never reference as DS pattern |

---

## Component Layers (Atomic Design)

Load the relevant reference file before generating code:

| Category | Reference file | Covers |
|---|---|---|
| Buttons | [atoms/buttons.md](./references/atoms/buttons.md) | 13 button variants, sizes, background rules |
| Text & Labels | [atoms/text-labels.md](./references/atoms/text-labels.md) | ZodiakText styles, Eyebrow, Badge, TextLink, Tooltip |
| Misc Atoms | [atoms/misc-atoms.md](./references/atoms/misc-atoms.md) | Avatar, Checkbox, Divider, Flag, Icon, List, Logo, Navigation, Progress, Radio, Rating, Tabs, TextField family |
| Input Molecules | [molecules/inputs.md](./references/molecules/inputs.md) | Dropdown, Combobox, Multiselect, LabelledField, PhoneInput, Switch, InputWizard, SlideToSubmit, CounterControl |
| Display Molecules | [molecules/display.md](./references/molecules/display.md) | Alert, Notice, Author, ChipGroup, Chip, ResultCard, StepIndicator |
| Cards | [organisms/cards.md](./references/organisms/cards.md) | CardGrid, HorizontalCard, TallCard, RevealCard, TypographicCard, AuthorCard, ShortFactsCard |
| Feedback | [organisms/feedback.md](./references/organisms/feedback.md) | Banner, Modal, Toast, EmptyState, FormInDrawer, NotificationBanner, Skeleton, Pin |
| Content | [organisms/content.md](./references/organisms/content.md) | Hero, Share, ShowMore, Listings, Typographic organisms, InfoRow, FormContainer, LoginForm |
| Templates | [templates.md](./references/templates.md) | ActivityTemplate, ListTemplate, InputOutputTemplate, AdaptiveTemplate, LayoutGrid, Viewport |

### Quick Map

| Layer | When to use |
|---|---|
| **Atom** | Smallest unit: button, text, icon, badge, divider |
| **Molecule** | Composed of atoms: input field, toggle, chip group, status chip |
| **Organism** | Section-level: card grid, modal, toast, banner, info row |
| **Template** | Full screen layout: wraps content with scroll + heading + background |

### Composition Rules

<rules>
1. Always start from the highest applicable layer (Template > Organism > Molecule > Atom)
2. Do NOT skip layers — no raw `Text` inside `Organism` when a `Molecule` exists
3. Do NOT create new primitives if a DS component covers the use case
4. Template is ALWAYS the screen root in `Features/` — never raw `ScrollView`
</rules>

---

## DS Consumption Rules — components before tokens

Always prefer the highest applicable DS component. Tokens are for layout gaps and genuinely custom surfaces — not for recreating what a component already provides.

**Hierarchy:**
```
DS Component → Token composition → hardcode (never)
```

### Anti-patterns (token-first mistakes)

```swift
// ❌ Recriar card com tokens brutos
RoundedRectangle(cornerRadius: ZodiakRadii.s)
    .fill(ZodiakColors.surface)
    .shadow(color: .black.opacity(0.03), radius: 35)
// ✅ Usar organismo DS adequado ao conteúdo
ZodiakHorizontalCard(item: item)
// ou ZodiakTallCard, ZodiakTypographicCard, etc.

// ❌ ZodiakTypography raw em vez de ZodiakText
Text(name)
    .font(ZodiakTypography.titleSmall)
    .foregroundStyle(ZodiakColors.textPrimary)
// ✅
ZodiakText(verbatim: name, style: .title2)

// ❌ Ícone montado manualmente
Image(systemName: "arrow.right")
    .font(.system(size: 16))
    .foregroundStyle(ZodiakColors.actionPrimary)
// ✅
ZodiakIcon(.arrowRight, size: .small)

// ❌ HStack colorido manual para status/feedback
HStack {
    Image(systemName: "info.circle").foregroundStyle(ZodiakColors.actionActive)
    Text(msg).foregroundStyle(ZodiakColors.textPrimary)
}.padding(ZodiakSpacing.s16).background(ZodiakColors.surface)
// ✅
ZodiakNotice(title: msg, category: .information)

// ❌ Divider manual
Rectangle().fill(ZodiakColors.borderPrimary).frame(height: 1)
// ✅
ZodiakDivider()
```

### Quando tokens SÃO o uso correto

- `ZodiakSpacing.*` para gaps de layout entre componentes (`VStack(spacing:)`, `.padding(...)`)
- `ZodiakColors.*` em containers de feature sem equivalente DS (backgrounds de seções únicas)
- `ZodiakRadii.*` em superfícies customizadas sem componente DS aplicável
- `ZodiakTypography.*` para texto fora de `ZodiakText` (ex: `.font()` em componentes SwiftUI nativos quando necessário)

> **Regra de ouro:** Se o visual que você está montando com tokens parece um componente DS, é porque É um componente DS. Leia a referência antes de compor.

---

## Tokens Quick Reference

Full values in [tokens.md](./references/tokens.md)

### Spacing (`ZodiakSpacing`)
```swift
s4   = 4    // badge/chip padding (3XS)
s8   = 8    // card internal padding (2XS)
s16  = 16   // standard screen padding, button gap (XS)
s24  = 24   // section spacing (S)
s32  = 32   // iPad padding (M)
s40  = 40   // large section gaps (L)
s48  = 48   // button height medium (XL)
s56  = 56   // 2XL
s64  = 64   // 3XL
s72  = 72   // 4XL
s82  = 82   // 5XL
s96  = 96   // 6XL
s128 = 128  // 7XL
s176 = 176  // 8XL
```

### Colors (`ZodiakColors`) — semantic, adaptive light/dark
```swift
// Text
.textPrimary       // main text
.textSecondary     // muted text
.textInverse       // ⚠️ ADAPTIVE — white in light, near-black in dark mode
                   //    Never use on fixed dark surfaces (blur, heavy backgrounds)
.textAlwaysWhite   // always white — use on blur, overlays, surfaceInk
.textAlwaysBlack   // always near-black (#171a22) regardless of theme
.textDisabled      // disabled state
.textLink / .textLinkInverse / .textLinkHover / .textLinkPressed
.textNegative      // error text
.textPositive      // success text (#21b87d)
.textNegativeOnHeavy  // error on dark surface

// Surfaces
.background        // page background
.surface           // card/modal fill
.surfaceSmoke      // alternate surface
.surfaceFog        // subtle alternate surface
.surfaceInk        // dark navy surface (fixed — does not change with theme)
.surfaceMarine     // deep blue surface (fixed)
.surfaceAzur       // teal surface (fixed)
.surfaceAlwaysWhite // always white
.surfaceAlwaysBlack // always black
.surfacePositive / .surfaceNegative  // success/error tints

// Actions
.actionPrimary     // CTA, button fill, links
.actionPrimaryOnHeavy  // CTA on dark/heavy surface
.actionPrimaryOnPhoto  // CTA on photographic background
.actionFocusOnHeavy   // focus ring on heavy surface
.actionActive      // interactive active state (#3573c0)

// Borders
.borderPrimary     // borders, dividers
.borderSecondary   // subtle borders

// Status
.statusOnline / .statusAway / .statusDoNotDisturb / .statusOffline

// Banners
.bannerSuccess / .bannerWarning / .bannerError

// Brand
.brand             // Capgemini blue
```
Never use `Color(red:)`, `Color(#hex)`, or system colors for production UI.

### Typography (`ZodiakTypography` — raw fonts)
```swift
// ZodiakTypography = raw Font values (used inside DS components internally)
// Large display scale (hero sections, KPI displays)
.displayLarge  // 128pt — max display
.displayMedium // 96pt  — large display
.displaySmall  // 72pt  — small display
.headlineLarge  // 56pt  — section hero
.headlineMedium // 48pt  — large heading
.headlineSmall  // 40pt  — medium heading
// Standard scale
.headline      // 32pt — page title
.title1        // 24pt — section title
.title2        // 18pt — card title  ⚠️ iOS 18pt ≠ React bodyL 20px (cross-platform gap)
.title3        // 16pt — subsection
.body          // 16pt — standard body
.bodySmall     // 14pt — secondary text  ← font only, NOT a ZodiakTextStyle case
.caption       // 12pt — labels, specs
.captionSmall  // 11pt — smallest — no React equivalent
.button        // 16pt — button label (same as body)
```

### ZodiakTextStyle (use with `ZodiakText`)
```swift
// ✅ Valid ZodiakTextStyle cases:
.headline
.title1 / .title2 / .title3
.body(bold: Bool = false, color: ZodiakTextColor = .primary)
.caption(bold: Bool = false, color: ZodiakTextColor = .secondary)

// For dynamic (non-localizable) data — use verbatim init:
ZodiakText(verbatim: someString, style: .caption())
ZodiakText(verbatim: someString, style: .body(color: .secondary))

// ❌ .bodySmall does NOT exist as ZodiakTextStyle — use .caption() instead
```

### Radii (`ZodiakRadii`)
```swift
.xs = 4     // inputs, badges, chips
.s  = 16    // cards, containers
.m  = 32    // modals, large panels
.l  = 999   // pill — ALL Zodiak buttons
```

### Blur (`ZodiakBlur`) — 1 blur oficial
```swift
// Fonte: Zodiak DS "Blurs" — uso exclusivo sobre fundos fotográficos
ZodiakBlur.radius       // CGFloat = 30pt
ZodiakBlur.pageOverlay  // rgba(23,26,34,0.40) — overlay na foto (passo 1)
ZodiakBlur.colorOverlay // rgba(255,255,255,0.05) — fill do container (passo 2)

// Padrão de uso:
Image("photo").overlay(ZodiakBlur.pageOverlay)  // passo 1
content.zodiakBlurBackground()                  // passo 2

// Regra: conteúdo sobre blur SEMPRE usa ZodiakColors.textAlwaysWhite
// (textInverse é ADAPTATIVO — fica escuro no dark mode → invisível sobre blur)
```

---

## Anti-Patterns (never do these)

<never>

```swift
// ❌ Raw scroll as screen root
ScrollView { VStack { ... } }

// ❌ Hardcoded color
.foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.5))
.background(Color.white)

// ❌ Hardcoded spacing
.padding(16)
.spacing(8)

// ❌ Manual spec row
private func specRow(_ label: String, _ value: String) -> some View { ... }

// ❌ Navigation title in gallery view
.navigationTitle("Component")
.navigationBarTitleDisplayMode(.inline)

// ❌ Copying from Features/ or App/Catalog/Components/
// (those are examples or being refined — not patterns)

// ❌ NavigationStack dentro de uma feature screen
// O host (NavigationSplitView / ExamplesListView) já fornece o stack pai.
// Attach .navigationDestination diretamente no ZodiakActivityTemplate.
NavigationStack { ZodiakActivityTemplate(...) { ... } }

// ❌ Ler horizontalSizeClass dentro de feature para calcular padding/maxWidth
// ZodiakActivityTemplate já cuida disso automaticamente.
@Environment(\.horizontalSizeClass) private var sizeClass
private var hPadding: CGFloat { sizeClass == .regular ? ZodiakSpacing.s32 : ZodiakSpacing.s16 }

// ❌ Padding negativo manual para componentes edge-to-edge (ex: ZodiakTabs)
// Use o slot edgeToEdgeContent: — o template cancela o padding internamente.
ZodiakTabs(...).padding(.horizontal, -templatePadding)

// ❌ Hardcoded cap+expand de largura para cards
.frame(maxWidth: 480).frame(maxWidth: .infinity)
// ✅ Use o modifier do DS:
.zodiakCardWidth()

// ❌ ZodiakTextStyle.bodySmall não existe — use .caption()
ZodiakText(name, style: .bodySmall(color: .secondary))
// ✅
ZodiakText(verbatim: name, style: .caption())

// ❌ ZodiakAlert API errada
ZodiakAlert(message: error, severity: .error)
// ✅
ZodiakAlert(title: error, variant: .error)

// ❌ String(localized:) não aceita LocalizedStringKey — gera erro de tipo
String(localized: LocalizedStringKey(someRawString))
// ✅ Use NSLocalizedString para chaves dinâmicas (rawValue de enum)
NSLocalizedString(someRawString, comment: "")

// ❌ Tokens de altura em ZodiakSpacing — não existem lá
ZodiakSpacing.buttonHeightLarge
ZodiakSpacing.textFieldHeight
// ✅ Estão em ZodiakSizing:
ZodiakSizing.buttonHeightLarge
ZodiakSizing.textFieldHeight

// ❌ Blur sem o padrão de 2 passos
.blur(radius: 30)                    // API não-Zodiak, ignora page overlay
Color.black.opacity(0.4).blur(...)   // cor errada, não usa ZodiakBlur
// ✅ Padrão correto:
image.overlay(ZodiakBlur.pageOverlay) // passo 1
content.zodiakBlurBackground()        // passo 2 (via ZodiakViewModifiers)

// ❌ Texto escuro (primary) sobre blur
ZodiakText("...", style: .body(color: .primary)).zodiakBlurBackground()

// ❌ Texto com .inverse sobre blur — ADAPTIVE: fica escuro no dark mode, invisível
ZodiakText("...", style: .body(color: .inverse)).zodiakBlurBackground()

// ✅ Sobre blur: sempre usar ZodiakColors.textAlwaysWhite
Text("...").font(ZodiakTypography.body).foregroundStyle(ZodiakColors.textAlwaysWhite)
    .zodiakBlurBackground()

// ❌ ZodiakCounterControl para controle de quantidade genérico (carrinho, parcelas, doses, etc.)
// "Tentativas" é hardcoded e não-localizável; .cardStyle() interno impede composição em rows
ZodiakCounterControl(value: $quantity, min: 0, max: 99)
// ✅ Compor manualmente com átomos DS até ZodiakCounterControl expor label: String? = nil
HStack {
    ZodiakIconButton(icon: "minus", action: decrement, size: .small, style: .tertiary,
                     accessibilityLabel: String(localized: "shared.action.decrease"))
    ZodiakText(verbatim: "\(quantity)", style: .title1)
        .contentTransition(.numericText())
        .animation(.spring(response: 0.3), value: quantity)
    ZodiakIconButton(icon: "plus", action: increment, size: .small, style: .tertiary,
                     accessibilityLabel: String(localized: "shared.action.increase"))
}

// ❌ ZodiakListingRow para items com ação trailing (add to cart, favoritar, selecionar)
// ZodiakListingRow tem chevron fixo — semanticamente indica navegação, não ação
ZodiakListingRow(item: listingItem) // chevron implica "ir para detalhe"
// ✅ Compor manualmente: ZodiakAvatar + ZodiakText + ZodiakIconButton em HStack
HStack(spacing: ZodiakSpacing.s8) {
    ZodiakAvatar(systemImage: icon, size: .m, backgroundColor: ZodiakColors.surfaceSmoke)
    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
        ZodiakText(verbatim: title, style: .title3)
        ZodiakText(verbatim: meta, style: .caption())
    }
    Spacer()
    ZodiakIconButton(icon: "plus", action: onAction, size: .small, style: .primary,
                     accessibilityLabel: String(localized: "..."))
}
.padding(ZodiakSpacing.s16)
.background(ZodiakColors.surface)
.cornerRadius(ZodiakRadii.s)
.hoverEffect(.lift) // iPad/trackpad affordance para cards clicáveis
```

</never>

---

## API Changes — Zodiak PDF Audit (May 2026)

Applied from 35 official Zodiak PDFs in `docs/zodiak-pdf/`. Sources of truth now in `docs/zodiak-pdf/`.

### ZodiakNotificationBanner — enum renamed (3 variants, not 4)
```swift
// ❌ Old (removed)
variant: .info     // → .information
variant: .success  // → .positive
variant: .error    // → .warning  (spec has no separate error category)

// ✅ Correct
variant: .information  // bg: background (#eff0f4), accent: actionActive (#3573c0)
variant: .positive     // bg: surface (white), accent: actionActive (#3573c0)
variant: .warning      // bg: surfaceNegative (#fbf2f3), accent: textNegative (#9e0029)
```

### ZodiakNotice — information colors fixed
```swift
// ❌ Wrong tokens (surfaceSmoke + actionPrimary)
// ✅ Correct: information category now uses background (#eff0f4) + actionActive (#3573c0)
ZodiakNotice(title: "...", category: .information)
```

### ZodiakAvatarStatus — renamed per spec
```swift
// ❌ Old
status: .busy  // removed

// ✅ Correct
status: .doNotDisturb  // color: statusDoNotDisturb (Red.shade500)
// ZodiakColors.statusBusy → ZodiakColors.statusDoNotDisturb
```

### ZodiakAvatar — initials colors fixed
```swift
// Default backgroundColor is now ZodiakColors.surfaceInk (#121a38)
// Initials/icon foreground is now ZodiakColors.textAlwaysWhite (#ffffff)
// Spec-approved backgrounds: .surfaceInk | .surfaceMarine | .surfaceAzur
ZodiakAvatar(initials: "MR", size: .l)  // dark bg + white text ✅
ZodiakAvatar(initials: "MR", size: .m, backgroundColor: ZodiakColors.surfaceMarine)
```

### ZodiakCheckbox — sizes and indeterminate
```swift
// Box sizes updated: small = 18×18px, large = 24×24px (per Zodiak spec)
// New isIndeterminate parameter:
ZodiakCheckbox(label: "Select all", isChecked: $all, isIndeterminate: someSelected)
// ZodiakCheckboxGroup spacing fixed: xs (16px) between items
```

### ZodiakTooltip — trigger changed
```swift
// ❌ Old: long press (0.3s) — not specified in Zodiak spec
// ✅ New: tap to toggle, auto-hide after 2.5s
// Max width: 230px (per spec)
// Placement: top/bottom (spec canonical), leading/trailing also available
view.zodiakTooltip("Help text", placement: .top)
```

### ZodiakChip — checkmark icon added
```swift
// ✅ Selected chips now show a leading checkmark icon (per spec)
ZodiakChip(verbatim: "Filter", isActive: true, onTap: { ... })
```

### ZodiakCombobox — clear button added
```swift
// ✅ Clear (x) button now appears when query is not empty (per spec)
// Replaces chevron while typing; clears query and selection
ZodiakCombobox(label: "Country", selection: $country, options: options)
```

### ZodiakModal — max width for tablet/desktop
```swift
// ✅ Card now constrainted to maxWidth: 480pt (per spec desktop = 480px)
// Mobile: uses full width naturally; iPad: capped at 480pt
```

---

## API Changes — Zodiak PDF Audit #2 (May 2026)

Applied from 20 official Zodiak PDFs (Dropdown, Multiselect, Switch, Radio, Text Input, Phone).

### ZodiakRadioButton — size parameter added
```swift
// Spec sizes: small = 18×18px, large = 24×24px (was fixed 20×20)
// New ZodiakRadioSize enum: .small | .large (default: .large)
ZodiakRadioButton(label: "Option", isSelected: true, size: .small, onTap: { })
ZodiakRadioGroup(title: "Group", options: options, selection: $sel, size: .small)
// ZodiakRadioGroup spacing fixed: s16 (16px) between items (was s4/4px per spec)
```

### ZodiakToggle — removed card wrapper, added isEnabled
```swift
// ❌ Old: had .cardStyle() wrapper built-in (not in Zodiak spec)
// ✅ New: plain HStack (label + toggle), label style .body() not bold
// New isEnabled parameter (default true)
ZodiakToggle(label: "Enable notifications", isOn: $isOn)
ZodiakToggle(label: "Feature flag", isOn: $isOn, isEnabled: false)
// NOTE: Callers wanting card appearance should use ZodiakFormWrapper themselves
```

### ZodiakDropdown — selected option highlight
```swift
// ✅ Selected option row now shows background: actionPrimary.opacity(0.08) + checkmark
// (per spec: "selected option changes color")
```

### ZodiakMultiselect — placeholder localized
```swift
// ❌ Old: hardcoded "Selecionar opções" (Portuguese)
// ✅ New: uses "shared.placeholder.select_options" (en: "Select options")
var placeholder: String = "shared.placeholder.select_options"
```

### ZodiakPhoneInput — label font token corrected
```swift
// ❌ Old: label used .bodySmall (inconsistent with Dropdown/Combobox/Multiselect)
// ✅ New: label uses .caption (matches all other input field labels)
```

### ZodiakTextFieldHelperType — success color token fixed
```swift
// ❌ Old: .success color was ZodiakColors.surfacePositive (background surface — wrong)
// ✅ New: .success color is ZodiakColors.textPositive (#21b87d — semantic text color)
```

---

## Gallery View Procedure

When creating a `*GalleryView.swift` in `App/Catalog/`:

<procedure>

1. Read the component's `.swift` file in `Shared/DesignSystem/` to confirm API
2. Use the template: [gallery-view.template.swift](./assets/gallery-view.template.swift)
3. Structure: `ZodiakGalleryShell` → `galleryHeader` → sections via `gallerySectionCard`
4. End with `.zodiakPage(title:)` modifier — NOT `.navigationTitle`
5. Components inside sections: from `Shared/DesignSystem/` only

</procedure>

## Feature Procedure

When creating a new feature in `Features/NN-Name/`:

<procedure>

1. Read `ZodiakActivityTemplate` to understand the screen wrapper API
2. Use the template: [feature.template.swift](./assets/feature.template.swift)
3. Structure: `ZodiakActivityTemplate` wraps all content
4. ViewModel: `final class + ObservableObject + @Published`
5. Constants: `enum` with `static let` only
6. UI components: from `Shared/DesignSystem/Atoms/` and `Molecules/`

</procedure>

---

## Catalog Scaffolding (not DS components)

These exist only for creating new gallery views — they are NOT design system components:

```swift
// Shell for catalog gallery views — App/Catalog/ZodiakGalleryShell.swift
ZodiakGalleryShell(spacing: CGFloat = ZodiakSpacing.s32) { content }

// Helpers — App/Catalog/CatalogGalleryHelpers.swift
galleryHeader(title: String, subtitle: String, figmaRef: String? = nil)
gallerySectionCard(title: LocalizedStringKey) { content }
```

> `ZodiakGalleryShell` and `gallerySectionCard` are **Catalog-only scaffolding**. They do NOT belong in `Features/` and are NOT part of the Zodiak DS API.

---

## Design Thinking (Before Coding)

Before writing any SwiftUI code, answer these five questions. This prevents "API-compliant but visually generic" output — the SwiftUI equivalent of "AI slop".

<principles>

1. **Purpose** — What problem does this screen solve? Who uses it? (e.g., "student enters temperature to convert" vs "admin reviews metric overview")
2. **Visual Tone** — Is this screen *dense/editorial* (lots of data, tight spacing) or *hero/focused* (one action, generous whitespace)?
3. **Dominant Element** — Which single element should command the eye? (a result value, a CTA button, a status badge?) Apply `.headline` or large `.title1` to it.
4. **Depth** — Is there an opportunity to layer surfaces? Could `ZodiakColors.surfaceSmoke` separate sections? Could `ZodiakBlur` add atmosphere to a header image?
5. **Motion** — Which state changes would benefit from animation? At minimum: result appearing, error clearing, reset completing.

</principles>

Only after answering these → select DS components and write code.

---

## Zodiak Aesthetic Intent

Zodiak conformance (correct API, correct tokens) is the **floor**, not the ceiling. Every screen should reflect intentional visual design choices. The following dimensions map Zodiak tokens to aesthetic outcomes — use them deliberately, not uniformly.

> See [references/visual-quality.md](./references/visual-quality.md) for isolated guidance per dimension and composable patterns.

### Typography — hierarchy through contrast

The goal is **visual rhythm**, not uniform styling. Use size and weight contrast of 3× or more between the most prominent and least prominent text on a screen.

```swift
// ✅ High contrast — result value commands attention
ZodiakText("42.5", style: .headline)              // 32pt — the result
ZodiakText("°C → °F", style: .title3)             // 16pt — context label
ZodiakText("Converted value", style: .caption())  // 12pt — descriptor

// ❌ Flat hierarchy — every element competes equally
ZodiakText("Input", style: .body())
ZodiakText("42.5", style: .body())
ZodiakText("Result", style: .body())
```

**Rules:**
- Use `.headline` or `.title1` for the primary value or hero moment on each screen — never bury it at `.body()`
- Use `.caption()` for metadata, specs, and secondary descriptors — it earns its small size
- Mix `bold: true` at `.body(bold: true)` for emphasis within a list without changing size
- Never use only `.body()` on an entire screen — minimum 2 distinct styles required

### Color — dominant tone + sharp accent

Commit to a single dominant surface color and one sharp accent. Avoid evenly distributing `brand`, `actionPrimary`, and `surfaceSmoke` across the same screen — they dilute each other.

```swift
// ✅ Intentional use — brand as accent on neutral surface
ZodiakColors.background     // dominant: page background
ZodiakColors.surface        // cards
ZodiakColors.surfaceSmoke   // subtle section separator or alternate card
ZodiakColors.brand          // accent: used ONCE as a visual anchor (e.g., a result badge or header strip)

// ❌ Color soup — every section in a different tint
.background(ZodiakColors.surfacePositive) // section 1
.background(ZodiakColors.surfaceSmoke)    // section 2
.background(ZodiakColors.surface)         // section 3
// → no dominant tone, no hierarchy
```

**Rules:**
- Every screen should have one clearly dominant surface + one accent color
- `ZodiakColors.brand` is the Capgemini blue — use it for a single high-value visual anchor per screen, not as a fill for every card
- `surfaceSmoke` separates content regions; `surfacePositive`/`surfaceNegative` communicate state — do not mix these roles

### Spatial Composition — intentional density

Spacing should reflect the screen's tone: hero screens need generous breathing room; data-dense screens earn tight rhythm.

```swift
// ✅ Hero/focused screen — generous spacing
ZodiakActivityTemplate(title: "Temperature") {
    VStack(spacing: ZodiakSpacing.s48) {       // 48pt — prominent spacing between input and result
        inputSection
        resultSection
    }
    .padding(.top, ZodiakSpacing.s40)           // 40pt — breathing room from header
}

// ✅ Dense/list screen — tight rhythm
VStack(spacing: ZodiakSpacing.s8) {   // 8pt — compact rows
    ForEach(items) { ZodiakInfoRow(...) }
}
```

**Rules:**
- Input + Result screens: use `ZodiakSpacing.s48` (48pt) or `s40` (40pt) between sections to make the result feel like a destination
- List/data screens: use `s8` (8pt) or `s16` (16pt) for tight rhythm
- Never use the same spacing value for every VStack on a screen — vary density to create visual hierarchy

### Motion — earned, not scattered

One well-orchestrated animation creates more delight than a dozen micro-interactions.

```swift
// ✅ Result appears with a spring — earned moment
@Published var result: Double?

// In view — result entrance
if let result {
    ResultView(value: result)
        .transition(.opacity.combined(with: .scale(scale: 0.92, anchor: .top)))
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: result)
}

// ✅ Error appears with a subtle shake (using offset + animation)
Text(errorMessage)
    .transition(.opacity)
    .animation(.easeInOut(duration: 0.2), value: errorMessage)

// ❌ Animation on everything — noise, no signal
.animation(.easeInOut, value: everyPublishedProperty)
```

**Rules:**
- Animate the result appearing and disappearing — it's the payoff moment of every feature screen
- Animate error state changes — they need attention without being jarring
- Reset/clear transitions should be faster (0.2s) than result appearances (0.4s)
- Use `.spring(response:dampingFraction:)` for result reveals; `.easeInOut` for error messages

### Depth — surfaces that breathe

Flat screens feel unfinished. Use `surfaceSmoke`, `ZodiakBlur`, and `ZodiakTheme` shadows to create foreground/background relationships.

```swift
// ✅ Section separation using surface layering
ZodiakGalleryShell {
    gallerySectionCard(title: "...") {    // surface card on background
        ZodiakInfoRow(...)                // content on surface
    }
    gallerySectionCard(title: "...") {   // surfaceSmoke for subtle alternation
        ...
    }
}

// ✅ Blur for photographic header (only valid pattern)
Image("header-photo")
    .overlay(ZodiakBlur.pageOverlay)      // step 1: darken photo
content
    .zodiakBlurBackground()              // step 2: frosted container

// ❌ Flat screen with no surface differentiation
ZodiakActivityTemplate {
    VStack {
        Text(...).background(Color.clear) // all elements on same plane
        Text(...).background(Color.clear)
    }
}
```

### Anti-Slop Checklist

<procedure>

Before submitting any SwiftUI implementation, verify:

- [ ] At least **2 distinct typography styles** in use (not just `.body()` everywhere)
- [ ] **1 dominant surface color** + at most 1 accent color identifiable at a glance
- [ ] **Spacing varies** between sections — hero gets more air, lists get rhythm
- [ ] **At least 1 animated state transition** — result, error, or reset
- [ ] **No hardcoded colors, spacing, or radii** — all from Zodiak tokens
- [ ] **Dark mode safe** — every surface/text combination verified for both themes
- [ ] **Localized** — no hardcoded user-facing strings

</procedure>

---

## Real Examples

Concrete features from `ZodiakiOS/Features/` that demonstrate correct DS application end-to-end. Use these as design + architecture references — not as code templates.

---

### Feature 19 — HangmanGame (`19-HangmanGame/`)

**User story**: Single-screen word-guessing game where the player selects letters A-Z to reveal a hidden word. Max 6 wrong attempts before game over.

#### Design Thinking answers

| Question | Answer |
|---|---|
| **Purpose** | Casual single-action game — one word, one session, clear win/lose outcome |
| **Visual tone** | Hero/focused — generous spacing, drawing commands the eye |
| **Dominant element** | `HangmanDrawingView` (Canvas) + word display in `.title1` — both earn their visual weight |
| **Depth** | `ZodiakColors.surfaceSmoke` for letter buttons (idle), `surfacePositive`/`surfaceNegative` as correct/wrong feedback |
| **Motion** | Letter reveal via `.contentTransition(.opacity)` + spring; drawing change via `.animation(.easeInOut)`; result card via `.opacity + .scale` spring |

#### Architecture

```
HangmanGameConstants  → maxAttempts, alphabet: [Character]
HangmanService        → randomWord() in Services.swift (stateless)
HangmanPhase          → .playing / .won / .lost (local to ViewModel, same pattern as QuizPhase)
HangmanGameViewModel  → @Published phase, currentWord, guessedLetters, wrongAttempts
                        computed: displayWord, remainingAttempts, isLetterUsed(_:), isLetterCorrect(_:)
HangmanGameScreen     → ZodiakActivityTemplate + @ViewBuilder split by phase
```

#### DS components used

| Component | Role |
|---|---|
| `ZodiakActivityTemplate` | Screen root — always |
| `ZodiakLayoutGrid(applyScreenPadding: false)` | Letter keyboard — adaptive columns, no double padding |
| `ZodiakResultCard` | Win/lose outcome card |
| `ZodiakButton` | Restart ("Play again") |
| `ZodiakText(.title1)` | Each revealed/hidden letter slot |
| `ZodiakText(.caption(color: .negative))` | Attempts remaining when ≤ 2 |

#### Key patterns to copy

```swift
// ZodiakLayoutGrid for the A–Z keyboard — adaptive, no manual LazyVGrid
ZodiakLayoutGrid(applyScreenPadding: false) {
    ForEach(HangmanGameConstants.alphabet, id: \.self) { letter in
        LetterButton(letter: letter, isUsed: ..., isCorrect: ...) { viewModel.guessLetter(letter) }
    }
}

// Letter reveal with spring + contentTransition
ZodiakText(verbatim: revealed ? String(char) : " ", style: .title1)
    .contentTransition(.opacity)
    .animation(.spring(response: 0.35, dampingFraction: 0.7), value: revealed)

// Result card entrance
ZodiakResultCard(title: ..., value: ..., subtitle: nil)
    .transition(.opacity.combined(with: .scale(scale: 0.94, anchor: .top)))
    .animation(.spring(response: 0.4, dampingFraction: 0.72), value: viewModel.phase)

// Attempts counter — color shifts to .negative when danger zone
ZodiakText(..., style: .caption(color: viewModel.remainingAttempts <= 2 ? .negative : .secondary))
    .animation(.easeInOut(duration: 0.2), value: viewModel.remainingAttempts)
```

---

## Foundation & Theme (internal infrastructure)

These files are internal DS infrastructure — use the public component API above, not these directly:

| File | Purpose |
|---|---|
| `Foundation/GlobalScrollInputConfigurator.swift` | UIScrollView keyboard handling (applied globally) |
| `Foundation/ZodiakPreview.swift` | Preview helpers for DS component previews |
| `Theme/ZodiakTheme.swift` | Shadow, elevation, and theme-level color overrides |
