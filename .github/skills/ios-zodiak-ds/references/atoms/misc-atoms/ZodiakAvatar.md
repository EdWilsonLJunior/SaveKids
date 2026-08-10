> **Platform**: iOS

# Avatar — `Shared/DesignSystem/Atoms/Avatar/ZodiakAvatar.swift`

```swift
enum ZodiakAvatarSize { case xs, s, m, l, xl }
// Dimensions: s=48×48pt, m=64×64pt (other sizes proportional)

enum ZodiakAvatarStatus { case online, away, doNotDisturb, offline }
// Colors: online=statusOnline, away=statusAway, doNotDisturb=statusDoNotDisturb

ZodiakAvatar(
    initials: String? = nil,          // max 2 characters
    systemImage: String? = nil,       // SF Symbol fallback
    size: ZodiakAvatarSize = .m,
    status: ZodiakAvatarStatus? = nil,
    backgroundColor: Color? = nil     // initials only — see approved colors below
)

ZodiakAvatarGroup(
    items: [String],   // initials strings
    max: Int = 4,
    size: ZodiakAvatarSize = .s
)
```

## Initials background — only use these 3 colors
```swift
ZodiakColors.surfaceInk    // #121a38 — dark navy
ZodiakColors.surfaceMarine // #1c4076 — medium blue
ZodiakColors.surfaceAzur   // #0058ab — brand blue
// Initials foreground: always ZodiakColors.textAlwaysWhite (#ffffff)
```

## Variants (by use case)
| Variant | Init | When |
|---|---|---|
| Photographic | `systemImage:` | User has a profile photo |
| Initials | `initials:` | No photo — shows first+last initial |
| Brand | `systemImage: "building.2"` | Organization/group, not a person |

---
