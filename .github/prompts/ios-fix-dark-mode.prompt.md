---
description: "Fix dark mode regressions caused by hardcoded colors in a Swift file. Use when a file has Color(red:), Color(hex:), or hardcoded foreground/background colors that break in dark mode."
argument-hint: "Leave empty to use the current editor file"
agent: "agent"
tools: [read, edit]
---

Audit and fix dark mode color regressions in the current file (or $input if provided).

## Step 1 — Read the file
Read the target Swift file and identify all hardcoded color usages:
- `Color(red:green:blue:alpha:)` or `Color(red:green:blue:)`
- `Color(hue:saturation:brightness:)`
- `.foregroundColor(Color(...))`
- `.background(Color(...))`
- `.tint(Color(...))`
- `UIColor(red:green:blue:alpha:)`
- Any hex color literals

Also read `ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakColors.swift` to see available semantic tokens.

## Step 2 — Map to Zodiak tokens
For each hardcoded color, find the closest semantic token from `ZodiakColors`:

| Intent | Use |
|--------|-----|
| Page background | `ZodiakColors.background` |
| Card / modal surface | `ZodiakColors.surface` |
| Subtle alternate surface | `ZodiakColors.surfaceSmoke` |
| Primary text | `ZodiakColors.textPrimary` |
| Secondary / muted text | `ZodiakColors.textSecondary` |
| Inverse text (on dark bg) | `ZodiakColors.textInverse` |
| Disabled text | `ZodiakColors.textDisabled` |
| Primary action / button fill | `ZodiakColors.actionPrimary` |
| Primary border | `ZodiakColors.borderPrimary` |
| Secondary border | `ZodiakColors.borderSecondary` |
| Capgemini brand blue | `ZodiakColors.brand` |
| Success surface | `ZodiakColors.surfacePositive` |
| Error surface | `ZodiakColors.surfaceNegative` |
| Error text | `ZodiakColors.textNegative` |

## Step 3 — Verify dark mode contrast
For every replaced color, verify the combination works in both:
- **Light**: background `#eff0f4`, surface `#ffffff`
- **Dark**: background `#21252d`, surface `#12151d`

If no semantic token matches and the color is:
- **always the same** in light and dark → keep as `Color(...)` literal but add a `// Reason: fixed color` comment
- **adaptive** (needs to change) → use the closest `ZodiakColors.*` token or note it as a gap in the audit

## Step 4 — Apply fixes
Replace all identified hardcoded colors with their Zodiak token equivalents.

## Step 5 — Check audit document
Read `docs/dark-mode-audit.md` and verify:
- If this file was listed as a pending issue, mark it as resolved
- If new tokens are used that aren't documented, note them

## Output
Report:
- N colors replaced → which token each mapped to
- N colors kept as-is → why (fixed color, no adaptive equivalent)
- Any pending gaps (colors that need a new token)
