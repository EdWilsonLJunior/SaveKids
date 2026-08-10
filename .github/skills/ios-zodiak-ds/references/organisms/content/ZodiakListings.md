> **Platform**: iOS

# Listings — `Shared/DesignSystem/Organisms/Listings/ZodiakListings.swift`

```swift
struct ZodiakListingItem: Identifiable {
    let id = UUID()
    let eyebrow: String?; let title: String; let summary: String?
    let meta: String?; var imageSystemName: String?; var action: (() -> Void)?
}

// Single row (chevron implies navigation to detail — use only for navigable items)
ZodiakListingRow(item: ZodiakListingItem)

// Group with Show More
ZodiakListingGroup(title: String? = nil, items: [ZodiakListingItem], initialCount: Int = 3)

// ⚠️ ZodiakListingRow has a fixed chevron — semantically implies "go to detail"
// For list items with a trailing action (add, favorite, select) → compose manually:
HStack(spacing: ZodiakSpacing.s8) {
    ZodiakAvatar(systemImage: icon, size: .m, backgroundColor: ZodiakColors.surfaceSmoke)
    VStack(alignment: .leading, spacing: ZodiakSpacing.s4) {
        ZodiakText(verbatim: title, style: .title3)
        ZodiakText(verbatim: meta, style: .caption())
    }
    Spacer()
    ZodiakIconButton(icon: "plus", action: onAction, size: .small, style: .primary,
                     accessibilityLabel: String(localized: "..."))
}
.padding(ZodiakSpacing.s16)
.background(ZodiakColors.surface)
.cornerRadius(ZodiakRadii.s)

// FAQ accordion list
struct ZodiakFAQItem: Identifiable {
    let id = UUID(); let question: String; let answer: String
}
ZodiakFAQList(title: String? = nil, items: [ZodiakFAQItem])

// Download items list
struct ZodiakDownloadItem: Identifiable {
    let id = UUID(); let title: String; let format: String; let size: String; let action: () -> Void
}
ZodiakDownloadList(title: String? = nil, items: [ZodiakDownloadItem])
```

---
