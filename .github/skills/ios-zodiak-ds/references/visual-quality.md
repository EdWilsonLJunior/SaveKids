# Zodiak Visual Quality — Isolated Guidance

This file provides targeted prompting patterns for individual design dimensions in Zodiak/SwiftUI.
Use when you want to improve one aspect without changing the full implementation.

---

## Typography — Isolated

Apply when: the screen exists but all text looks the same size/weight.

**Diagnostic:**
- Count distinct `ZodiakTextStyle` values in the screen → if only 1 or 2, hierarchy is flat
- Identify the "hero value" (the answer the user came for) → it should use `.headline` or `.title1`
- Identify metadata/labels → they should use `.caption()`

**Upgrade patterns:**

```swift
// Before: flat hierarchy
ZodiakText("Result", style: .body())
ZodiakText("42.5 °F", style: .body())
ZodiakText("Converted from Celsius", style: .body())

// After: intentional scale contrast
ZodiakText("Result", style: .caption(color: .secondary))     // label — small, muted
ZodiakText("42.5 °F", style: .headline)                      // hero value — 32pt dominant
ZodiakText("Converted from Celsius", style: .caption())      // context — small, normal weight
```

**Quick wins:**
- `.headline` → the primary numerical result, key statistic, or action confirmation
- `.title1` → section title on detail or summary screens (e.g., "Your Score")
- `.title2` → card titles in list screens
- `.title3` → subsection separators within a card
- `.body(bold: true)` → emphasis within a list without changing size
- `.caption(color: .secondary)` → timestamp, unit label, spec key

<never>
- Use `.headline` on more than 1 element per screen (it stops being "headline")
- Use `.body()` for the primary result of a calculation — it deserves `.headline`
</never>

---

## Color — Isolated

Apply when: the screen has no visual anchor or feels like a gray box.

**Diagnostic:**
- Identify how many distinct background colors are in use → more than 2 = noise
- Identify if `ZodiakColors.brand` appears at all → if it doesn't, there's no Capgemini identity

**Upgrade patterns:**

```swift
// Pattern 1: Brand strip on input screen header
// Use brand as the only colored element — everything else neutral
ZodiakText(title, style: .title1)
    .padding(ZodiakSpacing.s16)
    .background(ZodiakColors.brand)
    .foregroundColor(ZodiakColors.textInverse)  // always light on brand bg

// Pattern 2: surfaceSmoke for section depth
VStack(spacing: 0) {
    gallerySectionCard(title: "Input") { ... }          // on .background
    gallerySectionCard(title: "Result") { ... }         // card lifts to .surface
}
// ZodiakGalleryShell's background is .background; cards sit at .surface = visual depth

// Pattern 3: Status color for result feedback
// surfacePositive / surfaceNegative used ONLY for state communication
ZodiakBadge(label: "Correct!", variant: .positive)     // not for decoration
ZodiakAlert(title: errorMsg, variant: .error)          // not for headers
```

**Token intent map:**
| Token | Correct use | Never use for |
|---|---|---|
| `brand` | Single visual anchor, brand identity | Card backgrounds, repeating decoration |
| `actionPrimary` | Primary CTA button fill | Text color, card tint |
| `surfaceSmoke` | Alternate section background, divider-like separation | Error states |
| `surfacePositive` | Success state feedback | General content backgrounds |
| `surfaceNegative` | Error state feedback | Warning states |
| `textSecondary` | Labels, hints, captions | Body text of primary content |
| `textInverse` | Text on dark/brand backgrounds | Text on light surfaces |

---

## Motion — Isolated

Apply when: the screen is static — no feedback that state has changed.

**Diagnostic:**
- Is there a `result` property that appears/disappears? → needs entrance transition
- Is there an `errorMessage` property? → needs subtle attention animation
- Does `reset()` clear values? → a quick fade-out on result would feel clean

**Minimal motion kit (add these and nothing else):**

```swift
// 1. Result entrance — wrap in if/let with transition
if let result = viewModel.result {
    VStack(spacing: ZodiakSpacing.s8) {
        ZodiakText(verbatim: "\(result)", style: .headline)
        ZodiakText("catalog.result.label", style: .caption())
    }
    .transition(.opacity.combined(with: .scale(scale: 0.94, anchor: .center)))
    .animation(.spring(response: 0.45, dampingFraction: 0.68), value: result)
}

// 2. Error appearance — simple opacity
if let error = viewModel.errorMessage {
    ZodiakAlert(title: String(localized: error), variant: .error)
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.22), value: viewModel.errorMessage)
}

// 3. Button loading state (if async)
ZodiakButton(title: "feature.action.submit", style: .primary) { viewModel.submit() }
    .animation(.easeInOut(duration: 0.15), value: viewModel.isLoading)
```

**Timing reference:**
| Moment | Duration | Curve |
|---|---|---|
| Result appears | 0.40–0.50s | `.spring(response:0.45, dampingFraction:0.68)` |
| Error appears | 0.20–0.25s | `.easeInOut` |
| Reset / clear | 0.15–0.20s | `.easeIn` (things leave faster than they arrive) |
| Button press feedback | 0.10–0.15s | `.easeOut` |

