> **Platform**: iOS

# ZodiakTextLink — `Shared/DesignSystem/Atoms/TextLink/ZodiakTextLink.swift`

```swift
ZodiakTextLink(
    label: String,
    action: @escaping () -> Void,
    showIcon: Bool = true,       // trailing arrow/external icon
    isExternal: Bool = false,    // shows external link icon
    font: Font = ZodiakTypography.body,
    isEnabled: Bool = true
)
```

## When to use
- Inline tappable link within body text or after a sentence.
- Use `isExternal: true` when linking outside the app.
- For navigation-as-primary-action → use `ZodiakArrowButton` or `ZodiakCircularArrowButton`.

---
