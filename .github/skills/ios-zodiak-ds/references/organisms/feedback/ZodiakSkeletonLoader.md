> **Platform**: iOS

# Skeleton Loader — `Shared/DesignSystem/Organisms/SkeletonLoader/ZodiakSkeletonLoader.swift`

```swift
ZodiakSkeletonLine(width: CGFloat? = nil, height: CGFloat = 14)
ZodiakSkeletonCircle(diameter: CGFloat = 40)
ZodiakSkeletonRect(height: CGFloat = 120, cornerRadius: CGFloat = 8)
```

## When to use
- **Content placeholder** while data is loading — replace with real components once loaded.
- Compose multiple skeleton shapes to match the real layout.
- Pair with `.zodiakSkeleton(active:)` modifier on any view for shimmer animation.

```swift
// Modifier alternative
myView.zodiakSkeleton(active: isLoading)  // .redacted + shimmer
```

---
