> **Platform**: iOS

# ZodiakShortFactsCard — `Shared/DesignSystem/Organisms/CardVariants/ZodiakShortFactsCard.swift`

```swift
struct ZodiakShortFactItem: Identifiable {
    let id: UUID
    let icon: String         // SF Symbol
    let value: String        // key metric value
    let label: String        // metric name
    let color: Color

    init(id: UUID = UUID(), icon: String, value: String, label: String,
         color: Color = ZodiakColors.actionPrimary)
}

ZodiakShortFactsCard(items: [ZodiakShortFactItem], columns: Int = 2)
```

## When to use
- Compact display of **key metrics or stats** — icon + value + label per item.
- Ideal for feature screens showcasing computed results or summaries.
- For editorial/larger key figures → `ZodiakKeyFigures` (organisms/content.md).
