> **Platform**: iOS

# ZodiakLabelledField family — `Shared/DesignSystem/Molecules/InputField/ZodiakLabelledField.swift`

```swift
// Text field with label + error state (prefer over raw ZodiakTextField in forms)
ZodiakLabelledField(
    label: String,
    placeholder: String,
    text: Binding<String>,
    keyboardType: UIKeyboardType = .default,
    isRequired: Bool = false,
    errorMessage: LocalizedStringKey? = nil,
    onSubmit: (() -> Void)? = nil
)

// Numeric field with min/max validation
ZodiakLabelledNumericField(
    label: String,
    placeholder: String,
    value: Binding<Double?>,
    minimum: Double = 0,
    maximum: Double? = nil,
    isRequired: Bool = false,
    errorMessage: LocalizedStringKey? = nil,
    onSubmit: (() -> Void)? = nil
)

// Single checkbox with label
ZodiakLabelledCheckbox(label: String, isChecked: Binding<Bool>)
```

---
