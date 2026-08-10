> **Platform**: iOS

# TextField Family — `Shared/DesignSystem/Atoms/TextField/`

```swift
enum ZodiakTextFieldHelperType { case informational, warning, error, success }

// General text input
ZodiakTextField(
    label: String,
    placeholder: String,
    text: Binding<String>,
    keyboardType: UIKeyboardType = .default,
    isRequired: Bool = false,
    helperText: LocalizedStringKey? = nil,
    helperType: ZodiakTextFieldHelperType = .informational,
    isDisabled: Bool = false,
    onSubmit: (() -> Void)? = nil
)

// Numeric input with min/max validation
ZodiakNumericField(
    label: String,
    placeholder: String,
    value: Binding<Double?>,
    minimum: Double = 0,
    maximum: Double? = nil,
    isRequired: Bool = false,
    helperText: LocalizedStringKey? = nil,
    helperType: ZodiakTextFieldHelperType = .informational,
    isDisabled: Bool = false,
    onSubmit: (() -> Void)? = nil
)

// Search-specific field
ZodiakSearchField(
    text: Binding<String>,
    placeholder: LocalizedStringKey = "shared.placeholder.search",
    onSubmit: (() -> Void)? = nil
)

// Secure text input
ZodiakPasswordField(
    label: String,
    placeholder: String,
    text: Binding<String>,
    isRequired: Bool = false,
    helperText: String? = nil,
    helperType: ZodiakTextFieldHelperType = .informational,
    isDisabled: Bool = false
)
```

## Helper text rules (from Zodiak spec)
| Type | Use for |
|---|---|
| `.informational` | Hint or formatting rule (e.g., "Use a work email") |
| `.warning` | Potential issue that may affect submission |
| `.error` | Invalid input — replaces helper text until fixed |
| `.success` | Confirmed valid input |

## Required field marking
- If **most fields are required**: mark only optional fields with "(optional)".
- If **most fields are optional**: mark required fields with `*` and add a note at top of form.

> For higher-level form molecules → prefer `ZodiakLabelledField` (molecules/inputs.md).
