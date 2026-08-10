> **Platform**: iOS

# Icon Button — `Shared/DesignSystem/Atoms/Button/ZodiakIconButton.swift`

```swift
enum ZodiakIconButtonSize { case small /*38pt*/, medium /*48pt*/, large /*56pt*/ }
// ⚠️ NO .ghost — use .tertiary for subtle/tonal style
enum ZodiakIconButtonStyle { case primary /*filled*/, secondary /*outlined*/, tertiary /*subtle tonal fill*/ }

ZodiakIconButton(
    icon: String,                   // SF Symbol name
    action: () -> Void,
    size: ZodiakIconButtonSize = .medium,
    style: ZodiakIconButtonStyle = .primary,
    isEnabled: Bool = true,
    accessibilityLabel: String = "catalog.spec.label_action"
)

// Predefined close button (medium, ghost, xmark)
ZodiakCloseButton(action: () -> Void, accessibilityLabel: String = "shared.action.close")
```

## When to use
- Limited space or frequently performed actions where the icon is **universally recognizable**.
- ⚠️ Do NOT use for navigation to a page — use `ZodiakArrowButton` or text link instead.
- Icon must clearly convey the action without a label.

---
