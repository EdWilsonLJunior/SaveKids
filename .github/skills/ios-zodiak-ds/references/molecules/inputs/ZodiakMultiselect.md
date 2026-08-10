> **Platform**: iOS

# ZodiakMultiselect — `Shared/DesignSystem/Molecules/Multiselect/ZodiakMultiselect.swift`

```swift
ZodiakMultiselect(
    label: String,
    options: [String],
    selections: Binding<Set<String>>,
    placeholder: String = "shared.placeholder.select_options",
    isEnabled: Bool = true,
    errorMessage: String? = nil
)
```

## When to use
- User needs to select **more than one** option from a known set.
- Max 5 options visible before scroll.

## When NOT to use
- ❌ Single selection → `ZodiakDropdown`.
- ❌ Very long list → consider `ZodiakCombobox`.
- ❌ All options must be visible → checkboxes.

## Behavior
- Menu stays open while selecting — closes on outside tap, Esc, or Tab.
- Selected count shown as badge.
- Options: alphabetical order.

---
