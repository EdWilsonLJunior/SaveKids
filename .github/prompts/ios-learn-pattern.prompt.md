---
description: "Record a new pattern, decision, or anti-pattern into the appropriate knowledge base file. Use when you discover something that should always (or never) be done in this project."
argument-hint: "Describe the pattern (e.g. 'always use ZodiakInfoRow for spec tables in gallery views')"
agent: "agent"
tools: [read, edit]
---

Record the following pattern or decision: $input

## Step 1 — Classify the pattern

Determine which file is the right target:

| Pattern type | Target file |
|---|---|
| New DS component API / usage | `.github/skills/ios-zodiak-ds/references/components.md` |
| New or corrected token value | `.github/skills/ios-zodiak-ds/references/tokens.md` |
| Composition rule (do/don't compose X with Y) | `.github/skills/ios-zodiak-ds/SKILL.md` → "Composition Rules" section |
| Anti-pattern (something that must never be done) | `.github/skills/ios-zodiak-ds/SKILL.md` → "Anti-Patterns" section |
| Architectural decision (MVVM, DI, data flow) | `/memories/repo/mrswiftuiapp.md` |
| Localization convention | `.github/instructions/ios-localization.instructions.md` |
| Broad project convention (not DS-specific) | `.github/copilot-instructions.md` |

## Step 2 — Read the target file
Read the target file to understand the existing format and find the right insertion point.

## Step 3 — Insert the pattern
Add the pattern in the same format and style as existing entries.

For SKILL.md anti-patterns, use:
```swift
// ❌ Description of what not to do
BadPattern(...)

// ✅ What to do instead
GoodPattern(...)
```

For components.md, follow the existing API documentation format:
```swift
ComponentName(param1: Type, param2: Type = default)
```

For memories/repo/mrswiftuiapp.md, use a short bullet under the most relevant section.

## Step 4 — Confirm
Report exactly what was added and where (file + section).
