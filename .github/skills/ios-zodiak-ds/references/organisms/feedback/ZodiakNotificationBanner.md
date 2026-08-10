> **Platform**: iOS

# ZodiakNotificationBanner — `Shared/DesignSystem/Organisms/Notification/ZodiakNotificationBanner.swift`

```swift
// ⚠️ Enum was renamed — see API Changes in SKILL.md
enum ZodiakNotificationVariant { case information, positive, warning }

ZodiakNotificationBanner(
    title: String,
    message: String? = nil,
    variant: ZodiakNotificationVariant = .information,
    actionLabel: String? = nil,
    action: (() -> Void)? = nil,
    isDismissible: Bool = true
)
```

## Variant — color tokens
```swift
.information → background (#eff0f4) + accent actionActive (#3573c0)
.positive    → surface (white) + accent actionActive (#3573c0)
.warning     → surfaceNegative (#fbf2f3) + accent textNegative (#9e0029)
```

## CTA variants
| Variant | When |
|---|---|
| No CTA | Purely informational, no action needed |
| Single CTA | Encourage interaction without overwhelming |
| Multiple CTAs | When additional details or actions are available |

---
