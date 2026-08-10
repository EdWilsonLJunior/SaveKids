> **Platform**: iOS

# ZodiakHorizontalCard — `Shared/DesignSystem/Organisms/CardVariants/ZodiakHorizontalCard.swift`

```swift
struct ZodiakHorizontalCardItem: Identifiable {
    let id: UUID
    let title: String
    let subtitle: String?
    let description: String?
    let tag: String?
    let imageSystemName: String
    var onTap: (() -> Void)?

    init(id: UUID = UUID(), title: String, subtitle: String? = nil, description: String? = nil,
         tag: String? = nil, imageSystemName: String = "photo", onTap: (() -> Void)? = nil)
}

ZodiakHorizontalCard(item: ZodiakHorizontalCardItem, imageWidth: CGFloat = 96)

// List variant — vertical stack of horizontal cards
ZodiakHorizontalCardList(items: [ZodiakHorizontalCardItem])
```

---
