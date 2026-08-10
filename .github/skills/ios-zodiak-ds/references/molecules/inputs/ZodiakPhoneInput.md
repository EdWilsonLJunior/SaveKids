> **Platform**: iOS

# ZodiakPhoneInput — `Shared/DesignSystem/Molecules/PhoneInput/ZodiakPhoneInput.swift`

```swift
struct ZodiakPhoneCountry: Identifiable, Hashable {
    let id: String       // ISO country code
    let flag: String     // emoji flag
    let name: String
    let dialCode: String
    static let all: [Self]  // 17 countries: BR, US, PT, FR, DE, ES, IT, GB, CA, AR, CL, MX, CO, JP, CN, IN, AU
}

ZodiakPhoneInput(
    label: String,
    phoneNumber: Binding<String>,
    selectedCountry: Binding<ZodiakPhoneCountry> = .constant(ZodiakPhoneCountry.all[0]),
    isRequired: Bool = false,
    helperText: String? = nil,
    helperType: ZodiakTextFieldHelperType = .informational,
    isDisabled: Bool = false
)
```

## Behavior
- Countries listed alphabetically. Max 5 visible before scroll.
- Selecting a country auto-populates the dial code; does not clear the entered number.
- Default country: first in `all` list (BR).

---
