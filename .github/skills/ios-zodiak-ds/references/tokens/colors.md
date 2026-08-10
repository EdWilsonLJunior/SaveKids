# Zodiak DS — Colors (`ZodiakColors`)

> **Source**: `ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakColors.swift`
> Last synced: 2026-04-27

All colors are **adaptive** (light/dark via Asset Catalog) unless noted as fixed.

---

## Brand

| Token | Light | Dark | Use |
|---|---|---|---|
| `brand` | `#0058ab` | `#0058ab` | Capgemini Blue (fixed) |
| `brandOrange` | `#f9a464` | `#f9a464` | Brand Orange (fixed) |

---

## Surfaces

| Token | Light | Dark | Use |
|---|---|---|---|
| `background` | `#eff0f4` | `#21252d` | Page background |
| `surface` | `#ffffff` | `#12151d` | Cards, modals |
| `surfaceSmoke` | `#f8fafc` | `#272b33` | Alternate surface |
| `surfaceInk` | `#121a38` | `#121a38` | Dark hero surfaces (fixed) |
| `surfaceMarine` | `#1c4076` | `#1d365a` | Marine variant |
| `surfaceAzur` | `#0058ab` | `#1d365a` | Azur variant |
| `surfacePositive` | `#eff7f5` | `#0f2e22` | Success tint background |
| `surfaceNegative` | `#fbf2f3` | `#5d051a` | Error tint background |

---

## Text / Content

| Token | Light | Dark | Use |
|---|---|---|---|
| `textPrimary` | `#171a22` | `#f8fafc` | Main body text |
| `textSecondary` | `#595e6a` | `#f1f4f7` | Muted/secondary text |
| `textInverse` | `#ffffff` | `#171a22` | Text on filled buttons |
| `textDisabled` | `#a6acb5` | `#888f9a` | Disabled state |
| `textLink` | `#1d365a` | `#ffffff` | Link text |
| `textNegative` | `#9e0029` | `#ffa7a9` | Error text |
| `textPositive` | `#21B87D` | `#21B87D` | Success text (fixed) |

---

## Actions

| Token | Light | Dark | Use |
|---|---|---|---|
| `actionPrimary` | `#1d365a` | `#ffffff` | CTA default, button fill |
| `actionHover` | `#121a38` | `#c7ccd3` | Hover state |
| `actionPressed` | `#070a16` | `#e9edf3` | Pressed state |
| `actionDisabled` | `#a6acb5` | `#3c414a` | Disabled background |
| `actionDisabledContent` | `#d9dde3` | `#a6acb5` | Disabled content/icon |
| `actionActive` | `#3573c0` | `#3573c0` | Active/selected (fixed) |
| `actionWarning` | `#f64059` | `#ffffff` | Warning primary |
| `actionWarningSecondary` | `#9e0029` | `#ff848b` | Warning secondary |

---

## Borders

| Token | Light | Dark | Use |
|---|---|---|---|
| `borderPrimary` | `#c7ccd3` | `#3c414a` | Standard borders |
| `borderSecondary` | `#eff0f4` | `#2e323a` | Subtle borders |

---

## Status (presence indicators)

| Token | Value | Use |
|---|---|---|
| `statusOnline` | `#21B87D` | Online/success presence |
| `statusAway` | amber | Away/warning presence |
| `statusBusy` | red | Busy/error presence |

---

## Other

| Token | Use |
|---|---|
| `ratingActive` | Star/rating active fill (gold) |
| `actionWarningTint` | Amber icon/border for alerts |
| `surfaceWarningTint` | Light amber bg for inline alerts |
| `bannerSuccess` / `bannerWarning` / `bannerError` | Always-dark banner backgrounds |

---

## Usage

```swift
.foregroundColor(ZodiakColors.textPrimary)
.background(ZodiakColors.surface)
Color("zodiak-brand")               // direct asset reference (avoid — use ZodiakColors)
```
