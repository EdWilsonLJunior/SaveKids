> **Platform**: iOS

# Regular Buttons — `Shared/DesignSystem/Atoms/Button/ZodiakButton.swift`

```swift
// Primary — filled pill, 48pt, ZodiakColors.actionPrimary fill
ZodiakButton(
    title: LocalizedStringKey,
    action: () -> Void,
    isEnabled: Bool = true
)

// Secondary — outlined pill, transparent fill
ZodiakSecondaryButton(
    title: LocalizedStringKey,
    action: () -> Void,
    isEnabled: Bool = true
)

// Tertiary — underlined text only, no background
// ⚠️ Never on photo backgrounds
ZodiakTertiaryButton(
    title: LocalizedStringKey,
    action: () -> Void,
    isEnabled: Bool = true
)

// Danger — red fill, warning icon mandatory, requires confirmation
ZodiakDangerButton(
    title: LocalizedStringKey,
    action: () -> Void,
    isEnabled: Bool = true
)

// Small — primary style, 38pt height
ZodiakSmallButton(
    title: LocalizedStringKey,
    action: () -> Void,
    isEnabled: Bool = true
)

// Arrow inline — text label + directional arrow
enum ZodiakArrowDirection { case left, right }
ZodiakArrowButton(
    title: String,
    action: () -> Void,
    direction: ZodiakArrowDirection = .right,
    isEnabled: Bool = true
)
```

## When to use
- `ZodiakButton`: main CTA (submit, save, confirm). Max 1–2 per screen.
- `ZodiakSecondaryButton`: supporting action (cancel, back). Max ~4.
- `ZodiakTertiaryButton`: low-priority inline actions. No limit. NOT on photos.
- `ZodiakDangerButton`: irreversible/destructive actions ONLY. Always follow with `ZodiakModal` confirmation.
- `ZodiakArrowButton`: when a text label + directional arrow reads better than icon-only.

---
