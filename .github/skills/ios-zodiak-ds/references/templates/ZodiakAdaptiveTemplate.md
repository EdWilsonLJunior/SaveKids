> **Platform**: iOS

# ZodiakAdaptiveTemplate — `Shared/DesignSystem/Templates/ZodiakAdaptiveTemplate.swift`

```swift
ZodiakAdaptiveTemplate<Content: View>(
    title: String,
    eyebrow: String? = nil,
    intro: String? = nil,
    @ViewBuilder content: () -> Content
)
```

Convenience wrapper: equivalent to `ZodiakActivityTemplate(maxContentWidth: ZodiakSizing.contentMaxWidth)`.

## When to use
- Screens where centered content with max-width is always desired regardless of orientation.
- Catalog/gallery views, content-reading screens.

---
