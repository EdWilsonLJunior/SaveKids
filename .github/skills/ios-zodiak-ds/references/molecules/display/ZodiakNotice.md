> **Platform**: iOS

# ZodiakNotice — `Shared/DesignSystem/Molecules/Notice/ZodiakNotice.swift`

```swift
enum ZodiakNoticeCategory { case warning, success, information }
// Colors per category:
// .information → background (#eff0f4) + actionActive (#3573c0)
// .success     → surface (white) + actionActive (#3573c0)
// .warning     → surfaceNegative (#fbf2f3) + textNegative (#9e0029)

ZodiakNotice(
    title: String,
    message: String? = nil,
    category: ZodiakNoticeCategory = .information,
    isDismissible: Bool = false,
    action: (() -> Void)? = nil,
    actionLabel: String? = nil
)
```

## Content rules
- Use clear, understandable messages — no vague or technical terms.
- Use the predefined category colors — never override them.
- Optional elements: timestamp, subtitle, close icon.

---
