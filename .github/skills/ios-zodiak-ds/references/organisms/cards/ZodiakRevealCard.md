> **Platform**: iOS

# ZodiakRevealCard — `Shared/DesignSystem/Organisms/CardVariants/ZodiakRevealCard.swift`

```swift
enum ZodiakRevealCardBackground { case gradient, solid(Color) }

struct ZodiakRevealCardItem: Identifiable {
    let id: UUID
    let title: String
    let revealText: String           // text shown after reveal
    let imageSystemName: String
    let tag: String?
    let background: ZodiakRevealCardBackground
    let collapseIconName: String
    let revealedIconName: String
    let detailLines: [String]
    var onTap: (() -> Void)?

    init(id: UUID = UUID(), title: String, revealText: String,
         imageSystemName: String = "photo", tag: String? = nil,
         background: ZodiakRevealCardBackground = .gradient,
         collapseIconName: String = "plus.circle",
         revealedIconName: String = "minus.circle",
         detailLines: [String] = [], onTap: (() -> Void)? = nil)
}

ZodiakRevealCard(item: ZodiakRevealCardItem, height: CGFloat = 200)

// Grid variant
ZodiakRevealCardGrid(items: [ZodiakRevealCardItem], columns: Int? = nil, cardHeight: CGFloat = 200)
```

## When to use
- Card content is richer than what fits at first glance — rewards exploration.
- Hidden content revealed by tap (blur overlay pattern).

---
