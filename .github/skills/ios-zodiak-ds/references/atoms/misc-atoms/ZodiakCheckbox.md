> **Platform**: iOS

# Checkbox — `Shared/DesignSystem/Atoms/Checkbox/ZodiakCheckbox.swift`

```swift
enum ZodiakCheckboxSize { case small /*18×18pt*/, large /*24×24pt*/ }

ZodiakCheckbox(
    label: String?,
    isChecked: Binding<Bool>,
    isIndeterminate: Bool = false,  // "select all" partial state
    size: ZodiakCheckboxSize = .large,
    isEnabled: Bool = true,
    isError: Bool = false
)

ZodiakCheckboxGroup(
    headline: String?,
    selections: Binding<Set<String>>,
    options: [String],
    size: ZodiakCheckboxSize = .large,
    isEnabled: Bool = true
)
```

## When to use
- Multiple selections where **all options must remain visible** simultaneously.
- For binary state with immediate effect → use `ZodiakSwitch`.
- For single selection from a short list → use `ZodiakRadioGroup`.
- Hidden-label checkboxes: only when context makes selection target obvious (e.g., row select in a table).

---
