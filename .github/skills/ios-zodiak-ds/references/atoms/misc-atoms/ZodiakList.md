> **Platform**: iOS

# List — `Shared/DesignSystem/Atoms/List/ZodiakList.swift`

```swift
enum ZodiakListVariant { case unordered /*bullet •*/, ordered /*1. 2. 3.*/ }
enum ZodiakListAlignment { case leading, center }

ZodiakList(
    items: [String],
    headline: String? = nil,
    variant: ZodiakListVariant = .unordered,
    alignment: ZodiakListAlignment = .leading
)
```

## When to use
- `unordered`: items where order doesn't matter (feature lists, bullet points).
- `ordered`: sequences, steps, ranking, or priority.
- For structured/tabular data → use `ZodiakInfoRow` in a VStack instead.

---
