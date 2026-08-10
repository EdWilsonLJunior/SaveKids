---
description: "Review a Compose screen for Zodiak token conformance AND visual quality (typography hierarchy, color anchoring, spacing variation, motion, dark mode safety). Use when a screen compiles but feels flat, generic, or lacks visual intent."
argument-hint: "File path of the screen to review (e.g. features/feature-grades/src/.../GradesScreen.kt). Leave empty for current editor file."
agent: "agent"
tools: [read, edit]
---

Perform a complete Zodiak design review of `$input` (or the current editor file).
The review has two tracks: **Conformance** (is the API correct?) and **Visual Quality** (is the design intentional?).

## Step 1 — Read the skill

Load `.github/skills/android-zodiak-ds/SKILL.md` → sections "Design Thinking", "Anti-Patterns".
Load `.github/skills/android-zodiak-ds/references/visual-quality.md`.

## Step 2 — Read the target file

Read the Screen `.kt` file in full. Also read the associated `ViewModel.kt` to understand `UiState` properties (result, error, loading states).

## Step 3 — Conformance audit

Check for violations in each category. For each violation, note: file + approximate line, what is wrong, the correct fix.

### 3a. Token violations
- Hardcoded colors: `Color(0xFF...)`, `Color.White`, `Color.Black`, `Color.Gray`, `Color.Blue`, etc.
- Hardcoded spacing: `.padding(16)`, `.spacedBy(8)`, any numeric literal in padding/spacing NOT on the 4dp grid
- Hardcoded corner radius: `.clip(RoundedCornerShape(12.dp))`, any numeric in corner shapes

### 3b. Component API violations
- Raw `Text` with hardcoded `fontSize`/`fontWeight` in a feature screen (use DS text Atoms)
- `ZodiakAlert` used conditionally without a boolean show-flag in `UiState` (dialog must be controlled)
- `ZodiakBadge` used decoratively (correct variant only for semantic state)
- `Modifier.fillMaxWidth()` hardcoded inside an Atom Composable (blocks reuse)
- Any DS component called with wrong parameter names

### 3c. Layout violations
- Raw `Column` or `LazyColumn` as screen root (must be `Scaffold`)
- String literals hardcoded in Composable (must be `stringResource(R.string.*)`)
- Strings resolved in ViewModel (must be resolved in Composable layer)

### 3d. Localization violations
- Any hardcoded user-facing string in the view

## Step 4 — Visual Quality audit

Apply the Design Thinking checklist from the skill.

### 4a. Typography hierarchy
- List all DS text Atoms used (`ZodiakHeadline`, `ZodiakTitle`, `ZodiakBody`, `ZodiakLabel`, `ZodiakCaption`)
- Is the primary result/value using `ZodiakHeadline`? If not → flag
- Are metadata/labels using `ZodiakCaption` or `ZodiakLabel`? If not → flag
- Is there at least 2 distinct text styles on the screen? If not → flag as flat hierarchy

### 4b. Color anchoring
- What is the dominant background? (should be `colorScheme.background` or `colorScheme.surfaceVariant`)
- Is `colorScheme.primary` or `colorScheme.tertiary` used for at least one visual anchor? If not → flag
- Are `errorContainer`/`tertiaryContainer` used ONLY for state feedback? If decorative → flag

### 4c. Spatial variation
- List the spacing values used in `Arrangement.spacedBy(...)` and `Modifier.padding(...)`
- Are they all the same value? → flag as "uniform spacing, no hierarchy"
- Does the result/hero area have more breathing room than the input area? If not → flag

### 4d. Motion
- Is there a `result` in `UiState`? Is it wrapped with `AnimatedVisibility`? If not → flag
- Is there an `error` in `UiState`? Does it animate in/out? If not → flag
- Does `reset()` clear result with a transition? If not → flag (nice-to-have)

### 4e. Dark mode safety
- Any `Color(0xFF...)` that could be invisible or low-contrast in dark mode?
- Verify each `colorScheme.*` usage is semantically correct (e.g., `onSurface` on `surface`, not on `background`)

## Step 5 — Produce the report

Output a structured review:

### 🔴 Conformance Issues (must fix)
For each: `~Line X — Issue → Correct fix`

### 🟡 Visual Quality Issues (should improve)
For each: issue + specific code pattern to apply from `visual-quality.md`

### 🟢 What's Working
Brief list of patterns used correctly.

## Step 6 — Apply fixes (if authorized)
If the user confirms, apply all 🔴 fixes. For 🟡 issues, ask which ones to apply first.
