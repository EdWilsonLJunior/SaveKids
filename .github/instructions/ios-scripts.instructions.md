---
applyTo: "ZodiakiOS/scripts/**"
---

# Scripts Reference — ZodiakiOS

Scripts live in `/scripts/`. Do NOT run deprecated scripts — they may corrupt the localization catalog.

---

## Active Scripts

| Script | When to run | Command |
|---|---|---|
| `fill_missing_translations.py` | After adding new keys to `Localizable.xcstrings` without pt-BR translations | `python3 scripts/fill_missing_translations.py` |
| `localize_catalog_v2.py` | After editing catalog gallery views to apply localization wrappers | `python3 scripts/localize_catalog_v2.py` |
| `import-visual-assets.sh` | After adding SVG flags, logos, or icons to `visual-assets/` | `./scripts/import-visual-assets.sh` |
| `extract_icons_from_ts.py` | When receiving TypeScript icon files from the Zodiak team (Kamila) | `python3 scripts/extract_icons_from_ts.py <ts-dir> [--force] [--dry-run]` |

All three are available as VS Code tasks — use `Terminal → Run Task` or `Cmd+Shift+P → Tasks: Run Task`.

> **Icon pipeline:** When Kamila shares TypeScript files, run `extract_icons_from_ts.py` first,
> then `import-visual-assets.sh`. The VS Code task `Assets: Extract Icons from TypeScript` does both steps automatically. Alternatively: `make icons TS_DIR=~/path/to/ts-files`.

---

## Deprecated Scripts (do NOT run)

<never>

These completed their one-time migration jobs and must not be run again:

| Script | Why deprecated |
|---|---|
| `migrate_localization.py` | Phase 1 migration — natural language keys → dot notation. Done. |
| `migrate_localization_phase2.py` | Phase 2 migration — completed. |
| `migrate_localization_phase3.py` | Phase 3 migration — completed. |
| `localize_catalog.py` | Replaced by `localize_catalog_v2.py`. Do not use v1. |
| `generate_xcstrings.py` | One-time conversion from legacy `.strings` → `Localizable.xcstrings`. Done. |
| `extract_catalog_strings.py` | Was used during the migration phase to extract strings. No longer needed. |

</never>

---

## Rules

<rules>
- Always prefer the VS Code tasks over running scripts manually
- After running `fill_missing_translations.py`, review the output — it fills with placeholder text that must be replaced with real translations
- `import-visual-assets.sh` is idempotent — safe to re-run after adding new assets
- Never modify deprecated scripts — if a new migration is needed, create a new numbered phase file
</rules>
