> **Platform**: iOS

# Video Preview Button — `Shared/DesignSystem/Atoms/Button/ZodiakVideoPreviewButton.swift`

```swift
ZodiakVideoPreviewButton(
    isPlaying: Binding<Bool>,
    action: () -> Void
)
```

## When to use
- Only for **auto-playing video preview** pause/resume control.
- Always positioned at **bottom-right** of the video frame.
- Uses secondary style — playing the full video is the primary action.
- For regular (non-preview) videos → use `ZodiakMediaButton`.

---
