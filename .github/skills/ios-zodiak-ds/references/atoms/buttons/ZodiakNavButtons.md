> **Platform**: iOS

# Circular Arrow Button — `Shared/DesignSystem/Atoms/Button/ZodiakNavButtons.swift`

```swift
enum ZodiakArrowButtonSize { case small /*36pt*/, medium /*48pt*/, large /*56pt*/ }
enum ZodiakArrowButtonDirection { case right, left, up, down }
enum ZodiakButtonVariant { case primary, secondary, ghost }

ZodiakCircularArrowButton(
    action: () -> Void,
    size: ZodiakArrowButtonSize = .medium,
    direction: ZodiakArrowButtonDirection = .right,
    style: ZodiakButtonVariant = .primary,
    isEnabled: Bool = true
)

ZodiakRoundCloseButton(
    action: () -> Void,
    size: ZodiakArrowButtonSize = .medium,
    style: ZodiakButtonVariant = .ghost,
    isEnabled: Bool = true
)

ZodiakHamburgerButton(action: () -> Void, isOpen: Bool = false, isEnabled: Bool = true)
```

## When to use `ZodiakCircularArrowButton` vs `ZodiakIconButton`
| Scenario | Use |
|---|---|
| Entire card is clickable, arrow aligns with card text | `ZodiakCircularArrowButton` — transparent container, aligns flush |
| Standalone action button with padding | `ZodiakIconButton` |

---
