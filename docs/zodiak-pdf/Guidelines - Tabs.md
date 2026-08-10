# Guidelines — Tabs

> Organize content into sections within the same view.

**Related sections:** [Overview](Overview%20-%20Tabs.md) · [Overview (dark mode)](Overview%20-%20Tabs%20darkmode.md) · [Specs](Specs%20-%20Tabs.md)

## Usage

Use tabs when content is **related but too large to fit in a single view**. Use tabs when there are **2–7 sections** — too many tabs can overwhelm users.

### Use tabs when

- There are fewer than 7 categories, and each category is **distinct and mutually exclusive**.
- The categorization is simple and intuitive.
- The content within each tab is relatively small and doesn't require further filtering.

### Don't use tabs when

- You'd be creating **nested tabs**. If multiple levels of navigation are needed, consider combining tabs with other components like accordions.
- Navigating between **unrelated sections or pages**.

> For more precise, dynamic filtering of large content sets by attributes like size, type, date, and relevance, use **Filters** instead of tabs.

## Content

Clearly label tabs to reflect their content and purpose. Keep tab labels **short, consistent, and descriptive**.

| ✅ Do | ❌ Don't |
| --- | --- |
| Use clear, consistent labels. | Don't use inconsistent labels. |

## Accessibility

### Use semantic HTML

- Wrap tabs in a container with `role="tablist"`.
- Each tab should have `role="tab"` and be associated with a `tabpanel` via `aria-controls`.

### Support keyboard navigation

- **Arrow keys** to move between tabs.
- **Enter** or **Space** to activate a tab.
- Announce tab changes to screen readers using `aria-selected` and `aria-live` attributes.
