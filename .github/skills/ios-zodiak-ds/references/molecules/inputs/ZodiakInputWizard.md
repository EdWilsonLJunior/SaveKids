> **Platform**: iOS

# ZodiakInputWizard — `Shared/DesignSystem/Molecules/InputWizard/ZodiakInputWizard.swift`

```swift
struct ZodiakWizardStep: Identifiable {
    let id: UUID
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey?
    let content: () -> AnyView

    init<Content: View>(
        id: UUID = UUID(),
        title: LocalizedStringKey,
        subtitle: LocalizedStringKey? = nil,
        @ViewBuilder content: @escaping () -> Content
    )
}

ZodiakInputWizard(
    title: LocalizedStringKey,
    steps: [ZodiakWizardStep],
    onComplete: (() -> Void)? = nil,
    onCancel: (() -> Void)? = nil,
    submitLabel: LocalizedStringKey = "shared.action.finish",
    nextLabel: LocalizedStringKey = "shared.action.next",
    backLabel: LocalizedStringKey = "shared.action.back"
)
```

## When to use
- Multi-step form flow where each step needs its own context and validation.
- For single-step forms → use `ZodiakFormWrapper` or `ZodiakActivityTemplate` with fields inline.
- ❌ Not for complex multi-step tasks with branching — use separate screens instead.

---
