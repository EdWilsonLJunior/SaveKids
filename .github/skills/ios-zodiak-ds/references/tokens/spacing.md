# Zodiak DS — Spacing (`ZodiakSpacing`)

> **Source**: `ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakSpacing.swift`
> Last synced: 2026-04-27

Base unit: **8pt**

---

## Scale

| Token | Value | Semantic alias | Use |
|---|---|---|---|
| `s4` | 4pt | `componentMin` | Badge/chip padding, tiny gaps |
| `s8` | 8pt | `componentPad` | Card internal padding, field padding |
| `s16` | 16pt | `screenPad`, `buttonGap` | Screen horizontal padding, gap between buttons |
| `s24` | 24pt | — | Section spacing |
| `s32` | 32pt | `screenPadLarge` | iPad/landscape screen padding |
| `s40` | 40pt | — | Large section gaps |
| `s48` | 48pt | — | Extra large gaps |
| `s56` | 56pt | — | |
| `s64` | 64pt | — | |
| `s72` | 72pt | — | |
| `s82` | 82pt | — | |
| `s96` | 96pt | — | |
| `s128` | 128pt | — | |
| `s176` | 176pt | — | |

---

## Sizing

| Token | Value | Use |
|---|---|---|
| `buttonHeightSmall` | 38pt | Small buttons |
| `buttonHeightMedium` | 48pt | Standard buttons |
| `buttonHeightLarge` | 56pt | Large buttons |
| `textFieldHeight` | 48pt | All text fields |

---

## Usage

```swift
.padding(ZodiakSpacing.s16)                    // screen padding
.padding(.horizontal, ZodiakSpacing.screenPad) // horizontal only
VStack(spacing: ZodiakSpacing.s8) { ... }
.frame(height: ZodiakSpacing.buttonHeightMedium)
```
