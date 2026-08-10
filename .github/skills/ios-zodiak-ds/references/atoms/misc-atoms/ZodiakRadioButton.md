> **Platform**: iOS

# Radio Button — `Shared/DesignSystem/Atoms/RadioButton/ZodiakRadioButton.swift`

```swift
enum ZodiakRadioSize { case small /*18×18pt*/, large /*24×24pt*/ }

ZodiakRadioButton(
    label: String,
    isSelected: Bool,
    isDisabled: Bool = false,
    size: ZodiakRadioSize = .large,
    onTap: @escaping () -> Void
)

ZodiakRadioGroup<T: Hashable>(
    title: String? = nil,
    options: [(label: String, value: T)],
    selection: Binding<T?>,
    isDisabled: Bool = false,
    size: ZodiakRadioSize = .large
)
```

## When to use
- Single selection from a **short list (≤5 options)** where quick comparison matters.
- For longer lists → `ZodiakDropdown`. For multiple → `ZodiakCheckboxGroup`.
- `ZodiakRadioGroup` item spacing: `ZodiakSpacing.s16` (16pt) between items.

---
