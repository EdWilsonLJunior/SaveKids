> **Platform**: iOS

# System Buttons — `Shared/DesignSystem/Atoms/Button/ZodiakSystemButtons.swift`

```swift
// Filter button with active count badge
ZodiakFilterButton(action: () -> Void, activeFilterCount: Int = 0, isEnabled: Bool = true)

// Menu button — opens SwiftUI Menu, groups related options
ZodiakMenuButton<MenuItems: View>(
    title: String,
    icon: String? = nil,
    isEnabled: Bool = true,
    menuItems: () -> MenuItems
)

// Compact rectangular button for complex system UIs
enum ZodiakSystemButtonStyle { case filled, outlined, ghost }
ZodiakSystemButton(
    title: String,
    action: () -> Void,
    icon: String? = nil,
    style: ZodiakSystemButtonStyle = .filled,
    isEnabled: Bool = true
)
```

## When to use
- `ZodiakFilterButton`: filter entry point with visual badge for active count.
- `ZodiakMenuButton`: compactly groups multiple related options — avoids showing several separate buttons.
- `ZodiakSystemButton`: ⚠️ **only for complex system/product UIs** — NOT for regular feature pages.

---
