> **Platform**: iOS

# ZodiakTypographicCard — `Shared/DesignSystem/Organisms/CardVariants/ZodiakTypographicCard.swift`

```swift
enum ZodiakTypographicCardLeading { case icon(String), number(Int), none }
enum ZodiakTypographicCardSize { case small, medium }
enum ZodiakTypographicCardBackground { case page, azur }

struct ZodiakTypographicCardItem: Identifiable {
    let id: UUID
    let category: String?
    let title: String
    let body: String?
    let meta: String?
    let leading: ZodiakTypographicCardLeading
    let size: ZodiakTypographicCardSize
    let cardBackground: ZodiakTypographicCardBackground
    let actionLabel: String?
    var onTap: (() -> Void)?

    init(id: UUID = UUID(), category: String? = nil, title: String, body: String? = nil,
         meta: String? = nil, leading: ZodiakTypographicCardLeading = .none,
         size: ZodiakTypographicCardSize = .medium,
         cardBackground: ZodiakTypographicCardBackground = .page,
         actionLabel: String? = nil, onTap: (() -> Void)? = nil)
}

ZodiakTypographicCard(item: ZodiakTypographicCardItem)

// Grid variant
ZodiakTypographicCardGrid(items: [ZodiakTypographicCardItem], columns: Int = 2)
```

## When to use
- Short, focused information **without imagery**.
- `leading: .icon(name)`: icon from `ZodiakIcon` library that matches the purpose.
- `leading: .number(n)`: numbered list of steps or ranked items (0–9).
- Tertiary button is optional — when present, makes entire card tappable.

---
