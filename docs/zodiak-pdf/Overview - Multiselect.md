# Multiselect

Select multiple values from a list of options.

Overview

Specs

Guidelines

Figma component

Status

Open in Figma

Healthy

Multiselect allows users to choose multiple options from a list of predefined values. Each option includes a checkbox, making it clear that more than one choice can be selected.

Use a multiselect when users need to apply several selections at once, such as filtering or categorizing content. If only one option is required, use a Dropdown. If users need to search through a large list, use a

Combobox.

Anatomy

Closed menu

Light mode

Dark mode

1. Label: Should always be visible. It informs the user what to expect in the list of dropdown options.

2. Required indicator (optional): Indicates whether the field is required or optional.

3. Container: Holds all text field elements and reflects the interaction states.

4. Placeholder text (optional): Persists when the dropdown is open or closed. Placeholder text is optional to display in the dropdown field if no option has been selected yet from the list. Do not put important information in placeholder text because the text disappears once an option is selected from the list.

5. Helper text and icon (optional): Provides additional guidance, such as formatting rules or validation feedback.

6. Chevron: Signals that the dropdown menu can be expanded or collapsed. It rotates 180 degrees when the menu is toggled.

Opened menu

Light mode

Dark mode

1. Selected label: The placeholder text changes to display the label of the option that is selected.

2. All labels option (optional): Can be configured to select all the options in the menu.

3. Selected option: Changes color and has a checkmark to display the options that are currently being

selected.

4. Amount of items selected badge: After selections are made, a badge appears showing the total number of selected options.

5. Menu: The list of options to choose from. Appears when the multiselect container is clicked and contains all available options. Present the options alphabetically or numerically for easy scanning.

Scrolling

A maximum of five menu options can appear before the scroll feature appears.

Scroll bars may not always be enabled so we recommend showing 50% of the last option’s container height to indicate there is more to see within the menu. We recommend starting a scroll at the sixth option in the menu list, but this may vary based on your specific use case.

## Behavior

By default, the multiselect displays any placeholder text in the field when closed. Activating a closed field opens a menu of options.

The menu stays open while options are being selected. The menu closes by clicking the field or outside of the multiselect, or by pressing Esc or tabbing away from the component.

Related components

Similar components

Dropdown
Select one value from a list of options.

Combobox
Select one value from a list of options using search.

Text input
Enter and edit text through an input area.

Includes

Checkbox

Collect multiple selections.
