# Modal

Surface critical information that demands attention.

Overview

Specs

## Guidelines

This page is a work in progress. For any inquiries, reach out to Gabriella
(gabriella.de.wit@capgemini.com) or Katarina (katarina.a.bergstrom@capgemini.com).

Figma component

Status

Anatomy

Light mode

Dark mode

Open in Figma

Healthy

1. Headline

2. Body text

3. Input field(s) (optional): This can be a text input, radio buttons or checkboxes.

4. Checkbox (optional): Generally used for terms and conditions, becomes mandatory when personal information is collected within the modal.

5. Button (optional): Depending on the variant, the modal can have one or more buttons.

6. Close button (optional): When there is no close button, the user cannot dismiss the modal themselves.

## Variants

Dismissible

All variants can be either dismissible (with a close button), or non-dismissible (without a close button).

A dismissible modal can be exited either through the close button or by selecting the background area.

Non-dismissible modals intentionally exclude a close button, generally forcing the user to make a required selection before continuing.

Informative

This modal can be used when the modal is strictly informative, and no button is needed. The close button is optional.

Informative with buttons

The checkbox, secondary and tertiary buttons are all optional. The close button is also optional.

Informative modal with checkbox and additional buttons.

Modal without checkbox or additional buttons.

Input fields

The modal can also include input fields. The second input field and the checkbox, as well as the close button, are optional.

Modal with input field

With radio buttons

The modal can include a group of radio buttons. The secondary and tertiary buttons, as well as the close button, are optional.

Modal with radio button group With checkboxes The modal can include a group of checkboxes. The secondary and tertiary buttons, as well as the close button, are optional.

Modal with checkbox group

## Behavior

Desktop

For desktop viewports, the modal appears centered with an overlay-page-overlay applied to dim the background and keep focus on the modal.

Modal on desktop.

Mobile and tablet

For screens mobile and tablet viewports, the modal appears at the bottom of the screen, using the full width of the current viewport. To dim the background, the overlay-page-overlay token is applied, which keeps focus on the modal.

Appearance will be animated upon both activation and dismissal.

Modal on mobile.

Related components

Includes

Regular button
Initiate an action or event when clicked.

Text input
Enter and edit text through an input area.

Checkbox
Collect multiple selections.

Radio
Choose a single option from a set.

Similar components

Notification
Inform users about updates, actions, and events.

Form on page
Display a short form directly on the page.

Form in drawer
Show an form inside a slide-out drawer.

Login
Enable secure access through a clear entry point.
