---
applyTo: "ZodiakReact/**"
---

# Scripts & Commands Reference — ZodiakReact

All commands run from the **monorepo root** (`/path/to/Zodiak/`), not from inside `ZodiakReact/`.

---

## Primary Commands

| Command | When to run |
|---|---|
| `npm install` | After cloning or after changing dependencies |
| `npm run build` | Build `packages/react-scss` → `dist/` (ESM + UMD + types + CSS) |
| `npm run test` | Run all Vitest + vitest-axe tests for `packages/react-scss` |
| `npm run storybook` | Start Storybook dev server on `http://localhost:6006` |
| `npm run build-storybook` | Build static Storybook for deployment |

All commands are npm workspace proxies that target `packages/react-scss` automatically.

---

## VS Code Tasks

All primary commands are available as VS Code tasks. Use `Terminal → Run Task` or `⌘⇧P → Tasks: Run Task`:

| Task (not yet registered) | Equivalent command |
|---|---|
| `React: Build` | `npm run build` |
| `React: Test` | `npm run test` |
| `React: Storybook` | `npm run storybook` |

> Note: React tasks have not yet been registered in `.vscode/tasks.json`. Run the npm commands directly.

---

## Running from `ZodiakReact/` subfolder

If your terminal is inside `ZodiakReact/`, use the workspace script directly:

```bash
cd ZodiakReact
npm run build        # same as root-level "npm run build"
npm run test
npm run storybook
```

The `package.json` at root delegates to the workspace package via `-w @cg-groupit/zodiak-design-system`.

---

## Publishing

<rules>
- Publishing is triggered automatically by CI on a `v*` tag push.
- **Never publish manually.** Running `npm publish` locally will bypass the CI pipeline and may push an unsigned or incomplete build.
- See `ZodiakReact/README.md` for the full release workflow.
- The package publishes to GitHub Packages as `@cg-groupit/zodiak-design-system`.
</rules>

---

## Token Modification

<rules>
- Never edit `packages/react-scss/scss/tokens/` without explicit approval.
- Token changes affect the entire system and all consuming projects — they require a deliberate release cycle.
</rules>

---

## Do NOT Touch

<rules>
- `packages/react-tailwind/` — experimental Tailwind port; off-limits unless working on it specifically.
- `packages/tailwind-preset/` — shared Tailwind config; off-limits unless working on it specifically.
</rules>
