> **Platform**: iOS

# ZodiakShare — `Shared/DesignSystem/Organisms/Share/ZodiakShare.swift`

```swift
struct ZodiakShareOption: Identifiable {
    let id: UUID; let title: String; let icon: ZodiakIcon; let action: () -> Void
    init(id: UUID = UUID(), title: String, icon: ZodiakIcon, action: @escaping () -> Void)
}

ZodiakShare(
    options: [ZodiakShareOption],
    label: String = "shared.action.share",
    isEnabled: Bool = true
)
```

## When to use
- Enable sharing a page or article through multiple channels (email, LinkedIn, copy link).
- Items: correct label + associated icon — defined per channel.
- Desktop: floating menu near button. Mobile: bottom drawer with `overlay-page-overlay`.

<never>
- ⚠️ Do NOT use multiple separate share buttons — always group in `ZodiakShare`.
</never>

---
