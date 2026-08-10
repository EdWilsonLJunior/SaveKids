> **Platform**: iOS

# ZodiakShowMore — `Shared/DesignSystem/Organisms/ShowMore/ZodiakShowMore.swift`

```swift
enum ZodiakShowMoreBgVariant { case onLite, onHeavy, onPhoto }
enum ZodiakShowMoreHierarchy { case secondary, tertiary }

ZodiakShowMore<Item: Identifiable, Row: View>(
    items: [Item],
    initialCount: Int = 3,
    showLabel: LocalizedStringKey = "shared.action.show_more",
    hideLabel: LocalizedStringKey = "shared.action.show_less",
    bgVariant: ZodiakShowMoreBgVariant = .onLite,
    hierarchy: ZodiakShowMoreHierarchy = .tertiary,
    @ViewBuilder row: (Item) -> Row
)

typealias ZodiakShowMoreList = ZodiakShowMore
```

## When to use
- Prevent overwhelming the user with too much content at once.
- Reveal content in consistent logical batches (e.g., 6 cards at a time).

<never>
- ⚠️ `.onPhoto` variant: only `.secondary` available — `.tertiary` not allowed (accessibility).
</never>

## Content rules

<rules>
- `showLabel`: be specific — "Show 6 more articles", not just "Show more".
- Ensure initial content provides enough value on its own.
- If using instead of pagination: implement unique URLs/query params for SEO.
</rules>

---
