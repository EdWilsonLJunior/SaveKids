---
applyTo: "ZodiakReact/**/*.test.{tsx,ts}"
---

# Testing Conventions — ZodiakReact

## Framework

<rules>
Use **Vitest** + **@testing-library/react** + **vitest-axe** exclusively. Do not use Jest or Enzyme for new tests.
</rules>

```tsx
import { describe, it, expect, vi } from 'vitest';
import { render, screen, fireEvent } from '@testing-library/react';
import { axe } from 'vitest-axe';
import 'vitest-axe/extend-expect';
```

---

## File and Suite Naming

| Item | Convention | Example |
|---|---|---|
| File | `ComponentName.test.tsx` (co-located with component) | `ButtonRegular.test.tsx` |
| Top-level `describe` | Component name | `describe('ButtonRegular', () => {` |
| Nested `describe` | Lowercase topic block | `describe('rendering', () => {` |
| Test name | Plain English verb phrase | `it('applies the primary class by default')` |

---

## Mandatory 4 `describe` Blocks

Every component test file **must** contain all four blocks. Do not merge or skip any:

```tsx
describe('ComponentName', () => {

  describe('rendering', () => {
    // Root element is present, children appear, default props render correctly
    it('renders without crashing', () => {
      render(<ComponentName label="Test" />);
      expect(screen.getByRole('button')).toBeInTheDocument();
    });
  });

  describe('behaviour', () => {
    // Event handlers fire, conditional rendering, state transitions
    it('calls onClick when clicked', () => {
      const handleClick = vi.fn();
      render(<ComponentName label="Test" onClick={handleClick} />);
      fireEvent.click(screen.getByRole('button'));
      expect(handleClick).toHaveBeenCalledOnce();
    });
  });

  describe('class names', () => {
    // Correct CSS classes for each prop value
    it('applies variant-primary class when variant is primary', () => {
      const { container } = render(<ComponentName variant="primary" />);
      expect(container.querySelector('.zodiak-component')).toHaveClass(
        'zodiak-component-variant-primary'
      );
    });

    it('includes custom className', () => {
      const { container } = render(<ComponentName className="extra" />);
      expect(container.firstChild).toHaveClass('extra');
    });
  });

  describe('accessibility', () => {
    // axe check on the default render AND on each significant variant
    it('has no accessibility violations (default)', async () => {
      const { container } = render(<ComponentName label="Test" />);
      expect(await axe(container)).toHaveNoViolations();
    });

    it('has no accessibility violations (disabled)', async () => {
      const { container } = render(<ComponentName label="Test" disabled />);
      expect(await axe(container)).toHaveNoViolations();
    });
  });
});
```

---

## Accessibility Requirements

<rules>
- Run `axe` on **every significant variant** — not just the default render.
- Significant variants: disabled state, error state, different `type`/`variant` values that change rendered HTML structure.
- WCAG 2.1 AA is required. Do not merge or skip the `accessibility` describe block.
- Every interactive element must have an accessible name — verify that `ariaLabel`, `label`, or surrounding text provides one.
</rules>

---

## Class Name Testing Pattern

Test each prop value that maps to a CSS modifier class:

```tsx
describe('class names', () => {
  it.each([
    ['small',  'zodiak-component-size-small'],
    ['medium', 'zodiak-component-size-medium'],
    ['large',  'zodiak-component-size-large'],
  ])('size="%s" applies class "%s"', (size, expected) => {
    const { container } = render(<ComponentName size={size as ComponentSize} />);
    expect(container.firstChild).toHaveClass(expected);
  });
});
```

---

## Behaviour Testing Patterns

```tsx
describe('behaviour', () => {
  it('does not call onClick when disabled', () => {
    const handleClick = vi.fn();
    render(<ComponentName label="Test" disabled onClick={handleClick} />);
    fireEvent.click(screen.getByRole('button'));
    expect(handleClick).not.toHaveBeenCalled();
  });

  it('renders error message when error prop is set', () => {
    render(<ComponentName label="Email" error="Invalid email" />);
    expect(screen.getByText('Invalid email')).toBeInTheDocument();
  });

  it('does not render error message when error is undefined', () => {
    render(<ComponentName label="Email" />);
    expect(screen.queryByRole('alert')).not.toBeInTheDocument();
  });
});
```

---

## Storybook — 2 Mandatory Exports

Every `ComponentName.stories.tsx` must export exactly two stories:

```tsx
import type { Meta, StoryObj } from '@storybook/react';
import { ComponentName } from './ComponentName.js';
import changelog from './CHANGELOG.md?raw';

const meta: Meta<typeof ComponentName> = {
  title: 'Components/Category/ComponentName',
  component: ComponentName,
  parameters: { changelog },
  argTypes: {
    // Document controls; hide internal/plumbing props
    className: { table: { disable: true } },
  },
  args: { label: 'Default' },
};
export default meta;
type Story = StoryObj<typeof ComponentName>;

// 1. AllOptions — static grid, all variants, no interactive args
export const AllOptions = () => (
  <div style={{ display: 'flex', flexWrap: 'wrap', gap: 16, padding: 24 }}>
    <ComponentName variant="primary" label="Primary" />
    <ComponentName variant="secondary" label="Secondary" />
    <ComponentName disabled label="Disabled" />
  </div>
);
AllOptions.storyName = 'All options';

// 2. Playground — single instance driven by Storybook controls
export const Playground: Story = {
  render: (args) => (
    <div style={{ padding: 48 }}>
      <ComponentName {...args} />
    </div>
  ),
};
```

---

## Rules

<rules>
- Do not use `beforeEach` / `afterEach` for shared setup — each `it` must be self-contained.
- Do not test implementation details (internal state, private methods).
- Use `vi.fn()` for event handler mocks. Never spy on DOM methods.
- Import components with `.js` extension (NodeNext resolution): `import { X } from './X.js'`.
- Keep each `it` body under 20 lines. Extract helpers for repeated setup.
- The `accessibility` block runs `axe` — these tests are intentionally slower; do not skip them.
</rules>
