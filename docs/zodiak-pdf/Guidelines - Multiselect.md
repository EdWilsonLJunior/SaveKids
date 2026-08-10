# Multiselect

Select multiple values from a list of options.

Overview

Specs

Guidelines

## Usage

Use a multiselect when users need to select more than one option from a known set of values.

Two related components, dropdown and combobox, support different selection behaviors and use cases:

When not to use

When only a single selection is allowed (use a dropdown or radio buttons instead).

When the list of options is very long and difficult to scan (consider a combobox instead).

When all options must be visible at all times (use a group of checkboxes instead).

Content

Label text

Label text informs users what to expect in the list of options.

Keep the label text short and concise by limiting it to a single line of text.

Do not remove label text in favor of using placeholder text in the multiselect field. Labels are always strongly encouraged to be included.

Helper text

Helper text provides relevant guidance to help users make the correct selection from a menu. It appears below the label and is visible when the dropdown field is focused.

Use helper text to:

Clarify the purpose of the multiselect or explain selection criteria.

Provide formatting rules or additional context for the choices.

Offer feedback or instructions to ensure accurate input.

Keep it concise, ideally one line.

Use sentence-style capitalization and full sentences with punctuation.

Avoid overwhelming users with too much detail; helper text should support, not distract.

Types of helper text messages

Informational: Offers hints or helpful details. Example: “Select your department from the list.”

Warning: Alerts users to potential issues. Example: “Changing this selection may affect your settings.”

Error: Explains why a choice is invalid and how to fix it. Error messages replace helper text until resolved. Example: “Please select at least one option.”

Success: Confirms a valid action. Example: “Selection saved successfully.”

Field placeholder text

Placeholder text is optional to display in the multiselect field if no option has been selected yet from the list. Do not put important information in placeholder text because the text disappears once an option is selected from the list. Reserve important information for multiselect label text or helper text, which always remains visible.

Use clear and concise placeholder text in the multiselect field to indicate how to interact with the dropdown. For example, “Choose an option” is commonly used as placeholder text.

Menu options text

Menu option text should be brief, accurate, and not descriptive.

Never use decorative images or icons within a the menu.

We recommend presenting the options in alphabetical order.
