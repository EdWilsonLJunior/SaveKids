# Zodiak DS — Radii (`ZodiakRadii`)

> **Source**: `ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakRadii.swift`
> Last synced: 2026-04-27

---

## Scale

| Token | Value | Use |
|---|---|---|
| `xs` | 4pt | Inputs, badges, chips, system buttons |
| `s` | 16pt | Cards, containers |
| `m` | 32pt | Modals, large panels |
| `l` | 999pt | Pill shape — **ALL** Zodiak buttons |

---

## Usage

```swift
.cornerRadius(ZodiakRadii.s)
.clipShape(RoundedRectangle(cornerRadius: ZodiakRadii.xs))
.clipShape(Circle())  // for circular icon buttons
```
