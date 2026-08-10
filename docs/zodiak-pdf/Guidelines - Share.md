# Guidelines — Share

> Provide ways to share content.

**Related sections:** [Overview](Overview%20-%20Share.md) · [Specs](Specs%20-%20Share.md)

## Usage

Use the share component when you want to enable sharing of a page or article. If downloadable content is related to an article page, the preamble component or the share article component should be used.

| ✅ Do | ❌ Don't |
| --- | --- |
| Use the share component to enable sharing. | Don't use multiple buttons to enable sharing. |

## Share menu item content

Items in the share menu must have the correct label with the type of share option and its associated icon.

## Accessibility

- When the share menu opens, focus should move to the first item in the menu.
- Use `aria-haspopup="menu"` on the main button.
- Apply `role="menu"` and `role="menuitem"` for the mini-menu structure.
