> **Platform**: iOS

# ZodiakFormInDrawer — `Shared/DesignSystem/Organisms/FormInDrawer/ZodiakFormInDrawer.swift`

```swift
enum ZodiakFormDrawerState: Equatable {
    case idle, submitting, success, error(String)
}

ZodiakFormInDrawer<Content: View>(
    title: String,
    introText: String? = nil,
    imageSystemName: String? = nil,
    submitLabel: String,
    isPresented: Binding<Bool>,
    state: Binding<ZodiakFormDrawerState>,
    requiresCompliance: Bool = true,   // shows compliance checkbox
    onSubmit: () -> Void,
    @ViewBuilder content: () -> Content
)
```

## When to use
- Data collection too extensive for a modal but not worth a full page.
- The `state` binding drives submit/loading/success/error rendering automatically.

---
