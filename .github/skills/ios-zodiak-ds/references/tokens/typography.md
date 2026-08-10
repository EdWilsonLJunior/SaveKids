# Zodiak DS — Typography (`ZodiakTypography`)

> **Source**: `ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakTypography.swift`
> Last synced: 2026-04-27

Typeface: **Ubuntu** (Light 300 + Regular 400). Fallback to SF Pro if Ubuntu not installed.

---

## Scale

| Token | Size | Weight | Line Height | Use |
|---|---|---|---|---|
| `headline` | 32pt | Light | 40pt | Page title |
| `title1` | 24pt | Light | 32pt | Section title |
| `title2` | 18pt | Regular | 26pt | Card title, section header |
| `title3` | 16pt | Regular | 21pt | Subsection |
| `subtitleSmall` | 14pt | Regular | 18pt | Small subtitle |
| `bodyXL` | 24pt | Regular | 36pt | Large body |
| `bodyLarge` | 18pt | Regular | 30pt | Large body |
| `body` | 16pt | Regular | 26pt | Standard body |
| `bodySmall` | 14pt | Regular | 21pt | Secondary text |
| `caption` | 12pt | Regular | 18pt | Labels, specs, captions |
| `button` | 16pt | Regular | — | Button label (= `body`) |

---

## Letter Spacing

| Token | Value | Applied to |
|---|---|---|
| `trackingTitle1` | +0.3pt | `title1` |
| `trackingTitle2` | +0.2pt | `title2` |
| `trackingTitle3` | +0.3pt | `title3` |
| `trackingBody` | +0.24pt | `body` |
| `trackingBodySmall` | +0.31pt | `bodySmall` |
| `trackingCaption` | +0.3pt | `caption` |

---

## Usage

```swift
.font(ZodiakTypography.body)
.font(ZodiakTypography.caption)
Text("label").font(ZodiakTypography.title2).tracking(ZodiakTypography.trackingTitle2)
```
