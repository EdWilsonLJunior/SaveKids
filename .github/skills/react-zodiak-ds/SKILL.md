---
name: react-zodiak-ds
description: >-
  Zodiak Design System — React + TypeScript + SCSS component library (@cg-groupit/zodiak-design-system).
  Use when creating or modifying React components, choosing between components, applying design tokens,
  writing component SCSS, writing tests, setting up Storybook stories, reviewing component quality,
  or building features in ZodiakReact. Provides the complete component API reference, token quick
  reference, decision trees, anti-patterns, and hard rules. Self-contained — all rules are embedded.
  Trigger phrases: which component, what component, which button, zodiak, design system, DS component,
  new component, create component, ButtonMenu, ButtonInteractive, ButtonRegular, ButtonIcon, TextBlock,
  ZodiakSection, ZodiakLayout, Hero, HeroTypographic, TextBlockSection, Notification, Tooltip,
  token, scss token, --zodiak, typography mixin, forwardRef, vitest-axe, storybook story, AllOptions,
  Playground, anti-pattern, wrong way, correct way, audit component, GROUP A, GROUP B, layout structure,
  dark mode, color token, spacing token, accessibility, WCAG, component anatomy, index.ts extension.
argument-hint: "What are you building or choosing? (e.g. 'a button that opens a dropdown' or 'choosing between Notification and Tooltip')"
---

# Zodiak Design System — React

Primary package: `ZodiakReact/packages/react-scss` · Published as `@cg-groupit/zodiak-design-system`

## Source of Truth

| Path | Status |
|---|---|
| `ZodiakReact/packages/react-scss/src/components/` | ✅ Canonical — 26 components |
| `ZodiakReact/packages/react-scss/docs/` | ✅ Reference docs — conventions, decision trees, anti-patterns |
| `ZodiakReact/packages/react-tailwind/` | ❌ Experimental — do not reference as a pattern |

Reference docs: `packages/react-scss/CLAUDE.md` (dev rules) · `packages/react-scss/docs/conventions.md` (canonical)

---

## Component Catalogue (26 components)

### Buttons (12)
`ButtonArrow` · `ButtonClose` · `ButtonDownload` · `ButtonIcon` · `ButtonInteractive` · `ButtonMedia` · `ButtonMenu` · `ButtonRegular` · `ButtonShare` · `ButtonShowMore` · `ButtonSystem` · `ButtonVideoPreview`

### Content & Typography (6)
`Typography` · `Eyebrow` · `Preamble` · `HeadlineSection` · `TextBlock` (3 variants) · `DividerLine`

### Media (4)
`Hero` · `HeroTypographic` · `Video` · `VideoBanner`

### Forms (5)
`Input` · `Checkbox` · `Radio` · `Switch` · `SliderCounter`

### Navigation & Interaction (4)
`Link` · `Tabs` · `Accordion` · `Tooltip`

### Identity & Feedback (3)
`Author` · `Avatar` · `Notification`

### Layout (2)
`ZodiakLayout` · `ZodiakSection`

### Infrastructure (2)
`ThemeProvider` · `Icon` (+ 250+ individual icon SVGs)

---

## Component Decision Trees

### 1. Buttons — choose one

```
Icon-only button?
├── Close/dismiss action → ButtonClose
├── Directional animated arrow → ButtonArrow
└── Any other icon-only → ButtonIcon (requires ariaLabel)

Video control (play/pause or mute)?
└── ButtonVideoPreview  (variant="play" or variant="volume")

Opens a dropdown?
├── Static 2–5 options (links or simple actions) → ButtonMenu
│     ⚠️ Max 5 — renders null silently beyond that
└── File downloads / clipboard copy / share actions → ButtonInteractive
      ⚠️ icon prop expects ComponentType, not ReactNode

Single file download link → ButtonDownload
Share content → ButtonShare
Load more / paginate → ButtonShowMore
System/admin small button → ButtonSystem
Media playback in a card → ButtonMedia
Everything else → ButtonRegular
```

**Quick reference:**

