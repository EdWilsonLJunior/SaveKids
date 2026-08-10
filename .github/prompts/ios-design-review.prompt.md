---
description: "Review a SwiftUI screen for Zodiak token conformance AND visual quality (typography hierarchy, color anchoring, spacing variation, motion, dark mode safety). Use when a screen compiles but feels flat, generic, or lacks visual intent."
argument-hint: "File path of the screen to review (e.g. Features/12-Temperature/TemperatureScreen.swift). Leave empty for current editor file."
agent: "agent"
tools: [read, edit]
---

Perform a complete Zodiak design review of `$input` (or the current editor file).
The review has two tracks: **Conformance** (is the API correct?) and **Visual Quality** (is the design intentional?).

## Step 1 — Read the skill

Load `.github/skills/ios-zodiak-ds/SKILL.md` → sections "Zodiak Aesthetic Intent", "Design Thinking", "Anti-Patterns".
Load `.github/skills/ios-zodiak-ds/references/visual-quality.md`.

## Step 2 — Read the target file

Read the Screen `.swift` file in full. Also read the associated `ViewModel.swift` to understand `@Published` properties (result, error, loading states).

## Step 3 — Conformance audit

Check for violations in each category. For each violation, note: file + line, what is wrong, the correct fix.

### 3a. Token violations
- Hardcoded colors: `Color(red:)`, `Color(hex:)`, `Color.white`, `Color.black`, `Color.gray`, `.blue`, etc.
- Hardcoded spacing: `.padding(16)`, `.spacing(8)`, any numeric literal in padding/spacing
- Hardcoded radii: `.cornerRadius(12)`, `.cornerRadius(8)`, any numeric literal in corner radius
- Non-Zodiak blur: `.blur(radius: 30)`, raw `Color.black.opacity(0.4)` over images

### 3b. Component API violations
- `ZodiakTextStyle.bodySmall` (does not exist → use `.caption()`)
- `ZodiakAlert(message:severity:)` (wrong API → use `ZodiakAlert(title:variant:)`)
- `ZodiakSpacing.buttonHeightLarge` (wrong enum → use `ZodiakSizing.buttonHeightLarge`)
- `ZodiakTabs` with manual negative padding (use `edgeToEdgeContent:` slot instead)
- `NavigationStack` wrapping a feature screen (host provides the stack)
- `.navigationTitle` in gallery views (use `.zodiakPage(title:)`)

### 3c. Layout violations
- `ScrollView { VStack { } }` as screen root in `Features/` (use `ZodiakActivityTemplate`)
- `ScrollView + VStack + .background(ZodiakColors.background)` in Catalog (use `ZodiakGalleryShell`)
- `@Environment(\.horizontalSizeClass)` with manual padding calculation inside a feature screen

## Step 4 — Visual Quality audit

Apply the Design Thinking checklist and Anti-Slop Checklist from the skill.

### 4a. Typography hierarchy
- Count distinct `ZodiakTextStyle` values used → record the list
- Is the primary result/value using `.headline` or `.title1`? If not → flag
- Are metadata/labels using `.caption()`? If not → flag
- Is there size contrast of ≥ 3× between the largest and smallest text? If not → flag

### 4b. Color anchoring
- What is the dominant surface color? (should be `.background` or `.surface`)
- Is `ZodiakColors.brand` used? How many times? (should be ≤ 1 element)
- Are `surfacePositive`/`surfaceNegative` used only for state feedback? If used decoratively → flag

### 4c. Spatial variation
- List the spacing values used in `VStack(spacing:)` and `.padding(...)` calls
- Are they all the same value? → flag as "uniform spacing, no hierarchy"
- Does the result/hero area have more breathing room than the input area? If not → flag

### 4d. Motion
- Is there a `result` property? Is it wrapped with `.transition` + `.animation`? If not → flag
- Is there an `errorMessage` property? Does it animate in/out? If not → flag
- Does `reset()` clear result with a transition? If not → flag (nice-to-have)

### 4e. Dark mode safety
- Any foreground/background combination that could break: verify both light and dark appearances
- Review `docs/dark-mode-audit.md` — is this file listed as a known regression?

### 4f. Localization
- Any hardcoded user-facing string literals in the view?

## Step 5 — Produce the report

Output a structured review with two sections:

### 🔴 Conformance Issues (must fix)
For each: `File:Line — Issue description → Correct fix`

### 🟡 Visual Quality Gaps (should improve)
For each dimension (Typography / Color / Spacing / Motion / Depth):
- Current state: what is happening now
- Recommended improvement: specific token/API change with code snippet

### 🟢 What's working well
Brief notes on aspects that are already correct.

## Step 6 — Apply fixes (if authorized)

If the user confirms or if using agent mode with edit permission:
1. Fix all **Conformance Issues** first — these are regressions.
2. Apply **Visual Quality** improvements in this order: Typography → Color → Spacing → Motion → Depth.
3. Run SwiftLint after edits: `swiftlint lint --fix --config .swiftlint.yml`
4. Report: N conformance fixes applied, N visual improvements applied, lint clean.
