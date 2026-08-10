> **Platform**: iOS

# ZodiakDropdown — `Shared/DesignSystem/Molecules/Dropdown/ZodiakDropdown.swift`

```swift
ZodiakDropdown<T: Hashable>(
    label: String,
    selection: Binding<T?>,
    options: [(value: T, label: String)],  // label is plain String, not LocalizedStringKey
    placeholder: String = "shared.action.select",
    errorMessage: String? = nil,
    isEnabled: Bool = true
)
// ⚠️ options label is String — use NSLocalizedString(rawValue, comment: "") for enum keys
```

## When to use
- Single selection from a **predefined, static list** of moderate length.
- Max 5 options visible before scroll.
- Options: **alphabetical order**, no decorative icons.

## When NOT to use

<never>
- ❌ Very long list that's hard to scan → `ZodiakCombobox`.
- ❌ Multiple selections required → `ZodiakMultiselect`.
- ❌ ≤5 items where comparison matters → `ZodiakRadioGroup`.
- ❌ User needs to see all options at once → checkboxes/radio.
</never>

## Content rules
- Label: always visible, short, 1 line. Never remove in favor of placeholder.
- Placeholder: optional, never contains important information (disappears on selection).
- Helper text: sentence-style capitalization, full sentences with punctuation, max 1 line.

---
