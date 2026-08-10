# Accessibility — Color

> Ensure color choices meet WCAG AA contrast requirements and remain usable by people with visual impairments and color blindness.

**Related sections:** [Introduction](Introduction%20-%20Color.md) · [Primitive colors](Primitive%20colors%20-%20Color.md) · [Semantic colors](Semantic%20colors%20-%20Color.md)

## Tools

| Tool | Purpose |
| --- | --- |
| **Stark — Contrast & Accessibility Checker** (Figma plugin) | All-in-one accessibility plugin for Figma that scans, simulates, suggests, and annotates your designs. |
| **WebAIM: Contrast Checker** | Test the contrast of foreground and background colors directly in the browser. |

## Color contrast

Color contrast is essential for making content accessible to users with visual impairments. We adhere to **WCAG AA** standards for color contrast across all our interfaces. This ensures that our designs are accessible to everyone.

To determine the required level of color contrast for a component, first identify its type:

- **Decorative and disabled elements** — no specific color contrast requirement.
- **Information-bearing elements** — must have adequate contrast between the foreground (text or graphics) and the background.

### Minimum contrast ratios

| Element | Min ratio | Notes |
| --- | --- | --- |
| Standard text | 4.5:1 | — |
| Large text | 3:1 | At least 18-point regular or 14-point bold, or equivalent size for CJK fonts. |
| UI components and controls | 3:1 | Must have enough contrast to identify and operate, including non-text indicators like checkboxes and dropdown arrows. |
| Graphical objects | 3:1 | Parts of graphics required to understand the content must meet contrast guidelines. |
| Decorative and disabled elements | None | — |

### Key points

- When placing text over backgrounds that may change (gradients or images), ensure the text color maintains the required contrast ratio throughout.
- Elements that aren't text but are crucial for interaction — such as buttons and interactive icons — must be easily distinguishable from their background, adhering to the 3:1 contrast ratio.
- Check the contrast of your colors **as you are designing**, not once you're all done. Manually reviewing colors trains your eye to quickly identify which combinations are accessible.
- Don't aim for the minimums — aim to exceed them.

## Color blindness

Ensuring accessibility in design is crucial, especially for individuals with color blindness. **Do not rely solely on color** to convey information, indicate actions, prompt responses, or distinguish elements. Use text labels, patterns, or icons alongside color (e.g., for error states, charts, or status indicators).

Color-blindness simulators help designers understand how their designs appear to individuals with color blindness. For Figma, the **Contrast** and **Stark** plugins are excellent resources for both checking contrast and simulating color blindness.

## Surface colors accessibility

The accessibility scores of the surface colors behind `text-primary` and `text-inverse` are displayed below. For other combinations, always check the accessibility score to ensure sufficient contrast.

The `text-primary` color token is used for most text elements in both Light and Dark modes. When the background is too dark in Light mode or too light in Dark mode, use `text-inverse` to maintain readability.

| Surface (background) | Foreground token | Foreground hex |
| --- | --- | --- |
| `#f8fafc` (Light surface) | `text-primary` | `#171a22` |
| `#171a22` (Dark surface) | `text-inverse` | `#ffffff` |

> Refer to the original PDF for the rendered swatches and contrast scores.
