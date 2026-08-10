> **Platform**: iOS

# ZodiakDownloadButton — `Shared/DesignSystem/Organisms/DownloadButton/ZodiakDownloadButton.swift`

```swift
struct ZodiakDownloadOption: Identifiable {
    let id: UUID; let title: String; let subtitle: String?
    let icon: String; let url: URL?; var onTap: (() -> Void)?
    init(id: UUID = UUID(), title: String, subtitle: String? = nil,
         icon: String = "arrow.down.circle", url: URL? = nil, onTap: (() -> Void)? = nil)
}

ZodiakDownloadButton(options: [ZodiakDownloadOption], label: String = "Download", isEnabled: Bool = true)
```

---
