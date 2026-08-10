> **Platform**: iOS

# Image Compositions — `Shared/DesignSystem/Organisms/ImageCompositions/`

```swift
struct ZodiakImageTile: Identifiable {
    let id = UUID(); let title: String; var subtitle: String?; var artworkSystemName: String
}

ZodiakImageBlock(title: String, summary: String? = nil, artworkSystemName: String = "photo")
ZodiakCarousel(items: [ZodiakImageTile])
ZodiakMasonryGrid(items: [ZodiakImageTile])

enum ZodiakImageTextBackground { case page, fog }
ZodiakImageTextSymmetrical(heading: String, bodyText: String,
                           artworkSystemName: String = "photo",
                           background: ZodiakImageTextBackground = .page)
```

---
