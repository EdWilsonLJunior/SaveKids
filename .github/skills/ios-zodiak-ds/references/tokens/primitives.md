# Zodiak DS — Primitives (`ZodiakPrimitives`)

> **Source**: `ZodiakiOS/Shared/DesignSystem/Tokens/ZodiakPrimitives.swift`
> Last synced: 2026-04-27

Raw color ramps for internal DS use. Prefer semantic `ZodiakColors.*` tokens.

---

## Ramps

Available ramps: `Blue`, `Neutral`, `Green`, `Red`, `Yellow`, `Orange`, `Teal`

Each ramp exposes: `shade25`, `shade50`, `shade100`, `shade200` … `shade800`, `shade900`

```swift
ZodiakPrimitives.Red.shade800   // used for bannerError
ZodiakPrimitives.Blue.shade500  // etc.
```
