---
description: "Generate a structured Copilot customization improvement plan for ZodiakAndroid. Audits the current state of .github/ customizations, the Design System, and the codebase, then produces a prioritized plan of prompts, skills, agents, and instructions to create or update."
name: "Plan Copilot Improvements"
agent: "agent"
tools: [read, search]
---

Generate a structured Copilot improvement plan for ZodiakAndroid.

## Step 1 — Audit current customizations

Read and inventory everything under `.github/`:
- `copilot-instructions.md` — what global rules exist?
- `instructions/*.instructions.md` — which globs? what do they enforce?
- `prompts/*.prompt.md` — which prompts exist? what do they do?
- `skills/*/SKILL.md` — which skills exist? are their references up to date?
- `agents/*.agent.md` — which agents exist? what tools do they restrict?

For each file found, note: **what it does** and **what gap or weakness it has**.

## Step 2 — Audit the Design System source of truth

Scan `design-system/src/main/kotlin/com/zodiak/android/design_system/` (the ONLY canonical source):
- List all component files by layer (atoms/, molecules/, organisms/, theme/)
- Count total components per layer
- Check if any component in `design-system/` is NOT yet documented in `.github/skills/android-zodiak-ds/references/`
- Check if any token in `theme/Color.kt` or `theme/Typography.kt` is NOT documented in `references/tokens.md`
- Check if any component is documented as "⏳ not yet ported" but has actually been added to `design-system/`

Do NOT scan `features/` — that is not the source of truth.

## Step 3 — Audit the feature inventory

List all folders under `features/` to determine:
- How many feature modules exist?
- Are there any features that deviate from the standard `ViewModel + Screen + Navigation + Test` structure?
- Are there features with hardcoded strings not yet migrated to `strings.xml`?

## Step 4 — Identify gaps and opportunities

Based on Steps 1–3, identify:

### Missing prompts
- Workflows done manually that could become `/prompt-name`
- Common patterns that lack a structured template (e.g., Paparazzi tests, adaptive layouts)

### Skill staleness
- Components in `design-system/` that are missing from skill references
- Anti-patterns discovered in features that are not yet in `SKILL.md`
- ⏳ components that have now been ported and need their reference updated

### Agent coverage
- Multi-step workflows still requiring manual coordination
- Agent procedures that could be tightened

### Missing instructions
- Any new conventions in the codebase not yet captured in `.github/instructions/`

### Self-improvement loop health
- Is `/learn-pattern` being used to capture new decisions?
- Is `memories/repo/` being updated with architectural discoveries?
- Are ⏳ markers being updated as components get ported?

## Step 5 — Produce the improvement plan

Output a structured plan:

---

### Current State
Brief summary of what's already in place and working well.

### Gaps Found
For each gap:
- **What**: description
- **Impact**: high / medium / low
- **Evidence**: where in the codebase the gap was found

### Proposed Improvements
Ordered by impact:

| Priority | Type | Action | Effort |
|---|---|---|---|
| 1 | Prompt | Create `add-paparazzi-test.prompt.md` | Low |
| … | … | … | … |

### Suggested Next Step
The single highest-impact action to take right now.
