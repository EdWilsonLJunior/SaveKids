> **Platform**: iOS

# ZodiakBanner — `Shared/DesignSystem/Organisms/Banner/ZodiakBanner.swift`

```swift
enum ZodiakBannerVariant { case brand, info, success, warning, error }

ZodiakBanner(
    message: String,
    variant: ZodiakBannerVariant = .brand,
    cta: (label: String, action: () -> Void)? = nil,
    isDismissible: Bool = false
)
```

## When to use
- **Full-width, top-of-screen** persistent messages (maintenance, announcements, global alerts).
- For inline section alerts → `ZodiakAlert`.
- For ephemeral floating messages → `.zodiakToast()`.

---
