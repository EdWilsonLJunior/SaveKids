> **Platform**: iOS

# ZodiakChip — `Shared/DesignSystem/Molecules/StatusChip/ZodiakChip.swift`

```swift
ZodiakChip(text: LocalizedStringKey, isActive: Bool, onTap: @escaping () -> Void = {})
ZodiakChip(verbatim: String, isActive: Bool, onTap: @escaping () -> Void = {})
```

- Selected chips show a **leading checkmark icon** (per spec).
- Two types per Zodiak spec:
  - **Selection chips**: toggle on/off (use `isActive` binding).
  - **Input chips**: represent user-provided input, have a "remove" icon.

## When to use
- Filter tags that the user can toggle on/off.
- For a group of chips → `ZodiakChipGroup`.

---
