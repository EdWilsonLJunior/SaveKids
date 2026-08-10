> **Platform**: iOS

# Action Compositions — `Shared/DesignSystem/Organisms/ActionCompositions/ZodiakActionCompositions.swift`

```swift
struct ZodiakLinkRibbonItem: Identifiable {
    let id: UUID; let label: String; let icon: String?; var action: () -> Void
    init(id: UUID = UUID(), label: String, icon: String? = nil, action: @escaping () -> Void)
}
ZodiakLinkRibbon(title: String? = nil, links: [ZodiakLinkRibbonItem],
                 dividerStyle: ZodiakDividerStyle = .thin, background: Color = ZodiakColors.surface)

struct ZodiakContactItem {
    let name: String; let role: String?; let company: String?
    let email: String?; let phone: String?; let linkedIn: String?
    let avatarSystemImage: String
    init(name: String, role: String? = nil, company: String? = nil,
         email: String? = nil, phone: String? = nil, linkedIn: String? = nil,
         avatarSystemImage: String = "person.fill")
}
ZodiakProfessionalContact(contact: ZodiakContactItem, onEmailTap: (() -> Void)? = nil,
                          onPhoneTap: (() -> Void)? = nil, onLinkedInTap: (() -> Void)? = nil)

struct ZodiakShareStoryItem {
    let eyebrow: String?; let title: String; let summary: String?
    let artworkSystemName: String; let shareLabel: String
    var shareAction: () -> Void; var readMoreLabel: String?; var readMoreAction: (() -> Void)?
}
ZodiakShareStory(item: ZodiakShareStoryItem)
```

---
