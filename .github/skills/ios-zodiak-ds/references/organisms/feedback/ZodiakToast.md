> **Platform**: iOS

# ZodiakToast — `Shared/DesignSystem/Organisms/Toast/ZodiakToast.swift`

```swift
enum ZodiakToastVariant { case info, success, warning, error }

struct ZodiakToastConfig {
    let message: String
    let variant: ZodiakToastVariant
    let duration: TimeInterval
    let action: (label: String, handler: () -> Void)?

    init(message: String, variant: ZodiakToastVariant = .info,
         duration: TimeInterval = 3.0,
         action: (label: String, handler: () -> Void)? = nil)
}

// Applied as modifier on the screen root
extension View {
    func zodiakToast(_ toast: Binding<ZodiakToastConfig?>) -> some View
}
```

## Usage pattern
```swift
@State private var toast: ZodiakToastConfig?

var body: some View {
    ZodiakActivityTemplate(title: "...") { ... }
        .zodiakToast($toast)
}

// Trigger:
toast = ZodiakToastConfig(message: String(localized: "action.saved"), variant: .success)
```

## When to use
- Ephemeral, non-blocking feedback after an action (saved, copied, sent).
- Auto-dismisses after `duration` (default 3s).
- For persistent messages → `ZodiakBanner`. For blocking confirmation → `ZodiakModal`.
