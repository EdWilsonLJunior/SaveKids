# Guidelines — Show more button

> Reveals more content progressively without navigating away from the page.

**Related sections:** [Overview](Overview%20-%20Show%20more%20button.md) · [Specs](Specs%20-%20Show%20more%20button.md)

## Usage

Use the show more button to **prevent overwhelming users** with too much content at once.

## Content

| Principle | Description |
| --- | --- |
| **Progressive disclosure** | Ensure the initial set provides enough context and value. The button should clearly indicate what will happen when clicked. |
| **Consistent grouping** | Reveal content in logical batches (e.g., 6 cards at a time) to maintain predictability. |
| **Avoid duplication** | Ensure newly revealed content does not repeat what is already visible. |
| **Loading feedback** | If content loads asynchronously, provide a loading indicator or skeleton state for clarity. |

## Accessibility

| Requirement | Detail |
| --- | --- |
| **Keyboard navigation** | The button is focusable and operable via `Enter` or `Space`. |
| **Screen reader labels** | Label the button descriptively — e.g., "Show 6 more articles" instead of just "Show more". |

## SEO

> If Show more replaces pagination, implement structured data and ensure **unique URLs or query parameters** for each state so search engines can index all content.

## Do's and Don'ts

| ❌ Don't | ❌ Don't |
| --- | --- |
| Don't change the icon. | Don't move the position of the icon. |
