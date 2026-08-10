# Specs — Menu button

> Compactly open a navigation menu.

**Related sections:** [Overview](Overview%20-%20Menu%20button.md) · [Guidelines](Guidelines%20-%20Menu%20button.md)

## States

Each menu button variant supports **five interaction states**.

| State | Description |
| --- | --- |
| **Default** | Normal state when there is no user interaction. |
| **Hover** | Appears when the cursor moves over the button — provides a visual cue that the button is interactive. |
| **Pressed** | Activates when the button is pressed or tapped and displays the mini menu. |
| **Focus** | Appears when the button is selected via keyboard navigation (e.g. `Tab`), indicating it is ready for interaction. |
| **Disabled** | Indicates that the button is inactive and cannot be interacted with. Appears dimmed; does not respond to hover, focus, or press events. |

> Mini menu items support **four** states: `default`, `hover`, `pressed`, and `focus`.

## Size

The menu button adjusts its size based on whether the viewport is **mobile** or **desktop**. If the button text exceeds the maximum width (accounting for padding), it is **truncated with an ellipsis**.

| Size | Height | Target height | Max width |
| --- | --- | --- | --- |
| **Small** | 38 px | 38 px | 312 px |
| **Medium** | 48 px | 48 px | 312 px |

## Mini menu constraints

The mini menu supports a limited number of items to maintain visual clarity. Menu item text that exceeds the available width is also truncated with an ellipsis.

| Viewport | Min width | Max width | # of items |
| --- | --- | --- | --- |
| **Mobile** | 120 px | 312 px | 2 – 5 |
| **Desktop** | 140 px | 312 px | 2 – 5 |

| ✅ Do | ❌ Don't |
| --- | --- |
| Keep the mini menu at least as wide as the menu button. | Don't make the mini menu narrower than the menu button. |

## Placement

| ❌ Don't | ❌ Don't |
| --- | --- |
| Don't place the menu button next to a regular button. | Don't place two menu buttons next to each other. |

> Placing menu buttons adjacent to other buttons increases cognitive load and diminishes the clarity of each control's purpose.
