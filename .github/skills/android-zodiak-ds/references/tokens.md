# Zodiak DS — Tokens (Android)

> **Source**: `design-system/src/main/kotlin/com/zodiak/android/design_system/theme/`
> Last synced: 2026-05-13

---

## Colors — `ZodiakTheme.colors.*` (ZodiakSemanticColors)

Android uses a Material 3 color scheme. All tokens are **adaptive** (light/dark via `ZodiakTheme`).

### Brand / Primary

| Token | Light | Dark | Zodiak iOS mapping |
|---|---|---|---|
| `colors.actionPrimary / brand` | `#1A73E8` | `#A0C4FF` | `ZodiakColors.actionPrimary` |
| `colorScheme.onPrimary` | `#FFFFFF` | `#003062` | `ZodiakColors.textInverse` |
| `colors.actionPrimary / brandContainer` | `#D2E4FF` | `#00458B` | Brand tint |
| `colorScheme.onPrimaryContainer` | `#001C3B` | `#D2E4FF` | |

### Surfaces

| Token | Light | Dark | Zodiak iOS mapping |
|---|---|---|---|
| `colors.background` | `#F8F9FF` | `#111318` | `ZodiakColors.background` |
| `colors.surface` | `#F8F9FF` | `#111318` | `ZodiakColors.surface` |
| `colors.surfaceVariant` | `#E1E2EC` | `#44464F` | `ZodiakColors.surfaceSmoke` |
| `colorScheme.inverseSurface` | `#2E3038` | `#E2E2EA` | `ZodiakColors.surfaceInk` |

### Text / Content

| Token | Light | Dark | Zodiak iOS mapping |
|---|---|---|---|
| `colorScheme.onBackground` | `#191C20` | `#E2E2EA` | `ZodiakColors.textPrimary` |
| `colorScheme.onSurface` | `#191C20` | `#E2E2EA` | `ZodiakColors.textPrimary` |
| `colorScheme.onSurfaceVariant` | `#44464F` | `#C4C6D0` | `ZodiakColors.textSecondary` |
| `colorScheme.inverseOnSurface` | `#EFF0FA` | `#2E3038` | `ZodiakColors.textInverse` |

### Borders

| Token | Light | Dark | Zodiak iOS mapping |
|---|---|---|---|
| `colorScheme.outline` | `#74777F` | `#8E9099` | `ZodiakColors.borderPrimary` |
| `colorScheme.outlineVariant` | `#C4C6D0` | `#44464F` | `ZodiakColors.borderSecondary` |

### Status / Feedback

| Token | Light | Dark | Zodiak iOS mapping |
|---|---|---|---|
| `colorScheme.error` | `#BA1A1A` | `#FFB4AB` | `ZodiakColors.textNegative` |
| `colorScheme.errorContainer` | `#FFDAD6` | `#93000A` | `ZodiakColors.surfaceNegative` |
| `colorScheme.onErrorContainer` | `#410002` | `#FFDAD6` | |
| `colorScheme.tertiaryContainer` | `#FBD7FC` | `#59405B` | `ZodiakColors.surfacePositive` (approx) |
| `colorScheme.onTertiaryContainer` | `#29132D` | `#FBD7FC` | |

### Usage
```kotlin
// ✅ Always via colorScheme
.background(MaterialTheme.colors.background)
Text(color = ZodiakTheme.colors.onSurfaceVariant)
Divider(color = ZodiakTheme.colors.outlineVariant)

// ❌ Never hardcoded
.background(Color(0xFFF8F9FF))
Text(color = Color.Gray)
```

---

## Typography — `MaterialTheme.typography.*` / `ZodiakTypography`

| Token | Size | Weight | Zodiak iOS mapping | DS Atom |
|---|---|---|---|---|
| `headlineLarge` | 32sp | SemiBold | `ZodiakTextStyle.headline` | — (rarely used) |
| `headlineMedium` | 28sp | SemiBold | — | — |
| `headlineSmall` | 24sp | SemiBold | `ZodiakTextStyle.headline` | `ZodiakHeadline` |
| `titleLarge` | 22sp | SemiBold | — | — |
| `titleMedium` | 16sp | Medium | `ZodiakTextStyle.title2` | `ZodiakTitle` |
| `titleSmall` | 14sp | Medium | `ZodiakTextStyle.title3` | `ZodiakTitle` |
| `bodyLarge` | 16sp | Normal | `ZodiakTextStyle.body()` | `ZodiakBody` |
| `bodyMedium` | 14sp | Normal | `ZodiakTextStyle.body()` | `ZodiakBody` |
| `bodySmall` | 12sp | Normal | `ZodiakTextStyle.caption()` | `ZodiakCaption` |
| `labelLarge` | 14sp | Medium | button label | `ZodiakLabel` |
| `labelMedium` | 12sp | Medium | — | `ZodiakLabel` |
| `labelSmall` | 11sp | Medium | — | (badge text, internal) |

### Usage — always via DS Atoms
```kotlin
ZodiakHeadline(text = result)           // headlineSmall — hero value
ZodiakTitle(text = sectionTitle)        // titleMedium — section header
ZodiakBody(text = description)          // bodyMedium — body text
ZodiakLabel(text = fieldLabel)          // labelMedium — field label
ZodiakCaption(text = metadata)          // bodySmall — metadata/spec
```

---

## Spacing — 4dp grid

No `ZodiakSpacing` object yet in Android. Use dp literals aligned to the 4dp grid:

| Value | iOS equivalent | Semantic use |
|---|---|---|
| `4.dp` | `ZodiakSpacing.threeXSmall` | Badge/chip padding, icon gap |
| `8.dp` | `ZodiakSpacing.twoXSmall` | Card internal padding, field gap |
| `16.dp` | `ZodiakSpacing.xs` | Standard screen padding, button gap |
| `20.dp` | — | ZodiakFormContainer internal padding |
| `24.dp` | `ZodiakSpacing.s` | Section spacing |
| `32.dp` | `ZodiakSpacing.m` | Large section gap |
| `48.dp` | `ZodiakSpacing.xl` | Button height, extra large gap |

---

## Shapes — `MaterialTheme.shapes.*`

| Token | Radius | iOS equivalent | Use |
|---|---|---|---|
| `extraSmall` | 4dp | `ZodiakRadii.xs` | Inputs, chips, badges |
| `small` | 8dp | — | Small cards |
| `medium` | 12dp | — | Standard |
| `large` | 16dp | `ZodiakRadii.s` | `ZodiakFormContainer`, cards |
| `extraLarge` | 28dp | ~`ZodiakRadii.m` | Large panels |
| `CircleShape` | 50% | `ZodiakRadii.l` (pill) | Floating action buttons |
