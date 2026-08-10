---
description: "Use when creating or modifying React components, choosing DS components, applying design tokens, writing SCSS or TypeScript in ZodiakReact. Enforces Design System reuse, token conventions, and avoids hardcoded visual styles."
name: "React Design System Rules"
applyTo: "ZodiakReact/**/*.{tsx,ts,scss}"
---

# React Design System Rules

## Primary Goal

<rules>
- Keep all changes consistent with the Zodiak Design System (`@cg-groupit/zodiak-design-system`).
- Reuse existing components before creating new UI primitives.
- All work happens in `ZodiakReact/packages/react-scss/` — never modify `react-tailwind/` or `tailwind-preset/` unless explicitly targeting those.
</rules>

## Reuse Before Creating

<rules>
- Check the existing component catalogue in `packages/react-scss/src/components/` before implementing custom UI.
- Prefer the highest-level applicable component. Tokens are for layout gaps and custom surfaces — not for recreating components that already exist.
- Full decision trees: `packages/react-scss/docs/component-decision-trees.md`.
</rules>

---

## Custom Components — Forbidden by Default

<rules>

**Any custom-built UI element is a violation unless all three conditions are met:**

1. **Evidence of gap** — the component or pattern does not exist in `@cg-groupit/zodiak-design-system` and is not achievable by composing existing DS components.
2. **Explicit approval** — a team lead or design system owner has reviewed and approved the custom implementation in writing (PR comment, task ticket, or decision log).
3. **Token-only styling** — the custom element uses exclusively `--zodiak-*` CSS custom properties for all visual properties. No hardcoded colours, no manual font-family/size/weight/line-height.

**Until all three conditions are satisfied, the correct answer is always to find an existing DS component.**

### Verification Checklist (required before creating any custom element)

Before writing a single line of custom HTML or SCSS, answer all of the following:

- [ ] Did I check `packages/react-scss/src/components/` for a direct match?
- [ ] Did I check `packages/react-scss/src/index.ts` for the full export list?
- [ ] Did I check the component decision trees in `packages/react-scss/docs/`?
- [ ] Can this be built by _composing_ two or more existing DS components?
- [ ] Is there a DS component that is _close enough_ and can be extended via `className`?

If all answers are "no" and a genuine gap exists, document it before building:

```
// CUSTOM COMPONENT — DS GAP APPROVED
// Component: <name>
// DS components checked: Typography, ButtonRegular, Notification, Notice
// Gap evidence: No DS component supports <specific behaviour/visual>.
// Approved by: <name>, <date>
```

### Known approved custom elements in this project

The following are the **only** custom-built UI elements currently approved for the DELTA Orchestrator app. All others must be replaced with DS equivalents:

| Class / Element | Reason custom is justified |
|---|---|
| `.delta-pill--d/e/l/t/a` | DELTA brand identity — not a generic DS badge |
| `.delta-badge`, `.delta-completion-badge` | DS has no `Badge`/`Tag` component (verified `src/index.ts`) |
| `.delta-step-bar` | DS has no Stepper component |
| `.delta-progress-bar` | DS has no linear ProgressBar component |
| `.delta-kpi-card`, `.delta-kpi-grid` | DS has no KPI/Stat card component |
| `.delta-reveal-card` (flip animation) | DS has no animated flip card |
| `.delta-panel` | App-specific content wrapper; `ZodiakSection` is page-level only |
| `.delta-nav-item` | Sidebar vertical navigation; DS `Tabs` is horizontal only |
| `Callout` in WikiPage | DS `Notice` accepts only `title`/`subtitle` strings, no arbitrary `children` |
| `.wiki-stat-item`, `.wiki-checklist-item`, `.wiki-pull-quote` | No DS equivalents |

**Any element not on this list must use a DS component.**

</rules>

---

## Component Anatomy

Every component lives in its own directory under `src/components/`. All six files are mandatory:

```
src/components/ComponentName/
  ComponentName.tsx          ← component + all types
  component-name.scss        ← styles (kebab-case filename)
  ComponentName.test.tsx     ← unit + accessibility tests
  ComponentName.stories.tsx  ← Storybook (AllOptions + Playground)
  CHANGELOG.md               ← per-component change history
  index.ts                   ← re-exports only, .js extensions
```

Grouped components (e.g. buttons) live in a subdirectory:

```
src/components/Buttons/
  ButtonRegular/
    ButtonRegular.tsx
    button-regular.scss
    ...
```

---

## Component Decision Reference

### Buttons

