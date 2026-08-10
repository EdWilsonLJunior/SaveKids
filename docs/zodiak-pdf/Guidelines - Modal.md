# Modal

Surface critical information that demands attention.

Overview

Specs

Guidelines

## Usage

When to use

For critical decisions, such as warnings and alerts.

For input that is required before continuing.

For authentication or permissions.

For notifications of urgent information that must not be missed.

When not to use

For complex or multi-step tasks.

For extensive data gathering. Use the form on page of form in drawer component instead.

Don't

Do

Do not use a modal for information that does not require immediate attention or action.

Use a notification for content that does not require immediate action.

Content

Content in modal should be as short and informative and possible. No ambiguity is allowed in content writing for a modal.

Don't

Do

Don’t use unclear headlines, long, hard-to-read body text, and buttons that don’t provide context.

Use clear, short headlines, short body text and buttons that are self explanatory.

## Accessibility

All modal functionality must be available via keyboard alone.

Esc should close the modal (unless it's a non dismissible modal).

Tab and Shift + Tab should cycle through focusable elements within the modal.

Use role="dialog" for regular modals, or role="alertdialog" for urgent, attention- required messages.

Add aria-modal="true" to prevent screen reader users from interacting with background content.

SEO

Important modal content must be available at an indexable, shareable URL. This is especially important for things like terms and conditions.
