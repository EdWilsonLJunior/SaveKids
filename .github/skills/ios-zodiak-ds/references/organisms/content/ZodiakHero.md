> **Platform**: iOS

# ZodiakHero — `Shared/DesignSystem/Organisms/Hero/ZodiakHero.swift`

```swift
enum ZodiakHeroStyle {
    case small, large, split, fullscreen
    case typographic(shape: ZodiakHeroTypographicShape = .v1)
}
enum ZodiakHeroTypographicShape: Int, CaseIterable { case v1, v2, v3, v4, v5 }

struct ZodiakHeroAction {
    let title: String
    let action: () -> Void
    var isSecondary: Bool = false
}

struct ZodiakHeroMetric: Identifiable {
    let id = UUID(); let value: String; let label: String
}

ZodiakHero(
    eyebrow: String? = nil,
    title: String,
    summary: String,
    style: ZodiakHeroStyle = .large,
    background: LinearGradient = ZodiakGradients.brand,
    mediaSystemImage: String? = nil,
    primaryAction: ZodiakHeroAction? = nil,
    secondaryAction: ZodiakHeroAction? = nil,
    metrics: [ZodiakHeroMetric] = []
)
```

## Style guide
| Style | When |
|---|---|
| `.large` | Default — large image, full-width, prominent CTA |
| `.small` | Compact header section |
| `.split` | Image left + text right (editorial) |
| `.fullscreen` | Immersive, full-bleed visual |
| `.typographic(shape:)` | Text-heavy, no photography — decorative shapes (v1–v5) |

---
