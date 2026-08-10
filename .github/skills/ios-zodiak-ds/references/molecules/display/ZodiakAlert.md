> **Platform**: iOS

# ZodiakAlert — `Shared/DesignSystem/Molecules/Alert/ZodiakAlert.swift`

```swift
enum ZodiakAlertVariant { case info, success, warning, error }

ZodiakAlert(
    title: LocalizedStringKey,
    message: LocalizedStringKey? = nil,
    variant: ZodiakAlertVariant = .info,
    isDismissible: Bool = false,
    onDismiss: (() -> Void)? = nil
)

// Verbatim init for dynamic strings
ZodiakAlert(
    verbatim title: String,
    message: String? = nil,
    variant: ZodiakAlertVariant = .info,
    isDismissible: Bool = false,
    onDismiss: (() -> Void)? = nil
)
```

## ⚠️ API note — old signature removed
```swift
// ❌ Old (removed)
ZodiakAlert(message: error, severity: .error)

// ✅ Correct
ZodiakAlert(title: error, variant: .error)
```

## When to use
- Inline status messages **within a form or content section** (not floating, not full-screen).
- For floating ephemeral messages → `.zodiakToast()`.
- For full-width global messages → `ZodiakBanner`.

---
