# Combobox

Select one value from a list of options using search.

Overview

Specs

Guidelines

Figma component

Status

Open in Figma

Healthy

A combobox combines a text input with a dropdown list, allowing users to filter options by typing and select a single value. It supports both selecting from suggested options and entering a custom value.

Use a combobox when the list of options is large, dynamic, or not fully predefined. If the list is short and static, use a Dropdown instead. If users need to select multiple options, use a Multiselect.

Anatomy

Closed dropdown

Light mode

Dark mode

1. Label: Should always be visible. It informs the user what to expect in the list of options.

2. Required indicator (optional): Indicates whether the field is required or optional.

3. Container: Holds all text field elements and reflects the interaction states.

4. Magnify glass icon and search text: Disappears when the field or an option from the list is selected. Do not put important information in search text because the text disappears once an option is selected from the list. Reserve important information for the label text or helper text, which always remains visible. Use clear and concise search text in this field to indicate how to interact.

5. Helper text and icon (optional): Provides additional guidance, such as formatting rules or validation feedback.

6. Chevron: Signals that the combobox menu can be expanded or collapsed. It rotates 180 degrees when the menu is toggled.

Opened menu

Light mode

Dark mode

1. Selected label: The search field changes to display the label of the option that is selected.

2. Selected option: Changes color and has a checkmark to display the option that is currently being

selected.

3. Close icon: Clears the input.

4. Menu: A list of options to choose from. Appears when the combobox container is clicked and contains all available options. Present the options alphabetically or numerically for easy scanning.

## Variants

The combobox is available in two variants: a regular and a country variant. The country variant includes country flags and allows users to select a country from the list.

Combobox regular variant.

Combobox country variant.

Scrolling

A maximum of five dropdown options can appear before the scroll feature appears.

Scroll bars may not always be enabled so we recommend showing 50% of the last option’s container height to indicate there is more to see within the menu. We recommend starting a scroll at the sixth option in the menu list, but this may vary based on your specific use case.

## Behavior

By default, the combobox displays placeholder text in the field when closed.

When hovering over the field, a text cursor appears.

The menu opens by clicking anywhere in the field, allowing users to type and sort through the list of options. The best-matching option is highlighted as users type.

When typing a character, focus stays on the field while an option in the menu is highlighted that best matches the typed character.

When typing multiple characters in rapid succession, focus stays on the field while an option in the menu is highlighted that best matches the string of characters typed.

After typing text in the field, the close (x) icon appears to the right of the text in the field. This clears any text that’s been entered in the field.

Selecting an option closes the menu and the selected option replaces the placeholder text.

Related components

Similar components

Dropdown
Select one value from a list of options.

Multiselect
Select multiple values from a list of options.

Text input
Enter and edit text through an input area.
