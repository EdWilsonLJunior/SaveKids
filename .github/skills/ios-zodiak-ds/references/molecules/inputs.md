# Zodiak DS — Input Molecules API Reference

> Sources: `Shared/DesignSystem/Molecules/` · `docs/zodiak-pdf/Overview - Dropdown/Combobox/Multiselect/Phone/Switch.md` · `docs/zodiak-pdf/Guidelines - Dropdown/Combobox/Multiselect/Switch/Text input.md` · `docs/zodiak-pdf/Specs - Dropdown/Combobox/Switch.md`

---

## Selection Component Decision Tree

<decision>

```
1 option, list ≤20 items, static  →  ZodiakDropdown
1 option, list long or dynamic    →  ZodiakCombobox  (has built-in search)
Multiple options                  →  ZodiakMultiselect
1 option, ≤5 items, quick compare →  ZodiakRadioGroup  (atoms/misc-atoms.md)
Multiple, all options visible     →  ZodiakCheckboxGroup  (atoms/misc-atoms.md)
Binary, immediate effect          →  ZodiakSwitch  (no Save needed)
Binary, needs confirmation        →  ZodiakDangerButton + ZodiakModal
```

</decision>

---


---

## Components

| Component | File |
|---|---|
| `ZodiakDropdown` | [inputs/ZodiakDropdown.md](inputs/ZodiakDropdown.md) |
| `ZodiakCombobox` | [inputs/ZodiakCombobox.md](inputs/ZodiakCombobox.md) |
| `ZodiakMultiselect` | [inputs/ZodiakMultiselect.md](inputs/ZodiakMultiselect.md) |
| `ZodiakLabelledField` | [inputs/ZodiakLabelledField.md](inputs/ZodiakLabelledField.md) |
| `ZodiakPhoneInput` | [inputs/ZodiakPhoneInput.md](inputs/ZodiakPhoneInput.md) |
| `ZodiakSwitch` | [inputs/ZodiakSwitch.md](inputs/ZodiakSwitch.md) |
| `ZodiakInputWizard` | [inputs/ZodiakInputWizard.md](inputs/ZodiakInputWizard.md) |
| `ZodiakSlideToSubmit` | [inputs/ZodiakSlideToSubmit.md](inputs/ZodiakSlideToSubmit.md) |
| `ZodiakCounterControl` | [inputs/ZodiakCounterControl.md](inputs/ZodiakCounterControl.md) |

