# Zodiak DS — Colors (`MaterialTheme.colorScheme`)

> **Source**: `design-system/src/main/kotlin/com/zodiak/android/design_system/theme/`
> Last synced: 2026-05-13

Android uses a Material 3 color scheme. All tokens are **adaptive** (light/dark via `ZodiakTheme`).

---

## Brand / Primary

| Token | Light | Dark | Zodiak iOS mapping |
|---|---|---|---|
| `colorScheme.primary` | `#1A73E8` | `#A0C4FF` | `ZodiakColors.actionPrimary` |
| `colorScheme.onPrimary` | `#FFFFFF` | `#003062` | `ZodiakColors.textInverse` |
| `colorScheme.primaryContainer` | `#D2E4FF` | `#00458B` | Brand tint |
| `colorScheme.onPrimaryContainer` | `#001C3B` | `#D2E4FF` | |

---

## Surfaces

| Token | Light | Dark | Zodiak iOS mapping |
|---|---|---|---|
| `colorScheme.background` | `#F8F9FF` | `#111318` | `ZodiakColors.background` |
| `colorScheme.surface` | `#F8F9FF` | `#111318` | `ZodiakColors.surface` |
| `colorScheme.surfaceVariant` | `#E1E2EC` | `#44464F` | `ZodiakColors.surfaceSmoke` |
| `colorScheme.inverseSurface` | `#2E3038` | `#E2E2EA` | `ZodiakColors.surfaceInk` |

---

## Text / Content

| Token | Light | Dark | Zodiak iOS mapping |
|---|---|---|---|
| `colorScheme.onBackground` | `#191C20` | `#E2E2EA` | `ZodiakColors.textPrimary` |
| `colorScheme.onSurface` | `#191C20` | `#E2E2EA` | `ZodiakColors.textPrimary` |
| `colorScheme.onSurfaceVariant` | `#44464F` | `#C4C6D0` | `ZodiakColors.textSecondary` |
| `colorScheme.inverseOnSurface` | `#EFF0FA` | `#2E3038` | `ZodiakColors.textInverse` |

---

## Borders

| Token | Light | Dark | Zodiak iOS mapping |
|---|---|---|---|
| `colorScheme.outline` | `#74777F` | `#8E9099` | `ZodiakColors.borderPrimary` |
| `colorScheme.outlineVariant` | `#C4C6D0` | `#44464F` | `ZodiakColors.borderSecondary` |

---

## Status / Feedback

| Token | Light | Dark | Zodiak iOS mapping |
|---|---|---|---|
| `colorScheme.error` | `#BA1A1A` | `#FFB4AB` | `ZodiakColors.textNegative` |
| `colorScheme.errorContainer` | `#FFDAD6` | `#93000A` | `ZodiakColors.surfaceNegative` |
| `colorScheme.onErrorContainer` | `#410002` | `#FFDAD6` | |
| `colorScheme.tertiaryContainer` | `#FBD7FC` | `#59405B` | `ZodiakColors.surfacePositive` (approx) |
| `colorScheme.onTertiaryContainer` | `#29132D` | `#FBD7FC` | |

---

## Usage

```kotlin
// ✅ Always via colorScheme
.background(MaterialTheme.colorScheme.background)
Text(color = MaterialTheme.colorScheme.onSurfaceVariant)
Divider(color = MaterialTheme.colorScheme.outlineVariant)

// ❌ Never hardcoded
.background(Color(0xFFF8F9FF))
Text(color = Color.Gray)
```
