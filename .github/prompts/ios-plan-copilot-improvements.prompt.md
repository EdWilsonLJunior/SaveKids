---
description: "Generate a structured Copilot customization improvement plan for this project. Audits the current state of .github/ customizations, the Design System, and the codebase, then produces a prioritized plan of prompts, skills, agents, and hooks to create or update."
name: "Plan Copilot Improvements"
agent: "agent"
tools: [read, search]
---

Generate a structured Copilot improvement plan for this project.

## Step 1 — Audit current customizations

Read and inventory everything under `.github/`:
- `copilot-instructions.md` — what global rules exist?
- `instructions/*.instructions.md` — which globs? what do they enforce?
- `prompts/*.prompt.md` — which prompts exist? what do they do?
- `skills/*/SKILL.md` — which skills exist? are their references up to date?
- `agents/*.agent.md` — which agents exist? what tools do they restrict?
- `hooks/*.json` — which hooks are configured?
- `scripts/` — which scripts back the hooks?

For each file found, note: **what it does** and **what gap or weakness it has**.

## Step 2 — Audit the Design System source of truth

Scan `ZodiakiOS/Shared/DesignSystem/` (the ONLY canonical source):
- List all component folders by layer (Atoms, Molecules, Organisms, Templates, Utils, Tokens)
- Count total components per layer
- Check if any components in `Shared/DesignSystem/` are NOT yet documented in `.github/skills/ios-zodiak-ds/references/components.md`
- Check if any tokens in `Shared/DesignSystem/Tokens/` are NOT yet documented in `.github/skills/ios-zodiak-ds/references/tokens.md`

Do NOT scan `Features/` or `App/Catalog/` — those are not the source of truth.

## Step 3 — Audit the feature inventory

List all folders under `ZodiakiOS/Features/` to determine:
- How many features exist?
- What is the next available feature number?
- Are there any features that deviate from the standard `Screen + ViewModel + Constants` structure?

## Step 4 — Identify gaps and opportunities

Based on Steps 1–3, identify:

### Missing prompts
- Workflows that are done manually and could be automated as `/prompt-name`
- Common patterns that lack a structured template

### Skill staleness
- Components or tokens in code that are missing from `references/components.md` or `references/tokens.md`
- Anti-patterns that were discovered in code reviews but not yet recorded in `SKILL.md`

### Agent coverage
- Multi-step workflows that still require manual coordination
- Agent procedures that could be tightened or extended

### Hook gaps
- Events that happen manually but could trigger automatic reminders or validation

### Self-improvement loop health
- Is `/sync-zodiak-ds` keeping references current?
- Is `/learn-pattern` being used to capture decisions?
- Is `memories/repo/` being updated with architectural discoveries?

## Step 5 — Produce the improvement plan

Output a structured plan with this format:

---

### Current State
Brief summary of what's already in place and working well.

### Gaps Found
List each gap with:
- **What**: description
- **Impact**: why it matters (high / medium / low)
- **Evidence**: where in the codebase the gap was found

### Proposed Improvements

For each improvement, specify:

| # | Type | File to create/update | Description | Priority |
|---|---|---|---|---|
| 1 | Prompt | `.github/prompts/name.prompt.md` | What it does | Alta |
| 2 | Skill update | `.github/skills/ios-zodiak-ds/references/components.md` | What to add | Alta |
| 3 | Agent | `.github/agents/name.agent.md` | What it automates | Média |
| 4 | Hook | `.github/hooks/name.json` | When it fires | Baixa |

### Sync Recommendations
- List any `Shared/DesignSystem/` components that need to be added to `references/components.md`
- List any tokens that need to be added to `references/tokens.md`
- Recommend running `/sync-zodiak-ds` if the diff is large

### Quick Wins (implement first)
Highlight the 2–3 highest-impact items that can be implemented immediately.

---

## Boundaries and constraints for this project

Keep these in mind when identifying gaps:

- **Source of truth**: `Shared/DesignSystem/` only. `Features/` = usage examples. `App/Catalog/` = being refined via future phase.
- **Never reference Features/ or App/Catalog/ as DS patterns** — this is a known anti-pattern.
- **Localization**: all user-facing strings via `String(localized:)`, keys in `Localizable.xcstrings`, both `en` and `pt-BR`.
- **SwiftLint**: `.swiftlint.yml` at root — Kodeco/Google/Airbnb rules. 0 violations required.
- **MVVM**: `final class + ObservableObject + @Published`. No logic in Views.
- **Feature structure**: `Features/NN-Name/NameScreen.swift`, `NameViewModel.swift`, `NameConstants.swift`. Complex features may add `Components/` subfolder.
