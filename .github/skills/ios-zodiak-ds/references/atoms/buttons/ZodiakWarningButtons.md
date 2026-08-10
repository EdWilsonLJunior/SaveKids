> **Platform**: iOS

# Warning Buttons — `Shared/DesignSystem/Atoms/Button/ZodiakWarningButtons.swift`

```swift
// Danger-variant of ZodiakSystemButton — for high-risk system actions
ZodiakSystemWarningButton(
    title: String,
    action: () -> Void,
    style: ZodiakSystemButtonStyle = .filled,
    isEnabled: Bool = true
)
```

## When to use

<rules>
- ⚠️ **ONLY for complex system UIs** — never for regular web/app pages.
- For standard destructive actions in feature screens → use `ZodiakDangerButton`.
- Warning icon is hardcoded — do NOT remove or change it.
- Always followed by user confirmation.
</rules>

---