| Component | Trigger | Key constraint |
|---|---|---|
| `ButtonClose` | Close / dismiss | Always icon-only; × icon |
| `ButtonArrow` | Directional navigation | Animated; icon-only |
| `ButtonIcon` | Generic icon-only | Requires `ariaLabel` |
| `ButtonVideoPreview` | Play/Pause or Mute | `variant="play"` or `"volume"` |
| `ButtonMenu` | Static dropdown | 2–5 `options`; link + action items |
| `ButtonInteractive` | Action popover | `icon` is `ComponentType`, not JSX |
| `ButtonDownload` | Single file download | Renders as `<a download>` |
| `ButtonShare` | Share action | Opens share UI |
| `ButtonShowMore` | Load more | Internal loading state |
| `ButtonSystem` | Admin / system UI | Smaller visual weight |
| `ButtonMedia` | In-card media playback | Play video, toggle mute |
| `ButtonRegular` | Everything else | `hierarchy` prop: `primary` \| `secondary` \| `tertiary` |

> **React vs iOS/Android:** `ButtonRegular` uses a `hierarchy` prop. Do **not** create `ButtonPrimary`, `ButtonSecondary`, or `ButtonTertiary` — those are iOS/Android architecture, not React.

**Minimal examples:**

```tsx
// ButtonRegular with right icon
<ButtonRegular
  label="Learn more"
  hierarchy="primary"
  icon={<Icon Component={ArrowRightIcon} size="medium" decorative />}
  iconPosition="right"
/>

// ButtonMenu (static dropdown)
<ButtonMenu
  label="Options"
  options={[
    { label: 'Edit',   value: 'edit' },
    { label: 'View',   url: '/view' },
    { label: 'Delete', value: 'delete' },
  ]}
  onSelect={(value) => console.log(value)}
/>

// ButtonInteractive (file downloads — note: component class, not JSX)
<ButtonInteractive
  label="Download"
  icon={DownloadIcon}
  items={[
    { label: 'PDF version',  icon: FileIcon, url: '/file.pdf',  isDownload: true },
    { label: 'Word version', icon: FileIcon, url: '/file.docx', isDownload: true },
  ]}
/>

// ButtonVideoPreview
<ButtonVideoPreview
  variant="play"
  isPlaying={playing}
  progress={elapsed / duration}
  onClick={() => setPlaying(p => !p)}
/>
```

---

### 2. Hero / Banner

```
Video background or autoplay?
├── Yes → Hero  (use videoSrc prop)
└── No → Large typographic shapes / brand assets as primary visual?
    ├── Yes → HeroTypographic
    └── No → Wide banner (not full-height) with embedded video?
        ├── Yes → VideoBanner
        └── No → Hero  (photographic / image background, use imageSrc)
```

---

### 3. Form Inputs

```
Free text entry (name, email, search, comment)?
└── Input  (multiline prop for textarea)

Theme colour mode control (light ↔ dark)?
└── ThemeToggle  (Sun/Moon icons — fixed slot behaviour)

Immediate binary on/off (no form submit)?
└── Switch  (Check/Close icons)

One option from a fixed list?
└── Radio  (wrap in RadioGroup)

Multiple options from a fixed list?
└── Checkbox
```

> **ThemeToggle ≠ Switch.** `ThemeToggle` controls page theme class. `Switch` is a generic boolean toggle. Never substitute.

---

### 4. Layout — GROUP A vs GROUP B

**GROUP A — self-managing. Never wrap inside `ZodiakLayout` or `ZodiakSection`:**
`Hero` · `HeroTypographic` · `VideoBanner` · `TextBlockSection`

**GROUP B — all other components. Must live inside `ZodiakLayout` (inside `ZodiakSection`):**

```tsx
// ✅ Correct
<Hero imageSrc="..." />
<TextBlockSection heading="..." items={[...]} />
<ZodiakSection background="neutral">
  <ZodiakLayout>
    <Notification type="success" message="Saved" />
    <Author name="Ana Lima" />
  </ZodiakLayout>
</ZodiakSection>

// ❌ Wrong — Hero inside ZodiakLayout
<ZodiakSection>
  <ZodiakLayout>
    <Hero />  {/* ← breaks; Hero manages its own full-width */}
  </ZodiakLayout>
</ZodiakSection>
```

