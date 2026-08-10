---
description: "Use when creating or updating Compose screens, components, forms, layout, spacing, typography, colors, dark mode behavior, or localization-facing UI in ZodiakAndroid. Enforces Design System reuse and avoids hardcoded visual styles."
name: "Compose Design System Rules"
applyTo: "ZodiakAndroid/**/*.kt"
---

# Compose Design System Rules

## Primary Goal

<rules>
Keep UI changes consistent with the existing Atomic Design system and Material 3 theme.
</rules>

## Reuse Before Creating

<rules>
- Reuse existing components in `design-system/src/main/kotlin/com/zodiak/android/design_system/` before introducing new UI primitives
- Prefer composing Atoms, Molecules, and Organisms over custom ad-hoc Composables
- If a new reusable UI element is needed, place it in the correct DS layer, not inside a feature screen
</rules>

### Atomic Design Layers

| Layer | Package | Examples |
|---|---|---|
| Atoms | `design_system.atoms` | `ZodiakButton`, `ZodiakBadge`, `ZodiakTextField`, `ZodiakHeadline` |
| Molecules | `design_system.molecules` | `ZodiakInputField`, `ZodiakSwitch`, `ZodiakChipGroup`, `ZodiakAlert` |
| Organisms | `design_system.organisms` | `ZodiakFormContainer`, `ZodiakInfoRow`, `ZodiakEmptyState` |
| Theme | `design_system.theme` | `ZodiakTheme`, `ZodiakTypography`, `Color.kt`, `Shape.kt` |

## Component Discovery Catalog

Before writing any Compose code, scan this catalog to find the correct DS component. Full API in `.github/skills/android-zodiak-ds/references/`. Components marked ⏳ are not yet ported — use the M3 native equivalent as placeholder.

### Buttons ✅ Ported
| Component | When to use |
|---|---|
| `ZodiakButton` | Primary CTA — filled, 48dp. Max 1–2 per screen |
| `ZodiakOutlinedButton` | Secondary action — outlined, 48dp. Max ~4 per screen |
| `ZodiakTextButton` | Low-priority action — text only. No limit |
| `ZodiakTonalButton` | Mid-priority — tonal fill |
| `ZodiakDestructiveButton` | Destructive action (delete). Always follow with confirmation |

### Text & Labels ✅ Ported
| Component | When to use |
|---|---|
| `ZodiakHeadline` | Primary result / hero value / page title — `headlineSmall` (24sp) |
| `ZodiakTitle` | Section title — `titleMedium` (16sp) |
| `ZodiakBody` | Standard body text — `bodyMedium` (14sp) |
| `ZodiakLabel` | Field labels, metadata — `labelMedium` (12sp) |
| `ZodiakCaption` | Secondary captions, specs — `bodySmall` (12sp) |

### Badges & Status ✅ Ported
| Component | Variants | When to use |
|---|---|---|
| `ZodiakBadge` | `SUCCESS / WARNING / ERROR / INFO / NEUTRAL` | Semantic status pill — correct variant only, never hardcode color |

### Input & Forms ✅ Ported
| Component | When to use |
|---|---|
| `ZodiakInputField` | Standard labeled input with error state (preferred over raw `ZodiakTextField` in feature screens) |
| `ZodiakSwitch` | Binary toggle with label and immediate effect (no Save button needed) |
| `ZodiakTextField` | Primitive — use `ZodiakInputField` in feature screens |

### Filters ✅ Ported
| Component | When to use |
|---|---|
| `ZodiakChipGroup<T>` | Single-select filter strip — pass `items`, `selectedItem`, `onSelect`, `label` |

### Content & Layout ✅ Ported
| Component | When to use |
|---|---|
| `ZodiakFormContainer` | Groups form fields inside a card with a title (`surfaceVariant` background) |
| `ZodiakInfoRow` | Label + value display row (key/value pair, horizontally spaced) |
| `ZodiakEmptyState` | Empty list or error state with icon, title, optional action button |

### Dialogs ✅ Ported
| Component | Variants | When to use |
|---|---|---|
| `ZodiakAlert` | `ZodiakAlertType`: `INFO / SUCCESS / WARNING / ERROR` | Modal alert dialog — **not** inline. Show/hide via boolean `UiState` flag |

