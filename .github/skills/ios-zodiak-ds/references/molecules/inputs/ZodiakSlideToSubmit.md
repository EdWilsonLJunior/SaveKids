> **Platform**: iOS

# ZodiakSlideToSubmit — `Shared/DesignSystem/Molecules/SlideToSubmit/ZodiakSlideToSubmit.swift`

```swift
ZodiakSlideToSubmit(
    label: String,
    onSubmit: () -> Void,
    isEnabled: Bool = true
)

// Call .reset() on the instance to return to initial state after action completion
```

## When to use
- High-stakes single action where accidental taps are a concern (e.g., payment confirmation, irreversible send).

---