| Component | When to use | Key constraint |
|---|---|---|
| `ButtonClose` | Close / dismiss | Always icon-only; always renders × icon |
| `ButtonArrow` | Directional animated navigation | Animated arrow; icon-only |
| `ButtonIcon` | Generic icon-only action | Requires `ariaLabel`; no visible label |
| `ButtonVideoPreview` | Play/Pause or Mute control | `variant="play"` or `variant="volume"` |
| `ButtonMenu` | Static dropdown 2–5 options | Max 5 options — renders `null` silently beyond that |
| `ButtonInteractive` | Action menu (downloads, share) | `icon` prop expects **component class**, not JSX element |
| `ButtonDownload` | Single file download link | Renders as `<a download>` |
| `ButtonShare` | Share action | Opens share UI or native share sheet |
| `ButtonShowMore` | Pagination / reveal more | Controls loading state internally |
| `ButtonSystem` | Small admin/system-context action | Secondary visual weight |
| `ButtonMedia` | Media playback in card | Play video, toggle mute |
| `ButtonRegular` | Everything else | Supports icon, link, hierarchy prop |

> **Hierarchy in React:** `ButtonRegular` uses a `hierarchy` prop (`primary` | `secondary` | `tertiary`). Do **not** create `ButtonPrimary`, `ButtonSecondary`, or `ButtonTertiary` as separate components — that is the iOS/Android architecture, not React.

### Form Inputs

| Component | Pattern |
|---|---|
| `Input` | Text / number / email / textarea (`multiline` converts to `<textarea>`) |
| `ThemeToggle` | Light/dark mode (Sun/Moon icons — fixed slot behaviour) |
| `Switch` | Immediate binary on/off (Check/Close icons) |
| `Radio` | Mutually exclusive choice — wrap in `RadioGroup` |
| `Checkbox` | Multi-select — group in a `<fieldset>` |

> **ThemeToggle ≠ Switch.** `ThemeToggle` switches the page theme class. `Switch` is a generic boolean toggle. Never substitute one for the other.

### Layout — GROUP A vs GROUP B

**GROUP A — self-managing.** Place directly in the page wrapper. Never wrap inside `ZodiakLayout` or `ZodiakSection`:

`Hero` · `HeroTypographic` · `VideoBanner` · `TextBlockSection`

**GROUP B — all other components.** Must live inside `ZodiakLayout` (inside `ZodiakSection`):

```tsx
// ✅ Correct page structure
<Hero imageSrc="..." />                         {/* GROUP A */}
<TextBlockSection heading="..." items={[...]} />{/* GROUP A */}
<ZodiakSection background="neutral">            {/* GROUP B wrapper */}
  <ZodiakLayout>
    <Notification type="success" message="Done" />
    <Author name="Ana Lima" />
  </ZodiakLayout>
</ZodiakSection>
```

```tsx
// ❌ Wrong — GROUP A inside ZodiakLayout
<ZodiakSection>
  <ZodiakLayout>
    <Hero />   {/* ← breaks layout; Hero manages its own full-width */}
  </ZodiakLayout>
</ZodiakSection>
```

### TextBlock

| Component | When |
|---|---|
| `TextBlockBase` | Single standalone block; optional `column={2}` |
| `TextBlockGroup` | Grid of multiple blocks; `items` array (max 10) |
| `TextBlockSection` | Full section (wraps `ZodiakSection` + `TextBlockGroup`) |

### Notification vs Tooltip

| Component | Triggered by | Persists |
|---|---|---|
| `Notification` | System event / user action | Yes — until dismissed |
| `Tooltip` | Hover / focus | No — disappears on blur |

---

## CSS Class Naming

| Element | Pattern | Example |
|---|---|---|
| Root | `zodiak-[component]` | `.zodiak-avatar` |
| Child element | `zodiak-[component]-[element]` | `.zodiak-avatar-meta` |
| Modifier (on root) | `zodiak-[component]-[prop]-[value]` | `.zodiak-avatar-size-small` |
| State | `is-open` / `is-active` / `disabled` | on root element |

Modifiers go on the **root element only**.

---

## SCSS Rules

<rules>

### 1. Use `--zodiak-*` tokens directly — never create aliases

```scss
// ✅ Correct — reference tokens directly
color: var(--zodiak-text-primary);
gap: var(--zodiak-space-primitives-xs);

// ❌ Wrong — local alias defeats theme scoping
--local-text: var(--zodiak-text-primary);
$my-gap: var(--zodiak-space-primitives-xs);
```

