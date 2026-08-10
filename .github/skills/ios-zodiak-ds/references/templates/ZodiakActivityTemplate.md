> **Platform**: iOS

# ZodiakInputOutputTemplate — `Shared/DesignSystem/Templates/ZodiakActivityTemplate.swift`

```swift
ZodiakInputOutputTemplate<Content: View>(
    title: String,
    eyebrow: String? = nil,
    intro: String? = nil,
    submitButtonTitle: String = "Enviar",
    onSubmit: @escaping () -> Void,
    @ViewBuilder inputContent: () -> Content
)
```

## When to use
- Feature screen with a **form + fixed submit button** pinned at the bottom of the scroll.
- Ideal for calculator, converter, and quiz-style screens.
- Submit button is always a `ZodiakButton` (primary) — no need to add it manually.

---
