# Overview — Typography

> Communicate clearly with a unified typographic voice.

**Related sections:** [Size](Size%20-%20Typography.md) · [Color](Color%20-%20Typography.md) · [Usage](Usage%20-%20Typography.md)

## Usage

To ensure an optimal reading experience, we've carefully crafted the typography based on established UX principles. This includes **high contrast** between text and background, **comfortably narrow column widths**, and **line spacing** to support effortless readability.

## Typeface

Our brand typeface is **Ubuntu**. It combines a friendly and technical feel, reflecting our commitment to the positive impact of technology on humanity.

### Tokens and text styles

> *Example: all the tokens that together create a single heading token.*

### Weight

Our typography comes in **two weights**:

| Weight | Style | Usage |
| --- | --- | --- |
| **300** | Ubuntu Light | Primary type style, used for body text and large headlines to create an open and elegant look. |
| **400** | Ubuntu Regular | Adds emphasis and is applied to smaller headlines. Helps establish a strong typographic hierarchy and visual order. |
| **400** | Ubuntu Regular Italic | Used for **decorative purposes only**. Not intended for regular headings or to highlight text in paragraphs. |

## Text width and readability

To support a comfortable reading rhythm on desktop, we follow the general guideline of limiting line length to **80–90 characters**.

Depending on the breakpoint, text width is either **fixed** or **fluid between two values** to maintain optimal readability.

## Implementation

Typography width and layout behavior are implemented through the **Text block** component. The component provides all available text layouts:

- One column (centered)
- One column (left-aligned)
- Two columns

It applies the correct text-width constraints for each option automatically.

> See the Text Block's *Layout* and *Text widths* sections for layout options and the exact width values per breakpoint.
