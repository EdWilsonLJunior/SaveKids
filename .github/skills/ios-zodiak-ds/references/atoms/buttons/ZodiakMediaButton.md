> **Platform**: iOS

# Media Button — `Shared/DesignSystem/Atoms/Button/ZodiakMediaButton.swift`

```swift
enum ZodiakMediaAction {
    case play, pause, stop, skipBack, skipForward
    case rewind, forward, forward15s, back15s
    case muteOff, maxVolume, minVolume
    case shuffle, speed(String), close
}
enum ZodiakMediaButtonVariant { case onLite, onHeavy, onPhoto }

ZodiakMediaButton(
    mediaAction: ZodiakMediaAction,
    action: () -> Void,
    variant: ZodiakMediaButtonVariant = .onLite,
    size: ZodiakIconButtonSize = .large,
    isEnabled: Bool = true
)
```

## When to use
- Audio or video player controls only.
- Choose `.variant` based on background: `.onLite` (light), `.onHeavy` (dark), `.onPhoto` (image).
- For auto-play video preview toggle → use `ZodiakVideoPreviewButton`.

---
