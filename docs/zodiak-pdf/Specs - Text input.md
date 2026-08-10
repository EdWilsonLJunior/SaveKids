# Text input

Enter and edit text through an input area.

## States

Text fields can appear in several states depending on user interaction. Each state communicates a specific condition of the field.

State Default

State

Error

State

Filled

State Active

State Hover

State

Focus

State Disabled

1. Default: The field is idle and ready for input. This state appears when the page loads, when the reset

button is pressed, or when the field is enabled but not currently focused.

2. Focus: The user has activated the field by clicking, tapping, or using the Tab key. This state indicates

that the field is ready to receive input.

3. Error: The input is invalid due to an incorrect format, missing required data, or a system-level issue.

This state prevents submission until corrected and requires user action.

4. Error + Focus: The user has selected a field in an error state to make corrections. This state combines visual cues from both the error and focus states.

5. Success: The input has been validated and is ready for submission. This state confirms that the data meets all requirements.

6. Disabled: The field is inactive and cannot be interacted with. It does not respond to focus or input events.

## Size

Single- and multi-line text fields are available in two sizes. Use small text fields when multiple fields are present, especially in complex forms or when space is limited. Use large text fields when a form contains only one input. Larger fields improve tap targets, accessibility, and visual clarity.

Size specifications of the single-line text field.

Width

Text field widths should reflect the expected length of user input and align with the grid system. Avoid fields that are disproportionately wide, as they may suggest more input than necessary or disrupt visual balance. When multiple fields expect similar-length input, use consistent widths to support visual rhythm.

Text fields should not expand as users type. The maximum width is determined by the form container and must not exceed the container’s width minus padding.

Do

Don't

Make text input widths proportional to the content and align to grid columns.

Do not make text inputs excessively wide just to fill in space.

## Placement

Text fields should vertically align to the grid and with other typographic elements on the page. They should always be aligned to the columns. Alignment may vary depending on the input style, but consistency across form components on the page must be maintained.

Do

Don't

Align default input containers to the grid so the input label aligns with other type of the page.

Do not align field text to the grid and hang the field in the gutter.
