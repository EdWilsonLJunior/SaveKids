> **Platform**: iOS

# ZodiakEmptyState — `Shared/DesignSystem/Organisms/EmptyState/ZodiakEmptyState.swift`

```swift
ZodiakEmptyState(
    icon: String = "tray",       // SF Symbol
    title: String,
    description: String? = nil,
    action: (label: String, handler: () -> Void)? = nil
)
```

## When to use
- Empty list, zero search results, or error state that prevents content from showing.
- Always provide a clear `title` explaining what's empty and optionally a recovery `action`.
- `ZodiakListTemplate` accepts `emptyStateIcon/Title/Subtitle` params and renders this automatically.

---
