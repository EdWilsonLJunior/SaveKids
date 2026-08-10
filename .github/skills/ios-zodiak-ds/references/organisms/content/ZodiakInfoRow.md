> **Platform**: iOS

# ZodiakInfoRow — `Shared/DesignSystem/Organisms/ZodiakInfoRow.swift`

```swift
enum ZodiakInfoRowStyle {
    case data                           // domain data display in feature screens
    case spec(labelWidth: CGFloat = 90) // spec table in catalog/documentation
}

ZodiakInfoRow(label: String, value: String, style: ZodiakInfoRowStyle = .data)
ZodiakInfoRow(_ label: LocalizedStringKey, value: LocalizedStringKey, style: ZodiakInfoRowStyle = .data)
```

## When to use
- Label + value pairs in feature screens (use `.data`).
- Specification tables in Catalog gallery views (use `.spec()`).
- For a compact stats grid → `ZodiakShortFactsCard`.

---