`ZodiakSection` — vertical rhythm: padding-top/bottom, background colour  
`ZodiakLayout` — horizontal grid: max-width, column gutters

---

### 5. TextBlock

```
Full page section (ZodiakSection background + theme + alignment)?
└── TextBlockSection

Grid of multiple text blocks?
└── TextBlockGroup  (items array, max 10)

Single standalone block?
└── TextBlockBase
    ├── Two-column? → column={2}
    └── Sub-sections? → sections prop
```

---

### 6. HeadlineSection

```
Tabbed content below the headline?
├── Yes → HeadlineSectionTabs
└── No → HeadlineSection
```

---

### 7. Notification vs Tooltip

```
Status/feedback message (success, error, info)?
└── Notification  (persists until dismissed)

Supplementary hover/focus hint?
└── Tooltip  (disappears on blur/mouseout)
```

---

## Token Quick Reference

### Spacing (`--zodiak-space-primitives-*`)

| Token | Size | Common use |
|---|---|---|
| `3xs` | 4 px | Badge/chip internal padding |
| `2xs` | 8 px | Tight gap between elements |
| `xs` | 16 px | Standard padding, button icon gap |
| `s` | 24 px | Section internal spacing |
| `m` | 32 px | Standard component padding |
| `l` | 40 px | Large section gaps |
| `xl` | 48 px | XL spacing |
| `2xl` | 56 px | — |
| `3xl` | 64 px | — |
| `4xl` | 72 px | Display area spacing |
| `5xl` | 96 px | Hero-level spacing |
| `6xl` | 128 px | Large viewport gaps |
| `7xl` | 152 px | — |
| `8xl` | 176 px | Extreme layout gaps |

Full usage: `var(--zodiak-space-primitives-xs)` etc.

### Colour Token Categories

> **onLite vs onHeavy:** Many action tokens have two surface variants.  
> Use `*-onlite` on light surfaces, `*-onheavy` on dark/heavy surfaces.

```scss
// Text
--zodiak-text-primary                        // main body text
--zodiak-text-secondary                      // muted/secondary text
--zodiak-text-inverse                        // ⚠️ ADAPTIVE — white light / near-black dark
--zodiak-text-always-white                   // always white — use on fixed dark surfaces
--zodiak-text-always-black                   // always dark
--zodiak-text-link                           // link colour
--zodiak-text-disabled                       // disabled state

// Backgrounds
--zodiak-page-background
--zodiak-surface-cloud-lite                  // card / panel fill
--zodiak-surface-fog-lite                    // subtle alternate background
--zodiak-surface-ink-heavy                   // dark / navy surface

// Borders
--zodiak-border-primary
--zodiak-border-secondary

// Actions — pick the right surface variant
--zodiak-action-primary-default-onlite       // CTA on light surface
--zodiak-action-primary-hover-onlite
--zodiak-action-primary-pressed-onlite
--zodiak-action-primary-default-onheavy      // CTA on dark/heavy surface
--zodiak-action-disabled

// Brand
--zodiak-brand-blue                          // Capgemini blue (#0058ab)
--zodiak-brand-orange
```

### Typography Mixin

```scss
@use "../../../scss/mixins/typography" as zt;

// Heading (adjust path depth to match component directory depth)
@include zt.type-style-heading-zodiak('XS', 500);   // 16px, weight 500
@include zt.type-style-heading-zodiak('2XL', 400);  // 48px, weight 400

// Body
@include zt.type-style-body-zodiak('M', 400);       // 16px, weight 400
@include zt.type-style-body-zodiak('S', 300);       // 14px, weight 300

// Button
@include zt.type-style-button-zodiak('regular');    // 16px, always weight 300
@include zt.type-style-button-zodiak('small');      // 14px

// Heading size keys (sm → lg):
// '2XS'(14px) '  XS'(16px) '  S'(18px) '  M'(24px) '  L'(32px) ' XL'(40px)
// '2XL'(48px) ' 3XL'(56px) ' 4XL'(72px) '5XL'(96px) '6XL'(128px)

// Body size keys: 'XS'(12px) 'S'(14px) 'M'(16px) 'L'(20px) 'XL'(24px)
// Weight keys: 300 · 400 · 500
```

