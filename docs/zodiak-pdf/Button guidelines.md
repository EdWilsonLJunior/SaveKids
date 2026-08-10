# Button guidelines

> Each button type serves its own use case. This page covers general guidelines that apply to **all** button types.

## Button types

| Type | Purpose |
| --- | --- |
| **Regular button** | Initiate an action or event when clicked. |
| **Icon button** | Trigger an action using a recognizable symbol. |
| **Menu button** | Compactly open a navigation menu. |
| **Arrow button** | Indicate clickable areas used for navigation. |
| **Media button** | Control audio and video playback. |
| **Video preview button** | Pause or resume an auto-played video preview. |
| **Warning button** | Highlight actions that may have unintended or irreversible consequences. |
| **System button** | Trigger actions in complex systems or digital products. |
| **System warning button** | Signal high-risk actions within complex systems. |

## Variants and hierarchy

Most buttons come in **three variants**: primary, secondary, and tertiary. Each variant indicates a different level of emphasis. Establishing a clear button hierarchy helps users prioritize actions and navigate interfaces more effectively.

| Variant | Usage | Limit per page |
| --- | --- | --- |
| **Primary** | Main action on a page (e.g. submitting, saving). | 1 (rarely 2) |
| **Secondary** | Actions that complement the primary button but are less important. | up to 4 |
| **Tertiary** | Low-priority, additional actions. | no limit |

### Warning variant

Regular and System buttons have a warning variant, indicated by the **exclamation icon and red color**. Warning buttons represent **irreversible and destructive changes** and should always be followed by a user confirmation before completing the action.

- **Button regular warning** — for typical destructive UI actions.
- **Button system warning** — for high-risk actions in complex systems.

## States

All button types and subsequent variants support **five distinct interaction states**.

| # | State | Description |
| --- | --- | --- |
| 1 | **Default** | Button is idle and ready for interaction. Appears when the page loads or when no user action is taking place. |
| 2 | **Hover** | Appears when a user moves their cursor over the button, providing a visual cue that the button is interactive. |
| 3 | **Pressed** | Button is actively being clicked or tapped. Gives immediate feedback that the action is being registered. |
| 4 | **Focus** | Appears when the button is selected via keyboard navigation (e.g. using `Tab`), indicating it is ready for interaction. |
| 5 | **Disabled** | Button is inactive and cannot be interacted with. Does not respond to hover, focus, or press events and typically appears dimmed. |

## Button groups

Buttons can be grouped and arranged either **horizontally** or **vertically**.

### Placement

When arranging buttons, always consider their hierarchy and align them according to typical reading patterns. **Primary buttons should always be placed before secondary buttons.**

| ✅ Do | ❌ Don't |
| --- | --- |
| Place the primary button on the left to align it with typical reading patterns. | Don't place two primary buttons side by side. |
| Place the primary button above the secondary button to emphasize the main action. | Don't place a secondary button to the left of the primary button. |

### Spacing

In both horizontal and vertical arrangements, all button types should have the `spacing-xs` token (16 px) applied as spacing between them. Always ensure consistent spacing between each button in the group.

| ✅ Do | ❌ Don't |
| --- | --- |
| Use consistent spacing between all button types in a group. | Don't have inconsistent spacing between buttons in a group. |

## Content

### Label

Button labels should clearly describe the action that will occur when the button is clicked. Labels should be **straightforward, predictable, and descriptive** to ensure accessibility for all users, including those with screen readers.

| ✅ Do | ❌ Don't |
| --- | --- |
| Use a descriptive button label. | Don't use vague labels like *"Read more"*. |

### Arrows and chevrons

Although chevrons and arrows appear visually similar, they serve **distinct functional purposes**.

- **Arrows** indicate **navigation**. When placed on a button or link, an arrow suggests that the user will be taken to a different page or view.
- **Chevrons** reveal or hide content that is **already present on the current page** but not immediately visible. Common in accordions, dropdowns, and sliders.

> Example: a chevron expands and collapses an accordion, while an arrow button navigates to another page.

| ✅ Do | ❌ Don't |
| --- | --- |
| Use chevrons to reveal more content on the same page. | Don't use arrows to reveal content available on the same page. |

> An example of the *Card Reveal* component uses a chevron that shows text when hovered over.

---

**Related:** [Overview - Regular button](Overview%20-%20Regular%20button.md) · [Overview - Icon button](Overview%20-%20Icon%20button.md) · [Overview - Arrow button](Overview%20-%20Arrow%20button.md)
