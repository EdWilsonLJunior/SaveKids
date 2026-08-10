# Multiselect

Select multiple values from a list of options.

Properties

Property

BG Variant

Values

Default

Surface Smoke | Page
Background

Page Background

Open Variant

False | True

Size Variant

M | L

False

M

Default

State Variant

Show helper
text

Default | Hover | Filled |
Error | Focus | Disabled

Boolean

true | false

undefined

Show icon Boolean

true | false

Helper text Text

string

Choose an option Text

string

Option selected Text

string

undefined

Helper Text

Choose an option

Option selected

Error text Text

string

Error Text

## States

Default state

Hover state

Filled state with open menu

Filled state

Focus state

Error state

Disabled state

1. Default: The initial state before any interaction. Shows the label and optional placeholder text.

Chevron icon indicates the dropdown can be expanded.

2. Hover: Triggered when the user moves the pointer over the multiselect field. Visual cue (e.g., subtle

background or border change) signals interactivity.

3. Filled (open menu): Displays the list of options. Chevron icon flips upward to indicate expanded state.

User can scroll or select an option.

4. Filled (closed menu): Occurs after the user selects an option. Selected values replace the placeholder text. A blue badge appears that shows the amount of selected options.

5. Error: Indicates a validation issue (e.g., required field left empty). Shows error message and optional alert icon. The input is invalid due to an incorrect format, missing required data, or a system-level issue.

This state prevents submission until corrected and requires user action.

6. Focus: Activated when the user clicks into the field or navigates via keyboard. Highlights the field to indicate readiness for input.

7. Disabled: The field is inactive and cannot be interacted with. It does not respond to focus or input events.

## Size

Dropdowns come in two height sizes: medium and large. Supporting multiple sizes provides flexibility when designing layouts, but consistency is key: use the same size for all form components on a page. For example, if you choose a large dropdown, apply the same size to text inputs, buttons, and other elements.

When in doubt, default to the medium size.

Size

## Usage

Medium

Large

Ideal for space-constrained layouts or long, complex forms.

Best for spacious layouts, simple forms, or standalone dropdowns (e.g., filters)

Menu size

Size

Usage

Small

With medium dropdown
fields.

Height

Target
height

Min
width

Max
width

40px

40px

270px

800px

48px

48px

270px

800px

Height

Target
height

Min
width

Max
width

48px

48px

-

-

Large

With large dropdown fields.

56px

56px

180px

800px

Used components sizes

These are the sizes of components that are used in the multiselect and its menu.

Element

Medium

Large

Chevron icon

S

M

Badge
counter

Checkbox

Helper icon

24×24px

24×24px

S

S

L

S

Typography

Element

Medium

Large

Label text

heading-2xs-

heading-xs-

300

300

Placeholder text

body-s-300

body-m-300

Helper text

body-xs-300

body-xs-300

Dropdown item

body-2xs-
300

body-xs-300

Color

Multiselect field colors

Menu colors

Menu shadow

The dropdown menu has a subtle shadow around it.

4px 0 70px 3px `rgba(0,0,0,0.03)`

Capgemini shadow

Menu item colors

Default

#171a22

Text Primary

#eff0f4

Border Secondary

#ffffff

Page Background

Hover

#171a22

Text Primary

#eff0f4

Border Secondary

#eff0f4

Surface Cloud Lite

#ffffff

Page Background

Focus

#f8fafc

#2e323a

#12151d

#f8fafc

#2e323a

#21252d

#12151d

#171a22

Text Primary

#ffffff

Page Background

#2e323a

Action Focus onLite

#f8fafc

#12151d

#ffffff

#1d365a

#ffffff

Action Primary Default onLite

#272b33

#f8fafc

#2e323a

#272b33

#3573c0

#171a22

#f8fafc

Surface Smoke Lite

Selected

#171a22

Text Primary

Overview

Specs

Guidelines

#eff0f4

Border Secondary

#f8fafc

Surface Smoke Lite

#3573c0

Action Active

#ffffff

Text Inverse

Disabled

#a6acb5

Text Disabled

#a6acb5

Action Disabled

#eff0f4

Border Secondary

#ffffff

Page Background

#888f9a

#3c414a

#2e323a

#12151d
