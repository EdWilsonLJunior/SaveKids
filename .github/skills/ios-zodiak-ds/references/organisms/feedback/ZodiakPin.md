> **Platform**: iOS

# ZodiakPin — `Shared/DesignSystem/Organisms/Pin/ZodiakPin.swift`

```swift
enum ZodiakPinStyle { case primary, secondary, danger, success }
enum ZodiakPinSize { case small, medium, large }

ZodiakPin(
    label: String? = nil,
    icon: String? = nil,
    style: ZodiakPinStyle = .primary,
    size: ZodiakPinSize = .medium,
    isSelected: Bool = false,
    onTap: (() -> Void)? = nil
)

// Map overlay with positioned pins
struct ZodiakPinMapItem: Identifiable {
    let id: UUID; let relativeX: CGFloat; let relativeY: CGFloat
    let pin: ZodiakPin; let callout: String?
    init(id: UUID = UUID(), relativeX: CGFloat, relativeY: CGFloat,
         pin: ZodiakPin, callout: String? = nil)
}

ZodiakPinMap(
    backgroundSystemImage: String,
    pins: [ZodiakPinMapItem],
    aspectRatio: CGFloat = 16 / 9
)
```

---
