> **Platform**: iOS

# Badge Family — `Shared/DesignSystem/Atoms/Badge/ZodiakBadge.swift`

```swift
// Semantic variants — prefer these over ZodiakBadge with manual colors
ZodiakSuccessBadge(text: LocalizedStringKey)
ZodiakErrorBadge(text: LocalizedStringKey)
ZodiakWarningBadge(text: LocalizedStringKey)

// Custom — only when no semantic variant applies
ZodiakBadge(
    text: LocalizedStringKey,
    backgroundColor: Color,
    foregroundColor: Color
)
```

## When to use
- Status pills on cards, rows, or headers to communicate state at a glance.
- Always use the semantic variant (`ZodiakSuccessBadge` etc.) over `ZodiakBadge` with hardcoded colors.
- Do NOT repurpose `surfacePositive`/`surfaceNegative` for decoration — they communicate state only.

---
