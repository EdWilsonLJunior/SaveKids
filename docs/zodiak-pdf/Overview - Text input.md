# Text input

Enter and edit text through an input area.

Overview

Specs

Guidelines

Figma component

Status

Open in Figma

Healthy

Text input fields collect user input. They support both short and long-form entries and are often paired with labels, helper text, and validation messages to guide interaction.

Anatomy

1. Label: Should always be visible. Describes the expected input clearly and concisely.

2. Required indicator (optional): Indicates whether the field is required or optional.

3. Container: Holds all text field elements and reflects the interaction states.

4. Placeholder text (optional): Offers a hint or example. Disappears when the user begins typing. Use only when necessary, never as a replacement for a label.

5. Helper text and icon (optional): Provides additional guidance, such as formatting rules or validation feedback.

## Variants

Text fields come in three variants to accommodate for short and long content. Choose the text field variant based on the expected content length.

The variants of the text fields: a regular text field, short text area and a long text area.

Single-line fields

Single-line text fields are ideal for short responses. They display only one line of text, and when the content exceeds the field’s width, it scrolls horizontally.

Use single-line fields when:

The input is brief (e.g., name, email, search)

Space is limited

A compact layout is preferred

Avoid using single-line fields for long-form input. For those cases, use a multi-line field or text area instead.

The single-line field scrolls left once the content exceeds its width.

Text areas

Text areas are fixed-height fields that scroll vertically when the content exceeds the visible space. They are taller than regular text area fields and signal to users that longer responses are expected and encouraged.

Text areas can have a character counter to display the amount of characters used and the total limit.
Character counters should be used when input length is restricted.

Use text areas when:

The input may span multiple lines.

You want to show all user input at once.

You want to visually indicate that extended input is welcome.

Ensure the height of text areas fits within mobile screen sizes to maintain usability and accessibility.
