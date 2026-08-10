> **Platform**: iOS

# ZodiakLayoutGrid — `Shared/DesignSystem/Templates/ZodiakLayoutGrid.swift`

```swift
ZodiakLayoutGrid<Content: View>(
    columns: Int? = nil,              // nil = auto-adaptive (3–12 per device/orientation)
    horizontalSpacing: CGFloat? = nil,  // nil = ZodiakSpacing.s16 (iPhone) or .s (iPad)
    verticalSpacing: CGFloat? = nil,
    applyScreenPadding: Bool = true,
    @ViewBuilder content: () -> Content
)
```

## Auto-adaptive columns
| Device / Orientation | Default columns |
|---|---|
| iPhone portrait | 4 |
| iPhone landscape | 6 |
| iPad portrait | 8 |
| iPad landscape | 12 |

## When to use
- Adaptive multi-column grid inside a template's content slot.
- For a predefined card grid organism → `ZodiakCardGrid`.
- For full grid-aware layout decisions → `ZodiakViewportReader`.

---
