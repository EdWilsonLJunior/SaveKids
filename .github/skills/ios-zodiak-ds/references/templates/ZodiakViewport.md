> **Platform**: iOS

# ZodiakViewport — `Shared/DesignSystem/Templates/ZodiakViewport.swift`

```swift
enum ZodiakViewport: String, CaseIterable, Sendable {
    case mobile          // 320–767pt  — 4 cols, 24pt margin, 16pt gutter
    case tablet          // 768–991pt  — 6 cols, 56pt margin, 24pt gutter
    case tabletLarge     // 992–1279pt — 6 cols, 82pt margin, 24pt gutter
    case desktopSmall    // 1280–1919pt — 12 cols, 82pt margin, 24pt gutter
    case desktopLarge    // 1920–2400pt — 12 cols, 312pt margin, 32pt gutter
}

// Usage: inject viewport into environment
ZodiakViewportReader { viewport in
    // viewport: ZodiakViewport — adapts content to current width
}

// Responsive grid using viewport
ZodiakResponsiveGrid<Content: View>(
    columns: Int? = nil,
    applyMargin: Bool = true,
    @ViewBuilder content: @escaping () -> Content
)
```

## Sizing tokens (layout widths)
```swift
ZodiakSizing.cardMaxWidth     // 480pt — single-column card cap
ZodiakSizing.contentMaxWidth  // 1024pt — centered content max (iPad)
```
