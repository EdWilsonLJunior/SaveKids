# Specs — System warning button (Primary)

> A high-emphasis button used for destructive or critical system actions.

**Related sections:** [Overview](Overview%20-%20System%20warning%20button.md) · [Guidelines](Guidelines%20-%20Warning%20button.md) · [Specs Secondary](Specs%20-%20System%20warning%20button%20Secondary.md)

## States

The system warning button supports the five standard interaction states: `default`, `hover`, `focus`, `pressed`, and `disabled`.

## Color — Primary

| State | Background | Foreground | Token |
| --- | --- | --- | --- |
| Default | `#b3261e` | `#ffffff` | `action-warning-default` / `text-inverse` |
| Hover | `#8c1d18` | `#ffffff` | `action-warning-hover` |
| Focus | `#b3261e` + `#2e323a` ring | `#ffffff` | `action-warning-default` + `action-focus-onLite` |
| Pressed | `#601410` | `#ffffff` | `action-warning-pressed` |
| Disabled | `#a6acb5` | `#d9dde3` | `action-disabled` / `action-disabled-content` |

> Use sparingly: reserve the system warning button for irreversible or system-critical actions (delete account, wipe data, etc.). For in-context warnings, use the [Warning button](Specs%20-%20Warning%20button%20primary.md).
