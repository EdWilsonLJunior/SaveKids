> **Platform**: iOS

# Divider — `Shared/DesignSystem/Atoms/Divider/ZodiakDivider.swift`

```swift
enum ZodiakDividerHierarchy { case primary, secondary }
enum ZodiakDividerStyle { case thin /*1pt*/, thick /*2pt*/ }

ZodiakDivider(
    hierarchy: ZodiakDividerHierarchy = .primary,
    style: ZodiakDividerStyle = .thin
)
```

- Uses `ZodiakColors.borderPrimary` (primary) or `ZodiakColors.borderSecondary` (secondary).

<never>
- Never use SwiftUI `Divider()` in feature screens — it bypasses DS color tokens.
</never>

---
