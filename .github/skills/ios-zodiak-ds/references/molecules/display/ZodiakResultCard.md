> **Platform**: iOS

# ZodiakResultCard — `Shared/DesignSystem/Molecules/ResultCard/ZodiakResultCard.swift`

```swift
ZodiakResultCard(
    title: String,
    value: String,
    subtitle: String? = nil,
    valueColor: Color = ZodiakColors.actionPrimary
)

ZodiakResultCardWithBadge(
    title: String,
    value: String,
    badgeText: String,
    badgeColor: Color,
    subtitle: String? = nil,
    valueColor: Color = ZodiakColors.actionPrimary
)
```

## When to use
- Display a **computed result** prominently (score, temperature, price, discount).
- `ZodiakResultCardWithBadge` when a status badge accompanies the result value.
- For key metrics with icon → `ZodiakShortFactsCard` (organisms/cards.md).
- For editorial key figures → `ZodiakKeyFigures` (organisms/content.md).

---
