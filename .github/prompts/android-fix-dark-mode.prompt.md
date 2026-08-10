---
description: "Fix dark mode regressions caused by hardcoded colors in a Kotlin/Compose file. Use when a file has Color(0xFF...), Color.White, Color.Black, or any hardcoded color that breaks in dark mode."
argument-hint: "Leave empty to use the current editor file"
agent: "agent"
tools: [read, edit]
---

Audit and fix dark mode color regressions in the current file (or `$input` if provided).

## Step 1 — Read the file
Read the target `.kt` file and identify all hardcoded color usages:
- `Color(0xFF...)`
- `Color.White`, `Color.Black`, `Color.Gray`, `Color.Blue`, etc.
- `.background(Color(...))`
- `.color(Color(...))`
- `colorResource(...)` with a hardcoded color resource

Also read `design-system/src/main/kotlin/com/zodiak/android/design_system/theme/Color.kt` and `ZodiakTheme.kt` to understand available tokens.

## Step 2 — Map to MaterialTheme tokens
For each hardcoded color, find the closest semantic token from `MaterialTheme.colorScheme`:

| Intent | Token |
|---|---|
| Page background | `MaterialTheme.colorScheme.background` |
| Card / form surface | `MaterialTheme.colorScheme.surfaceVariant` |
| Standard card surface | `MaterialTheme.colorScheme.surface` |
| Primary text | `MaterialTheme.colorScheme.onBackground` / `onSurface` |
| Secondary / muted text | `MaterialTheme.colorScheme.onSurfaceVariant` |
| Inverse text (on dark bg) | `MaterialTheme.colorScheme.inverseOnSurface` |
| Primary CTA / button fill | `MaterialTheme.colorScheme.primary` |
| Text on primary fill | `MaterialTheme.colorScheme.onPrimary` |
| Borders | `MaterialTheme.colorScheme.outline` |
| Subtle borders | `MaterialTheme.colorScheme.outlineVariant` |
| Error text / icon | `MaterialTheme.colorScheme.error` |
| Error background | `MaterialTheme.colorScheme.errorContainer` |
| Success background | `MaterialTheme.colorScheme.tertiaryContainer` |

## Step 3 — Verify dark mode contrast
For every replaced color, verify the semantic combination is correct:
- **Light**: background `#F8F9FF`, surface `#F8F9FF`, surfaceVariant `#E1E2EC`
- **Dark**: background `#111318`, surface `#111318`, surfaceVariant `#44464F`

If no semantic token matches and the color:
- **Is always the same** in light and dark → keep as `Color(0xFF...)` literal but add a `// fixed color` comment
- **Is adaptive** (needs to change) → use the closest `colorScheme.*` token or note as a gap

## Step 4 — Apply fixes
Replace all identified hardcoded colors with their `MaterialTheme.colorScheme.*` equivalent.

Note: `MaterialTheme.colorScheme` is only accessible inside a `@Composable` context. If a hardcoded color is defined outside `@Composable` (e.g., in a utility function), move the color reference inside the Composable or pass it as a parameter.

## Step 5 — Output report
- N colors replaced → which token each mapped to
- N colors kept as-is → why (fixed brand color, no adaptive equivalent)
- Any gaps (colors that need a new token in `Color.kt`)