**Why:** Token values are scoped to `.zodiak-theme-light` / `.zodiak-theme-dark`. A local alias resolves at alias definition, not at use — dark-mode overrides are silently lost.

### 2. Always use the typography mixin — never set font properties manually

```scss
@use "../../../scss/mixins/typography" as zt;

.zodiak-component-title {
  @include zt.type-style-heading-zodiak('XS', 500);
}
.zodiak-component-body {
  @include zt.type-style-body-zodiak('M', 400);
}
```

Never use `font-size`, `font-weight`, `line-height`, `letter-spacing`, or `font-family` manually.

Adjust the `@use` path depth (`../../../../`) to match the component's directory depth.

### 3. No Tailwind

Never use Tailwind utility classes in `packages/react-scss`.

### 4. Never edit `scss/tokens/` without approval

Token changes affect the entire system and all consuming projects.

### 5. `box-sizing: border-box` on sized bordered elements

This package has no global reset. Declare it explicitly on every component that has both a size constraint and a border/padding:

```scss
.zodiak-card {
  box-sizing: border-box;
  width: 320px;
  padding: var(--zodiak-space-primitives-m);
  border: 1px solid var(--zodiak-border-primary);
}
```

### 6. Fixed dark surfaces — use `--zodiak-text-always-white`

`--zodiak-text-inverse` is **adaptive** — it resolves to white in light mode and near-black in dark mode. On a fixed dark container, this becomes invisible in dark mode.

```scss
// ❌ Wrong — invisible text in dark mode on a fixed dark surface
.zodiak-dark-card { color: var(--zodiak-text-inverse); }

// ✅ Correct
.zodiak-dark-card { color: var(--zodiak-text-always-white); }
```

</rules>

---

## TypeScript Patterns

### Props interface — always extend HTMLAttributes

```tsx
type MyComponentProps = React.HTMLAttributes<HTMLDivElement> & {
  variant?: 'primary' | 'secondary';
  size?: 'small' | 'large';
};

// Use Omit when a prop name collides with a native HTML attribute
type VideoProps = Omit<React.HTMLAttributes<HTMLDivElement>, 'title'> & {
  title: string;
};
```

### forwardRef — always use a named inner function

```tsx
export const MyComponent = React.forwardRef<HTMLDivElement, MyComponentProps>(
  function MyComponent({ variant = 'primary', className = '', ...rest }, ref) {
    const classes = [
      'zodiak-my-component',
      `zodiak-my-component-variant-${variant}`,
      className,
    ].filter(Boolean).join(' ');

    return <div className={classes} ref={ref} {...rest} />;
  }
);
MyComponent.displayName = 'MyComponent';
```

The named inner function provides the DevTools display name even before `displayName` assignment.

### Discriminated union

Use a discriminated union when a component has mutually exclusive prop sets:

```tsx
type WithLabel = { type: 'label'; label: string };
type WithChildren = { type: 'children'; children: React.ReactNode };
type MyComponentProps = React.HTMLAttributes<HTMLDivElement> & (WithLabel | WithChildren);
```

### index.ts exports — `.js` extension required (NodeNext resolution)

```ts
export { MyComponent } from './MyComponent.js';
export type { MyComponentProps } from './MyComponent.js';
```

---

## Icon Usage

<rules>
- Always wrap icons in `<Icon>`. Never render a raw SVG component directly.
- Match icon size to component size: small component → `size="small"` (16px), medium/large → `size="medium"` (24px).
- Every `<Icon>` must have either `decorative` or `iconName` — never omit both.
- `ButtonInteractive` items and its `icon` prop expect a **component class**, not JSX.
</rules>

```tsx
// ✅ Decorative (label from surrounding text)
<Icon Component={ArrowRightIcon} size="medium" decorative />

// ✅ Meaningful (needs a screen-reader label)
<Icon Component={StarIcon} size="small" iconName="Favourite" />

// ✅ ButtonInteractive — component class, not JSX element
<ButtonInteractive
  icon={DownloadIcon}
  items={[{ label: 'PDF', icon: FileIcon, url: '/file.pdf', isDownload: true }]}
/>

// ❌ Wrong — raw SVG (no size normalisation, no accessibility handling)
<ArrowRightIcon width={24} height={24} />

// ❌ Wrong — ButtonInteractive icon as JSX element
<ButtonInteractive icon={<DownloadIcon />} items={[{ icon: <FileIcon /> }]} />
```

---

## Token Quick Reference

### Spacing (`--zodiak-space-primitives-*`)

