> **Platform**: iOS

# Rating — `Shared/DesignSystem/Atoms/Rating/ZodiakRating.swift`

```swift
// Interactive star rating
ZodiakRating(
    rating: Binding<Int>,
    maxStars: Int = 5,
    size: CGFloat = 24,
    isReadOnly: Bool = false,
    showLabel: Bool = false
)

// Read-only fractional display (e.g., 4.3 stars)
ZodiakRatingDisplay(value: Double, maxStars: Int = 5, size: CGFloat = 14, showValue: Bool = true)
```

---
