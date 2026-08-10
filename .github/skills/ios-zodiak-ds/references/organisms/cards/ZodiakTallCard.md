> **Platform**: iOS

# ZodiakTallCard — `Shared/DesignSystem/Organisms/CardVariants/ZodiakTallCard.swift`

```swift
struct ZodiakTallCardItem: Identifiable {
    let id: UUID
    let eyebrow: String?
    let title: String
    let description: String?
    let imageSystemName: String
    var imageHeight: CGFloat
    var onTap: (() -> Void)?

    init(id: UUID = UUID(), eyebrow: String? = nil, title: String, description: String? = nil,
         imageSystemName: String = "photo", imageHeight: CGFloat = 260, onTap: (() -> Void)? = nil)
}

ZodiakTallCard(item: ZodiakTallCardItem)
```

## When to use
- Showcasing visually strong content where tall images matter.
- Best in groups of **exactly 3** in a horizontal row (Zodiak spec composition).

---
