---
name: zodiak-ds
description: "Zodiak Design System for ZodiakAndroid. Use when creating or composing Compose views, choosing components, applying tokens (colors, spacing, typography, shapes), building new features, or reviewing/improving visual quality and aesthetic intent. Provides the complete API reference for all ported components in design-system/ plus visual quality standards. Trigger phrases: which component, what token, how to compose, design system, zodiak, DS component, create feature UI, visual quality, aesthetic, design review, typography, spacing, animation, dark mode, color."
argument-hint: "What are you building or improving? (e.g. 'form with badge and switch' or 'review typography on GradesScreen')"
---

# Zodiak Design System — ZodiakAndroid

> This is the **same** Zodiak DS as ZodiakiOS. Component names, token names, and design intent are identical. What differs is the implementation language (Compose vs SwiftUI) and the set of components already ported to Android. Components marked ⏳ exist in the iOS DS but are not yet implemented in `design-system/`.

## Source of Truth
**Only** `design-system/src/main/kotlin/com/zodiak/android/design_system/` is canonical.

| Path | Status |
|---|---|
| `design-system/` | ✅ Canonical source — read this |
| `features/` | ❌ Usage examples only — never reference as DS pattern |

---

## Component Layers (Atomic Design)

Load the relevant reference file before generating code:

| Category | Reference file | Covers |
|---|---|---|
| Buttons | [atoms/buttons.md](./references/atoms/buttons.md) | 5 button variants + API |
| Text & Labels | [atoms/text-labels.md](./references/atoms/text-labels.md) | ZodiakHeadline/Title/Body/Label/Caption, ZodiakBadge |
| Misc Atoms | [atoms/misc-atoms.md](./references/atoms/misc-atoms.md) | ZodiakTextField + ⏳ not-yet-ported atoms |
| Input Molecules | [molecules/inputs.md](./references/molecules/inputs.md) | ZodiakInputField, ZodiakSwitch, ZodiakChipGroup + ⏳ |
| Display Molecules | [molecules/display.md](./references/molecules/display.md) | ZodiakAlert + ⏳ |
| Content Organisms | [organisms/content.md](./references/organisms/content.md) | ZodiakFormContainer, ZodiakInfoRow, ZodiakEmptyState |
| Feedback Organisms | [organisms/feedback.md](./references/organisms/feedback.md) | ⏳ ZodiakBanner, ZodiakModal, etc. — M3 alternatives |
| Card Organisms | [organisms/cards.md](./references/organisms/cards.md) | ⏳ All card organisms — M3 `Card` as placeholder |
| Templates | [templates.md](./references/templates.md) | ⏳ All templates — use Scaffold + LazyColumn manually |

### Quick Map

| Layer | When to use |
|---|---|
| **Atom** | Smallest unit: button, text, badge, text field |
| **Molecule** | Composed of atoms: input field, toggle, chip group, alert dialog |
| **Organism** | Section-level: form container, info row, empty state |
| **Template** | ⏳ Not yet ported — use `Scaffold` + `LazyColumn` manually |

### Composition Rules

<rules>
1. Always start from the highest applicable layer (Organism > Molecule > Atom)
2. Do NOT skip layers — no raw `Text` inside an Organism when a text Atom exists
3. Do NOT create new primitives if a DS component covers the use case
4. When a component is ⏳ not yet ported, use the M3 native equivalent and add a `// TODO: replace with ZodiakXxx when ported` comment
</rules>

---

## Tokens Quick Reference

Full values in [tokens.md](./references/tokens.md)

### Colors (`ZodiakTheme.colors.*`) — semantic, adaptive light/dark
```kotlin
.background           // page background
.surface              // card fill
.surfaceVariant       // alternate surface (ZodiakFormContainer uses this)
.onBackground         // main text on page background
.onSurface            // main text on card surface
.onSurfaceVariant     // muted/secondary text
.onPrimary            // text on primary-filled button
.primary              // CTA, button fill, links
.outline              // borders, dividers
.outlineVariant       // subtle borders
.error                // error text/icon
.errorContainer       // error surface/tint
.tertiaryContainer    // success surface/tint (closest to surfacePositive)
```
Never use `Color(0xFF...)`, `Color.White`, `Color.Black`, or any hardcoded color in production UI.

