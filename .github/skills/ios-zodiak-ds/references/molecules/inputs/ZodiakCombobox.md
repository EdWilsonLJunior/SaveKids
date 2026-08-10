> **Platform**: iOS

# ZodiakCombobox — `Shared/DesignSystem/Molecules/Combobox/ZodiakCombobox.swift`

```swift
ZodiakCombobox<T: Hashable>(
    label: String,
    selection: Binding<T?>,
    options: [(value: T, label: String)],
    placeholder: String = "shared.placeholder.search_or_select",
    isEnabled: Bool = true,
    errorMessage: String? = nil
)
```

## When to use
- Single selection where the list is **large, dynamic, or not fully predefined**.
- User needs to type to filter/search through options.
- Has a built-in clear (×) button that appears while typing.

## When NOT to use
- ❌ Short static list → `ZodiakDropdown`.
- ❌ Multiple selections → `ZodiakMultiselect`.

## Content rules
- Options: **alphabetical order**, no decorative icons.
- Search placeholder: concise, e.g., "Search" — never critical information.
- Two variants: regular and country (with flags).

---
