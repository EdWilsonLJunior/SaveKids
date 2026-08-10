---
description: "Sync the Zodiak DS skill references with the current codebase. Use after adding, modifying, or removing components or tokens in Shared/DesignSystem/. Updates references/components.md and references/tokens.md in the zodiak-ds skill."
agent: "agent"
tools: [read, edit, search]
---

Synchronize the Zodiak DS skill knowledge base with the current codebase.

## Scope
Scan ONLY `ZodiakiOS/Shared/DesignSystem/`.
DO NOT read `Features/` or `App/Catalog/` — those are not the source of truth.

## Step 1 — Inventory current DS components
List all `.swift` files recursively under `Shared/DesignSystem/Atoms/`, `Molecules/`, `Organisms/`, `Templates/`, `Utils/`.

For each file, extract:
- All `public` and `internal` `struct`, `class`, and `enum` type names
- Their `init` parameters (public API signature)
- Any important `enum` cases (variants, sizes, styles)

## Step 2 — Inventory current tokens
Read these files completely:
- `Shared/DesignSystem/Tokens/ZodiakColors.swift` — all static properties
- `Shared/DesignSystem/Tokens/ZodiakSpacing.swift` — all static properties + computed
- `Shared/DesignSystem/Tokens/ZodiakTypography.swift` — all static properties
- `Shared/DesignSystem/Tokens/ZodiakRadii.swift` — all static properties
- `Shared/DesignSystem/Tokens/ZodiakPrimitives.swift` — ramp names and shade levels

## Step 3 — Diff against current references
Read `.github/skills/ios-zodiak-ds/references/components.md` and `.github/skills/ios-zodiak-ds/references/tokens.md`.

Identify:
- **Added**: components/tokens in codebase but NOT in references
- **Modified**: signature or value changed between codebase and references
- **Removed**: components/tokens in references but NO LONGER in codebase

## Step 4 — Update references

### components.md
- Add new components in the correct layer section (Atoms / Molecules / Organisms / Templates / Utils)
- Update modified signatures
- Mark removed components as `<!-- DEPRECATED: removed in <date> -->`
- Update the "Last synced" date at the top

### tokens.md
- Add new tokens to the correct table
- Update changed values
- Remove deprecated tokens
- Update the "Last synced" date at the top

## Step 5 — Optional: Figma cross-check
If a `.env` file exists at the project root with a `FIGMA_TOKEN` entry, offer to cross-check component names against the Figma API. Wait for user confirmation before proceeding.

## Output
Report:
- N components added to references
- N components updated
- N components marked deprecated
- N tokens added
- N tokens updated
- Files modified: components.md, tokens.md
