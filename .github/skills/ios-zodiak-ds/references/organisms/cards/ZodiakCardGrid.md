> **Platform**: iOS

# ZodiakCardGrid — `Shared/DesignSystem/Organisms/CardGrid/ZodiakCardGrid.swift`

```swift
struct ZodiakCardItem: Identifiable {
    let id: UUID
    let title: String
    let subtitle: String?
    let description: String?
    let imageName: String?
    let tag: String?
    let actionLabel: String?
    var onTap: (() -> Void)?

    init(id: UUID = UUID(), title: String, subtitle: String? = nil, description: String? = nil,
         imageName: String? = nil, tag: String? = nil, actionLabel: String? = nil,
         onTap: (() -> Void)? = nil)
}

ZodiakCardGrid(
    items: [ZodiakCardItem],
    columns: Int = 2,
    initialCount: Int = 6   // items shown before ShowMore
)
```

---