**Never** set `font-size`, `font-weight`, `line-height`, `letter-spacing`, or `font-family` manually.

---

## Component Anatomy — All 6 Files Are Mandatory

```
src/components/ComponentName/
  ComponentName.tsx          ← component + all types
  component-name.scss        ← styles (kebab-case filename)
  ComponentName.test.tsx     ← unit + axe accessibility tests
  ComponentName.stories.tsx  ← Storybook (AllOptions + Playground)
  CHANGELOG.md               ← per-component change history
  index.ts                   ← re-exports only, .js extensions
```

Grouped components (e.g. buttons) live in a subdirectory:
`src/components/Buttons/ButtonRegular/`

---

## Key TypeScript Patterns

### Props — always extend HTMLAttributes

```tsx
type MyComponentProps = React.HTMLAttributes<HTMLDivElement> & {
  variant?: 'primary' | 'secondary';  // union strings, never enums
  size?: 'small' | 'medium';
};

// Use Omit when prop name collides with native HTML attribute
type VideoProps = Omit<React.HTMLAttributes<HTMLDivElement>, 'title'> & {
  title: string;
};
```

### forwardRef — always named inner function

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

### Discriminated union

```tsx
type WithLabel    = { type: 'label';    label: string };
type WithChildren = { type: 'children'; children: React.ReactNode };
type Props = React.HTMLAttributes<HTMLDivElement> & (WithLabel | WithChildren);
```

### CSS class naming

```
Root:     zodiak-[component]                     → zodiak-author
Child:    zodiak-[component]-[element]           → zodiak-author-meta
Modifier: zodiak-[component]-[prop]-[value]      → zodiak-author-size-large
State:    is-open  is-active  disabled           → on root element
```

Modifiers go on the **root element**. State classes use bare words (`is-open`, not `zodiak-author-open`).

### index.ts exports — `.js` extension required (NodeNext resolution)

```ts
export { MyComponent } from './MyComponent.js';
export type { MyComponentProps } from './MyComponent.js';
```

---

## Key SCSS Patterns

```scss
@use "../../../scss/mixins/typography" as zt;

.zodiak-my-component {
  box-sizing: border-box;                        // required — no global reset
  color: var(--zodiak-text-primary);             // always reference tokens directly
  padding: var(--zodiak-space-primitives-m);
  gap: var(--zodiak-space-primitives-s);

  @include zt.type-style-body-zodiak('M', 400);  // never manual font values

  &:hover { background: var(--zodiak-surface-cloud-lite); }
  &.disabled { color: var(--zodiak-text-disabled); cursor: not-allowed; }
  &.is-open { ... }
}
```

---

## Tests — 4 Describe Blocks Required

```tsx
import { axe } from 'vitest-axe';
import 'vitest-axe/extend-expect';

describe('MyComponent', () => {
  describe('rendering',     () => { /* element present, default props */ });
  describe('behaviour',     () => { /* events, conditional rendering */ });
  describe('class names',   () => { /* correct classes per prop value */ });
  describe('accessibility', () => {
    it('has no accessibility violations', async () => {
      const { container } = render(<MyComponent label="Test" />);
      expect(await axe(container)).toHaveNoViolations();
    });
    // Run axe on each significant variant (disabled, error, etc.)
  });
});
```

---

## Stories — 2 Exports Required

```tsx
// AllOptions — static grid of every variant, size, and state. No args.
export const AllOptions = () => (
  <div style={{ display: 'flex', flexWrap: 'wrap', gap: 16, padding: 24 }}>
    <MyComponent variant="primary" label="Primary" />
    <MyComponent variant="secondary" label="Secondary" />
    <MyComponent disabled label="Disabled" />
  </div>
);
AllOptions.storyName = 'All options';

// Playground — single instance driven by Storybook controls.
export const Playground: Story = {
  render: (args) => (
    <div style={{ padding: 48 }}><MyComponent {...args} /></div>
  ),
};
```

---

## Icon Usage

Icons must always be wrapped with `<Icon>`. Size must match the component size.

```tsx
// small component → size="small" (16 px)
// medium or large component → size="medium" (24 px)

<Icon Component={ArrowRightIcon} size="medium" decorative />
// or, if icon carries meaning:
<Icon Component={StarIcon} size="small" iconName="Favourite" />
```

