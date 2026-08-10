> **Platform**: iOS

# ZodiakAuthorCard — `Shared/DesignSystem/Organisms/CardVariants/ZodiakAuthorCard.swift`

```swift
struct ZodiakAuthorCardItem: Identifiable {
    let id: UUID
    let name: String
    let role: String?
    let date: String?
    let headline: String
    let articleImageName: String?
    let actionLabel: String?
    var onTap: (() -> Void)?

    init(id: UUID = UUID(), name: String, role: String? = nil, date: String? = nil,
         headline: String, articleImageName: String? = nil, actionLabel: String? = nil,
         onTap: (() -> Void)? = nil)
}

ZodiakAuthorCard(item: ZodiakAuthorCardItem)

// Grid variant
ZodiakAuthorCardGrid(items: [ZodiakAuthorCardItem], columns: Int = 2)
```

## When to use
- Content created by an expert where author attribution increases credibility.
- Author name and role **always present**.
- If no specific author → use `ZodiakTallCard` or `ZodiakTypographicCard`.

---