| Token | Size | Common use |
|---|---|---|
| `3xs` | 4 px | Badge/chip padding |
| `2xs` | 8 px | Tight gap |
| `xs` | 16 px | Standard padding, button gap |
| `s` | 24 px | Section internal spacing |
| `m` | 32 px | Standard component padding |
| `l` | 40 px | Large section gaps |
| `xl` | 48 px | — |
| `2xl` | 56 px | — |
| `3xl` | 64 px | — |
| `4xl` | 72 px | Display area |
| `5xl` | 96 px | Hero-level |
| `6xl` | 128 px | Large viewport gaps |
| `7xl` | 152 px | — |
| `8xl` | 176 px | Extreme layout gaps |

Full name: `var(--zodiak-space-primitives-xs)` etc.

### Key Colour Tokens

```scss
// Text
--zodiak-text-primary           // main body text
--zodiak-text-secondary         // muted/secondary
--zodiak-text-inverse           // ⚠️ ADAPTIVE — white light / near-black dark
--zodiak-text-always-white      // always white (fixed dark surfaces)
--zodiak-text-always-black      // always dark

// Backgrounds
--zodiak-page-background
--zodiak-surface-cloud-lite     // card / panel fill
--zodiak-surface-ink-heavy      // dark / navy surface

// Borders
--zodiak-border-primary
--zodiak-border-secondary

// Actions (pick surface variant)
--zodiak-action-primary-default-onlite    // CTA on light surface
--zodiak-action-primary-default-onheavy  // CTA on dark surface
```

### Typography Mixin Keys

```scss
// Heading (sm → lg)
'2XS'(14px) · 'XS'(16px) · 'S'(18px) · 'M'(24px) · 'L'(32px) · 'XL'(40px)
'2XL'(48px) · '3XL'(56px) · '4XL'(72px) · '5XL'(96px) · '6XL'(128px)

// Body
'XS'(12px) · 'S'(14px) · 'M'(16px) · 'L'(20px) · 'XL'(24px)

// Button
'small'(14px) · 'regular'(16px)

// Weight keys: 300 · 400 · 500
```

---

## Visual Quality Standards

<rules>
**Token conformance is the floor — not the ceiling.** Every component and feature must also satisfy:

- ≥ 2 distinct typography styles with clear visual hierarchy
- 1 dominant surface colour + ≤ 1 accent colour
- Spacing that varies (not uniform padding everywhere)
- All interactive states implemented: default, hover, focus (visible ring), active, disabled
- Verified in **both** `.zodiak-theme-light` and `.zodiak-theme-dark` — no hardcoded colours bleeding through
- No text is invisible against its background in either theme
- Touch targets ≥ 44 × 44 px on mobile (WCAG 2.5.5)
</rules>

---

## Common Pitfalls

<pitfalls>
- **Missing `box-sizing: border-box`** — there is no global reset; declare it explicitly on sized bordered elements
- **`--zodiak-text-inverse` on fixed dark surfaces** — becomes invisible in dark mode; use `--zodiak-text-always-white`
- **Local token aliases** — `--local-x: var(--zodiak-x)` silently breaks dark-mode overrides
- **Manual font properties** — always use the typography mixin; manually set sizes drift from the spec
- **ButtonRegular instead of a specialised button** — `ButtonClose`, `ButtonDownload`, `ButtonArrow` etc. exist for specific cases; using `ButtonRegular` for them is an anti-pattern
- **ButtonMenu with > 5 options** — renders `null` silently; use `ButtonInteractive` for longer lists
- **JSX element in `ButtonInteractive.icon`** — expects `ComponentType`, not `ReactNode`; pass the component class
- **GROUP A components inside `ZodiakLayout`** — `Hero`, `HeroTypographic`, `VideoBanner`, `TextBlockSection` manage their own full-width; wrapping them breaks layout
- **Missing `.js` extension in `index.ts` exports** — NodeNext module resolution requires explicit `.js` extensions
</pitfalls>

---

## Components Not Yet Ported to React

The following exist in iOS/Android and in the design spec but have **no React equivalent yet**. Do not generate code for them:

| Component | Interim approach |
|---|---|
| `Modal` | No React equivalent — discuss with team before implementing |
| `Chips` / `ChipGroup` | No React equivalent |
| `Notice` | Inline info block — not implemented |
| `Combobox` | Searchable dropdown — not implemented |
| `Dropdown` | Static select — not implemented |
| `Multiselect` | Multi-choice dropdown — not implemented |
| `Toast` | Transient feedback — not implemented |