`ButtonInteractive` and its items expect a **component class**, not JSX:

```tsx
// ❌ Wrong
<ButtonInteractive icon={<DownloadIcon />} items={[{ icon: <FileIcon /> }]} />

// ✅ Correct
<ButtonInteractive icon={DownloadIcon} items={[{ icon: FileIcon }]} />
```

---

## Anti-Patterns

### SCSS

| ❌ Anti-pattern | ✅ Fix |
|---|---|
| `--local-x: var(--zodiak-x)` — local alias | Reference `--zodiak-*` tokens directly |
| Manual `font-size`, `line-height` etc. | Use `@include zt.type-style-*` mixin |
| Hardcoded `#hex` or `rgba()` colours | Use semantic `--zodiak-*` tokens |
| `--zodiak-text-inverse` on fixed dark surface | Use `--zodiak-text-always-white` |
| Missing `box-sizing: border-box` | Declare on every sized bordered element |

### Icons

| ❌ Anti-pattern | ✅ Fix |
|---|---|
| `<ArrowRightIcon width={24} />` — raw SVG | Wrap with `<Icon Component={...} size="medium" decorative />` |
| Medium icon in small button | Match size: small button → `size="small"` |
| `icon={<DownloadIcon />}` on ButtonInteractive | Pass component class: `icon={DownloadIcon}` |
| `<Icon Component={...} />` with no decorative/label | Add `decorative` or `iconName` |

### Buttons

| ❌ Anti-pattern | ✅ Fix |
|---|---|
| `ButtonRegular` for close/dismiss | Use `ButtonClose` |
| `ButtonRegular` for single file download | Use `ButtonDownload` |
| `ButtonMenu` with > 5 options | Use `ButtonInteractive` or reduce options |
| `onSelect` on link items in `ButtonMenu` | `onSelect` never fires for items with `url` |

### Layout

| ❌ Anti-pattern | ✅ Fix |
|---|---|
| `Hero` / `HeroTypographic` inside `ZodiakLayout` | Move GROUP A components outside the layout |
| GROUP B components without `ZodiakSection > ZodiakLayout` | Wrap in `<ZodiakSection><ZodiakLayout>...` |

### TypeScript / Structure

| ❌ Anti-pattern | ✅ Fix |
|---|---|
| `import { X } from './X'` (no extension) | `import { X } from './X.js'` |
| Anonymous `forwardRef((props, ref) => ...)` | Named: `forwardRef(function MyComponent(...) {})` |
| `enum` for prop values | String union: `variant?: 'primary' \| 'secondary'` |

---

## Components NOT Yet Ported to React

Do not generate usage code for these — they do not exist in `packages/react-scss`:

| Component | Notes |
|---|---|
| `Modal` | Full overlay modal — no React equivalent yet |
| `Chips` / `ChipGroup` | Filter chip UI — no React equivalent yet |
| `Notice` | Inline informational block — not implemented |
| `Combobox` | Searchable dropdown — not in React |
| `Dropdown` | Static select dropdown — not in React |
| `Multiselect` | Multi-choice dropdown — not in React |
| `Toast` | Transient feedback message — not in React |

---

## Hard Rules (non-negotiable)

1. **Never use Tailwind** in `packages/react-scss` — SCSS tokens and mixins only
2. **Never create local CSS custom property aliases** — always reference `--zodiak-*` tokens directly
3. **Never edit `scss/tokens/`** without explicit approval
4. **Every component must pass `vitest-axe`** accessibility checks (WCAG 2.1 AA)
5. **All local imports use `.js` extensions** (NodeNext module resolution)
6. **All 6 component files are mandatory** — no component ships without `.tsx`, `.scss`, `.test.tsx`, `.stories.tsx`, `CHANGELOG.md`, `index.ts`
7. **Never publish manually** — publishing is triggered by CI on a `v*` tag push

---

## DS Consumption Rules

Always prefer the highest-level DS component before reaching for raw tokens. Tokens are for layout gaps and truly custom surfaces — not for recreating components that already exist in the catalogue.

Full reference: `ZodiakReact/packages/react-scss/docs/conventions.md`
