# Dropdown

Select one value from a list of options.

Overview

Specs

Guidelines

## Usage

Use a dropdown when a user needs to select a single value from a list of predefined options and when displaying all options at once would be impractical.

When not to use

When the list of options is very long and difficult to scan (consider a combobox instead).

When multiple selections are required (use the multiselect component).

When only a few options are available and quick comparison is important (use radio buttons instead).

When users need to see all options at once to make a decision.

Dropdown versus native select

Dropdown and select components have functionality and style differences.

The dropdown component is styled to match the design system, while the select component’s appearance is determined by the browser being used.

Use a dropdown component in forms, to select multiple options at a time and to filter or sort content on a page. The select dropdown does not have filtering or multiselect functionality.

Use a select dropdown component if most of your experience is form based. Custom dropdowns can be used in these situations, but the native select works more easily with a native form when submitting data.

Use a select dropdown component if your experience will be frequently used on mobile. The native select dropdown uses the native control for the platform which makes it easier to use.

Content

Label text

Label text informs users what to expect in the list of dropdown options.

Keep the label text short and concise by limiting it to a single line of text.

Do not remove label text in favor of using placeholder text in the dropdown field. Labels are always strongly encouraged to be included when possible.

Helper text

Helper text provides relevant guidance to help users make the correct selection from a dropdown menu. It appears below the label and is visible when the dropdown field is focused.

Use helper text to:

Clarify the purpose of the dropdown or explain selection criteria.

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

Placeholder text is optional to display in the dropdown field if no option has been selected yet from the list. Do not put important information in placeholder text because the text disappears once an option is selected from the list. Reserve important information for dropdown label text or helper text, which always remains visible.

Use clear and concise placeholder text in the dropdown field to indicate how to interact with the dropdown. For example, “Choose an option” is commonly used as placeholder text in dropdowns.

Dropdown options text

Dropdown option text should be brief, accurate, and not descriptive.

Never use decorative images or icons within a dropdown.

We recommend presenting the options in alphabetical order.
