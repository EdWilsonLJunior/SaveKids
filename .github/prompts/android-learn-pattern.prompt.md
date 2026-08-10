---
description: "Record a new pattern, decision, or anti-pattern into the appropriate knowledge base file. Use when you discover something that should always (or never) be done in this project."
argument-hint: "Describe the pattern (e.g. 'always use ZodiakInfoRow for key/value results in feature screens')"
agent: "agent"
tools: [read, edit]
---

Record the following pattern or decision: $input

## Step 1 — Classify the pattern

Determine which file is the right target:

| Pattern type | Target file |
|---|---|
| New DS component API / Compose usage | `.github/skills/android-zodiak-ds/references/<layer>/<file>.md` |
| New or corrected token value | `.github/skills/android-zodiak-ds/references/tokens.md` |
| Composition rule (do/don't compose X with Y) | `.github/skills/android-zodiak-ds/SKILL.md` → "Composition Rules" section |
| Anti-pattern (something that must never be done) | `.github/skills/android-zodiak-ds/SKILL.md` → "Anti-Patterns" section |
| Architectural decision (MVVM, DI, data flow) | `/memories/repo/zodiakandroid.md` |
| Localization convention | `.github/instructions/android-localization.instructions.md` |
| Testing convention | `.github/instructions/android-testing.instructions.md` |
| Broad project convention (not DS-specific) | `.github/copilot-instructions.md` |

## Step 2 — Read the target file
Read the target file to understand the existing format and find the right insertion point.

## Step 3 — Insert the pattern
Add the pattern in the same format and style as existing entries.

For SKILL.md anti-patterns, use:
```kotlin
// ❌ Description of what not to do
BadPattern(...)

// ✅ What to do instead
GoodPattern(...)
```

For `references/*.md`, follow the existing API documentation format:
```kotlin
ComponentName(
    param1: Type,
    param2: Type = default,
)
```

For `memories/repo/zodiakandroid.md`, use a short bullet under the most relevant section.

## Step 4 — Confirm
Report exactly what was added and where (file + section).
