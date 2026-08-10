# Documentation

Centralized project documentation.

## Sections

- Keyboard constraint fix docs: [docs/keyboard/index.md](keyboard/index.md)
- Dark mode audit: [docs/dark-mode-audit.md](dark-mode-audit.md)
- Zodiak DS fidelity matrix (PDF ↔ iOS): [docs/zodiak-ds-fidelity.md](zodiak-ds-fidelity.md)
- Accessibility audit (WCAG 2.1 AA): [docs/accessibility-audit.md](accessibility-audit.md)
- iPad / adaptive UI audit: [docs/ipad-adaptivity-audit.md](ipad-adaptivity-audit.md)
- Design System gaps backlog: [docs/design-system-gaps.md](design-system-gaps.md)

## Audit scripts

- `scripts/audit_dark_mode.py` — re-runs hardcoded-color check, emits text or `--json`.
- `scripts/extract_zodiak_pdfs.sh` — extracts the 48 Zodiak PDFs to `docs/zodiak-pdf/_extracted/` for diffable text comparison.

## Keyboard Documents

- [keyboard-constraint-fix.md](keyboard/keyboard-constraint-fix.md)
- [keyboard-constraint-fix-implementation.md](keyboard/keyboard-constraint-fix-implementation.md)
