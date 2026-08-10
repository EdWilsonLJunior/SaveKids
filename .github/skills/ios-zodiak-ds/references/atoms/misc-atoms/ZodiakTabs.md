> **Platform**: iOS

# Tabs — `Shared/DesignSystem/Atoms/Tabs/ZodiakTabs.swift`

```swift
enum ZodiakTabSize { case small /*38pt*/, medium /*48pt*/ }

// Tabs without managed content (external selectedIndex drives content)
ZodiakTabs(
    tabs: [String],
    selectedIndex: Binding<Int>,
    size: ZodiakTabSize = .small,
    disabledIndices: Set<Int> = []
)

// Tabs with content slot (preferred for ZodiakActivityTemplate edgeToEdgeContent)
ZodiakTabContainer<Content: View>(
    tabs: [String],
    selectedIndex: Binding<Int>,
    size: ZodiakTabSize = .small,
    disabledIndices: Set<Int> = [],
    @ViewBuilder content: @escaping (Int) -> Content
)
```

## When to use
- 2–7 **mutually exclusive, related** content sections within the same view.

<never>
- ❌ Never nest tabs inside tabs.
- ❌ Never use for unrelated sections or page-level navigation.
</never>

- When used in `ZodiakActivityTemplate`, place in `edgeToEdgeContent:` slot — the template removes horizontal padding automatically.

---