---

## Spatial Composition — Isolated

Apply when: the screen feels cramped or floaty — spacing doesn't communicate structure.

**Diagnostic:**
- Is the same `padding` or `spacing` value used everywhere? → no hierarchy
- Does the result area feel like it's on the same level as the input? → needs more distance

**Upgrade patterns:**

```swift
// Pattern 1: Hero result with intentional breathing room
ZodiakActivityTemplate(title: "...") {
    VStack(spacing: ZodiakSpacing.s40) {                   // 40pt — input ↔ result separation
        inputSection
            .padding(.horizontal, ZodiakSpacing.s16)     // 16pt — standard horizontal
        
        Divider()
            .padding(.horizontal, ZodiakSpacing.s16)
        
        resultSection
            .padding(.top, ZodiakSpacing.s24)             // 24pt — extra lift for result
    }
    .padding(.top, ZodiakSpacing.s32)                     // 32pt — from template header
}

// Pattern 2: Dense list with consistent rhythm
VStack(spacing: 0) {
    ForEach(items) { item in
        ZodiakInfoRow(item.title, value: item.value)
        if item.id != items.last?.id {
            Divider().padding(.horizontal, ZodiakSpacing.s16)
        }
    }
}
.padding(.vertical, ZodiakSpacing.s8)             // 8pt — tight list padding
```

**Spacing decision tree:**
```
Is this a hero/focused screen? (1-2 actions)
  → Use ZodiakSpacing.s40 (40) or xl (48) between sections
  → Use ZodiakSpacing.s32 (32) at top padding
  → Use ZodiakSpacing.s24 (24) between related items

Is this a dense/list screen? (many rows of data)
  → Use ZodiakSpacing.s8 (8) between list rows
  → Use ZodiakSpacing.s16 (16) for section internal padding
  → Use ZodiakSpacing.s24 (24) between sections
```

---

## Depth — Isolated

Apply when: everything is on one visual plane — no foreground/background relationship.

**Upgrade patterns:**

```swift
// Pattern 1: Layer surfaces (no images needed)
// .background is the page floor
// .surface is the card ceiling
// gallerySectionCard automatically lifts to .surface — exploit this intentionally
ZodiakGalleryShell {
    gallerySectionCard(title: "Primary Action") {     // .surface — raised
        ZodiakButton(...)
    }
    gallerySectionCard(title: "Details") {            // .surface — raised
        ZodiakInfoRow(...)
    }
}
// The .background visible between cards creates visual "floor" — depth without blur

// Pattern 2: ZodiakTheme shadow for interactive cards
// When using ZodiakCardVariants or custom card containers:
.shadow(
    color: ZodiakTheme.shadow.color,
    radius: ZodiakTheme.shadow.radius,
    x: ZodiakTheme.shadow.x,
    y: ZodiakTheme.shadow.y
)

// Pattern 3: Blur for photo-backed hero sections
// Only valid on photographic images — not solid color backgrounds
ZStack {
    Image("feature-header")
        .resizable()
        .scaledToFill()
        .overlay(ZodiakBlur.pageOverlay)              // step 1: darken + tint
    
    VStack {
        ZodiakText("Title", style: .headline)
        ZodiakText("Subtitle", style: .body(color: .inverse))
    }
    .zodiakBlurBackground()                           // step 2: frosted container
}
```

**Depth checklist:**
- [ ] Is the page background (`ZodiakColors.background`) visible between surface-colored cards? If yes → depth exists naturally
- [ ] Are interactive elements on `.surface` and non-interactive on `.background`? If yes → affordance hierarchy is correct
- [ ] If a photographic image is used → is the 2-step ZodiakBlur pattern applied? If yes → photo depth is correct
- [ ] No hardcoded shadow values — use `ZodiakTheme.shadow` instead

---

## Composable Patterns

Combine dimensions for common screen archetypes:

### Archetype 1: Input → Result screen
```
Typography: caption label + headline result + caption unit
Color:       .background page + .surface card for result + brand on submit button
Spacing:     ZodiakSpacing.s40 between input and result
Motion:      .spring result entrance + .easeInOut error entrance
Depth:       result card on .surface, input on .background
```

### Archetype 2: List / Gallery screen
```
Typography: title2 for section headers + body for row labels + caption for values
Color:       .background page + .surface section cards
Spacing:     ZodiakSpacing.s8 between rows + ZodiakSpacing.s24 between sections
Motion:      no mandatory animation (static list OK)
Depth:       section cards lift to .surface; dividers within cards stay flat
```

### Archetype 3: Quiz / Game screen
```
Typography: title1 question + body options + caption feedback
Color:       surfacePositive/Negative for answer feedback + brand for score
Spacing:     ZodiakSpacing.s32 between question and options
Motion:      .spring on answer reveal + .easeInOut on feedback badge
Depth:       question card on .surface + options flat on .background
```
