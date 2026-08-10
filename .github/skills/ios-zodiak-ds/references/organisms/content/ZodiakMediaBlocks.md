> **Platform**: iOS

# Media Blocks — `Shared/DesignSystem/Organisms/Media/ZodiakMediaBlocks.swift`

```swift
struct ZodiakMediaItem: Identifiable {
    let id = UUID()
    let eyebrow: String?; let title: String; let summary: String?
    let duration: String?; let artworkSystemName: String; var action: (() -> Void)?
}

ZodiakPodcastCard(item: ZodiakMediaItem)
ZodiakVideoBanner(item: ZodiakMediaItem)
```