### Typography (`MaterialTheme.typography.*`)
```kotlin
.headlineSmall   // 24sp SemiBold — hero result, page title   → ZodiakHeadline
.titleLarge      // 22sp SemiBold — screen heading
.titleMedium     // 16sp Medium   — section title, card title  → ZodiakTitle
.titleSmall      // 14sp Medium   — subsection
.bodyLarge       // 16sp Normal   — standard body
.bodyMedium      // 14sp Normal   — secondary body             → ZodiakBody
.bodySmall       // 12sp Normal   — captions, specs            → ZodiakCaption
.labelLarge      // 14sp Medium   — button label
.labelMedium     // 12sp Medium   — field labels               → ZodiakLabel
.labelSmall      // 11sp Medium   — badge text
```

### Spacing — 4dp grid
```kotlin
// No ZodiakSpacing object yet — use dp literals on the 4dp grid
4.dp    // badge/chip padding, tiny gaps
8.dp    // card internal padding, field gap
16.dp   // standard screen padding, button gap
20.dp   // ZodiakFormContainer internal padding
24.dp   // section spacing
32.dp   // large section gap
48.dp   // button height, extra large gap
```

### Shapes (`MaterialTheme.shapes.*`)
```kotlin
.extraSmall   // 4dp   — inputs, badges, chips
.small        // 8dp   — small cards
.medium       // 12dp  — standard
.large        // 16dp  — ZodiakFormContainer, standard cards
.extraLarge   // 28dp  — large panels
```

---

## Design Thinking (run before writing any UI)

Before writing UI code, answer these questions:

<principles>

1. **Purpose** — What is the user trying to accomplish on this screen?
2. **Dominant element** — What is the ONE thing the user came to see? (result, status, list) → give it `ZodiakHeadline`
3. **Tone** — Neutral utility (most features) or celebratory (quiz result, score)?
4. **Depth** — Is there a natural input / result separation? → vary spacing between them
5. **Motion** — Does any value appear or disappear? → add `AnimatedVisibility` or `animateContentSize`

</principles>

---

## Anti-Patterns

<never>

```kotlin
// ❌ Hardcoded color
.background(Color(0xFFF8F9FF))
Text(text = "...", color = Color.White)
// ✅
.background(ZodiakTheme.colors.background)
Text(text = "...", color = ZodiakTheme.colors.textPrimary)

// ❌ Raw Text with hardcoded style in a feature screen
Text(text = result, fontSize = 24.sp, fontWeight = FontWeight.Bold)
// ✅
ZodiakHeadline(text = result)

// ❌ Spacing not on 4dp grid
Column(verticalArrangement = Arrangement.spacedBy(13.dp))
// ✅
Column(verticalArrangement = Arrangement.spacedBy(16.dp))

// ❌ ZodiakAlert as inline status — it's a dialog in Android
if (error != null) ZodiakAlert(title = "Erro", message = error, onDismiss = {})
// ✅ Show/hide via UiState boolean; dismiss clears the error
if (uiState.showErrorDialog) {
    ZodiakAlert(title = "...", message = uiState.errorMessage, onDismiss = viewModel::dismissError)
}

// ❌ Resolving strings in ViewModel
_uiState.update { it.copy(errorText = "Campo obrigatório") }
// ✅ Expose typed error; resolve string in Composable
_uiState.update { it.copy(error = ValidationError.BlankField("name")) }

// ❌ Hardcoding Modifier.fillMaxWidth() inside an Atom — blocks reuse
@Composable fun ZodiakBadge(...) { Badge(modifier = Modifier.fillMaxWidth()) }
// ✅
@Composable fun ZodiakBadge(..., modifier: Modifier = Modifier) { Badge(modifier = modifier) }

// ❌ Using ZodiakBadgeVariant.SUCCESS decoratively
ZodiakBadge("Novo!", variant = ZodiakBadgeVariant.SUCCESS)
// ✅ Only for semantic state feedback (result of an operation)
ZodiakBadge("Aprovado", variant = ZodiakBadgeVariant.SUCCESS)

// ❌ Forgetting to register new feature in ZodiakNavGraph
// After creating featureNameScreen(), always add it to ZodiakNavGraph.kt
```

</never>
