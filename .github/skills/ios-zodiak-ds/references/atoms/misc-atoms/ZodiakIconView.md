> **Platform**: iOS

# Icon — `Shared/DesignSystem/Atoms/Icon/ZodiakIconView.swift`

```swift
enum ZodiakIconSize { case small /*16pt*/, medium /*24pt*/, large /*32pt*/, xLarge /*56pt*/ }

ZodiakIconView(_ icon: ZodiakIcon, size: ZodiakIconSize = .medium, color: Color = ZodiakColors.textPrimary)
```

`ZodiakIcon` is an enum with 200+ cases. Key categories: navigation arrows, media controls, social, file/data, UI actions, communication. Each case maps to `imageName: String` (asset) and provides `accessibilityLabel`.

---
