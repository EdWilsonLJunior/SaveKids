# Overview — Tabs

> Organize content into sections within the same view.

**Related sections:** [Specs](Specs%20-%20Tabs.md) · [Guidelines](Guidelines%20-%20Tabs.md) · [Overview (dark mode)](Overview%20-%20Tabs%20darkmode.md)

| Figma | Status |
| --- | --- |
| [Open in Figma](#) | Healthy |

Tabs are used to **organize related content into categories or sections within the same view**. Users can navigate quickly between related content without changing pages.

## Anatomy

> Available for both **light mode** and **dark mode**.

1. **Label** — displays the name of the section or view the tab represents.
2. **Indicator line** — horizontal line beneath the label that visually communicates the state of the tab.

## Behavior

The tab system allows **only one tab to be active at a time**. Clicking a tab activates it, displays its associated content, and hides the content of all other tabs. Tabs retain their state unless explicitly reset or refreshed, and the active tab is visually distinguished using **heavier text font** and a **blue underline**.

When the tab amount exceeds the width of the current viewport, **side scrolling** appears.

### Side scrolling

On mobile, when the width of the tab group exceeds the screen width, side scrolling the tabs becomes possible. A **chevron** appears to visually indicate the direction that can be scrolled.

- Tapping the chevrons scrolls the tabs horizontally.
- Dragging the tabs also scrolls the content horizontally.

## Related components

**Used within:**

- **Headline** — introduce the primary content of a section.
