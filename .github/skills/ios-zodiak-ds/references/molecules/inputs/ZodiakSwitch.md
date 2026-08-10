> **Platform**: iOS

# ZodiakSwitch — `Shared/DesignSystem/Molecules/Switch/ZodiakSwitch.swift`

```swift
enum ZodiakSwitchLabelPlacement { case leading, trailing, hidden }

ZodiakSwitch(
    label: String,
    isOn: Binding<Bool>,
    isEnabled: Bool = true,
    labelPlacement: ZodiakSwitchLabelPlacement = .leading
)
```

## When to use
- Binary choice (on/off) with **immediate effect** — no Save/Apply button needed.
- Setting persists until changed again.

## When NOT to use

<never>
- ❌ When the action requires **confirmation** → use `ZodiakDangerButton` + `ZodiakModal`.
- ❌ When the change has **destructive consequences** → warning button instead.
- ❌ When the state is temporary or part of a one-time action → use a button.
</never>

## Content rules

<rules>
- Label: **positive phrasing** — "Show settings", NOT "Don't show settings".
- Label indicates what happens **when switched on**, not the current state.
- Hidden label (`labelPlacement: .hidden`): only when context makes the control obvious.
- Sizes: small (40×32pt, compact/filter layouts) / large (56×32pt, preference panels).
</rules>

---