### ⏳ Not yet ported — use M3 native equivalent
| Component | M3 placeholder |
|---|---|
| ZodiakActivityTemplate | `Scaffold` + `LazyColumn` |
| ZodiakSearchField | `ZodiakTextField` with magnifying glass `trailingIcon` |
| ZodiakPasswordField | `ZodiakTextField(isPassword = true)` |
| ZodiakDropdown | `ExposedDropdownMenuBox` (M3) |
| ZodiakCheckbox | `Checkbox` (M3) |
| ZodiakRadioButton | `RadioButton` (M3) |
| ZodiakProgressBar | `LinearProgressIndicator` (M3) |
| ZodiakSpinner | `CircularProgressIndicator` (M3) |
| ZodiakBanner | `Snackbar` (M3) |
| ZodiakBottomSheet | `ModalBottomSheet` (M3) |
| ZodiakResultCard | `Card` + `ZodiakHeadline` |
| ZodiakStepIndicator | Custom `Row` with dot indicators |
| ZodiakTabs | `TabRow` (M3) |

---

## Color Rules

<rules>
Never hardcode colors. Use `MaterialTheme.colorScheme.*` exclusively:

| Intent | Token |
|---|---|
| Page background | `MaterialTheme.colorScheme.background` |
| Card / form surface | `MaterialTheme.colorScheme.surfaceVariant` |
| Primary text | `MaterialTheme.colorScheme.onBackground` / `onSurface` |
| Secondary / muted text | `MaterialTheme.colorScheme.onSurfaceVariant` |
| Text on filled button | `MaterialTheme.colorScheme.onPrimary` |
| Primary CTA / button fill | `MaterialTheme.colorScheme.primary` |
| Borders | `MaterialTheme.colorScheme.outline` |
| Subtle borders | `MaterialTheme.colorScheme.outlineVariant` |
| Error text / icon | `MaterialTheme.colorScheme.error` |
| Error container | `MaterialTheme.colorScheme.errorContainer` |
| Success container | `MaterialTheme.colorScheme.tertiaryContainer` |

</rules>

## Typography Rules

Use DS text Atoms. Do NOT pass raw font sizes in feature screens:

```kotlin
// ✅ DS Atoms
ZodiakHeadline(text = result)        // headlineSmall (24sp) — hero result
ZodiakTitle(text = sectionTitle)     // titleMedium (16sp) — section
ZodiakBody(text = description)       // bodyMedium (14sp) — body
ZodiakLabel(text = fieldLabel)       // labelMedium (12sp) — field label
ZodiakCaption(text = metadata)       // bodySmall (12sp) — metadata

// ❌ Never
Text(text = value, fontSize = 24.sp, fontWeight = FontWeight.Bold)
```

## Anti-Patterns

<never>

```kotlin
// ❌ Hardcoded color
Text(text = "...", color = Color(0xFF0058AB))
Box(modifier = Modifier.background(Color.White))
// ✅
Text(text = "...", color = MaterialTheme.colorScheme.primary)
Box(modifier = Modifier.background(MaterialTheme.colorScheme.surface))

// ❌ ZodiakAlert as inline status — it's a dialog in Android
if (error != null) ZodiakAlert(title = "Erro", message = error, onDismiss = {})
// ✅ Control via UiState boolean
if (uiState.showErrorDialog) {
    ZodiakAlert(title = "...", message = uiState.errorMessage, onDismiss = viewModel::dismissError)
}

// ❌ Raw Text with hardcoded style in a feature screen
Text(text = result, style = TextStyle(fontSize = 24.sp, fontWeight = FontWeight.Bold))
// ✅
ZodiakHeadline(text = result)

// ❌ Spacing not on 4dp grid
Column(verticalArrangement = Arrangement.spacedBy(13.dp))
// ✅
Column(verticalArrangement = Arrangement.spacedBy(16.dp))

// ❌ fillMaxWidth hardcoded inside an Atom
@Composable fun ZodiakBadge(...) { Badge(modifier = Modifier.fillMaxWidth()) }
// ✅ Pass through modifier parameter
@Composable fun ZodiakBadge(..., modifier: Modifier = Modifier) { Badge(modifier = modifier) }

// ❌ Resolving strings in ViewModel
_uiState.update { it.copy(errorText = "Campo obrigatório") }
// ✅ Expose typed error; resolve string in Composable
_uiState.update { it.copy(error = ValidationError.BlankField("name")) }
```

</never>
