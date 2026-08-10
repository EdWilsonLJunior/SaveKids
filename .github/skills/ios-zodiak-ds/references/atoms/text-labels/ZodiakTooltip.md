> **Platform**: iOS

# ZodiakTooltip — `Shared/DesignSystem/Atoms/Tooltip/ZodiakTooltip.swift`

```swift
enum ZodiakTooltipPlacement { case top, bottom, leading, trailing }

// Wrapper form
ZodiakTooltip<Anchor: View>(
    _ message: String,
    placement: ZodiakTooltipPlacement = .top,
    @ViewBuilder anchor: @escaping () -> Anchor
)

// Modifier form (preferred)
someView.zodiakTooltip(_ message: String, placement: ZodiakTooltipPlacement = .top)
```

## When to use
- Brief contextual hint for a UI element that might be unclear.
- Trigger: tap to show, auto-hides after ~2.5s.
- Max width: 230pt (enforced by DS).

## When NOT to use

<never>
- ❌ Never for long explanations — keep text short and scannable.
- ❌ Never for information the user **needs** to complete the action — that belongs in helper text or a label.
- ❌ Avoid placing critical or required information inside a tooltip.
</never>
