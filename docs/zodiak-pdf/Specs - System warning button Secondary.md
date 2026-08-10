# Specs — System warning button (Secondary)

> A medium-emphasis button used for destructive or critical system actions where Primary would be visually overwhelming.

**Related sections:** [Overview](Overview%20-%20System%20warning%20button.md) · [Guidelines](Guidelines%20-%20Warning%20button.md) · [Specs Primary](Specs%20-%20System%20warning%20button%20primary.md)

## States

The system warning button supports the five standard interaction states.

## Color — Secondary (outlined)

| State | Border / fill | Foreground | Token |
| --- | --- | --- | --- |
| Default | `#b3261e` border, transparent fill | `#b3261e` | `action-warning-default` |
| Hover | `#8c1d18` | `#8c1d18` | `action-warning-hover` |
| Focus | `#b3261e` border + `#2e323a` ring | `#b3261e` | `action-warning-default` + `action-focus-onLite` |
| Pressed | `#601410` | `#601410` | `action-warning-pressed` |
| Disabled | `#a6acb5` | `#a6acb5` | `action-disabled` |

> Pair Secondary with a Primary cancel/confirm action only when both options carry comparable consequences.
