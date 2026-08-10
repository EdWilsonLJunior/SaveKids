> **Platform**: iOS

# Progress Indicators — `Shared/DesignSystem/Atoms/ProgressIndicator/ZodiakProgressIndicator.swift`

```swift
// Linear progress bar (0.0–1.0)
ZodiakProgressBar(progress: Double, color: Color? = nil, showLabel: Bool = false)

// Circular ring with optional percentage label
ZodiakProgressRing(
    progress: Double,
    size: CGFloat = 56,
    lineWidth: CGFloat = 5,
    color: Color? = nil,
    showLabel: Bool = true
)

// Indeterminate spinner
ZodiakSpinner(size: CGFloat = 24, color: Color? = nil)
```

Use `ZodiakSpinner` for loading states. Use `ZodiakSkeletonLine/Rect/Circle` (in organisms/feedback.md) for content placeholder loading.

---
