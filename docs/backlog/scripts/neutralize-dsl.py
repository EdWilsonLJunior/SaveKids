#!/usr/bin/env python3
"""Neutraliza sintaxe Swift/Kotlin nas stories fora das seções de plataforma.

Aplica substituições em todo `## ...` que NÃO seja:
  - `## Boas práticas — iOS`
  - `## Boas práticas — Android`
  - `## Referências`

Roda do diretório docs/backlog/.
"""
from __future__ import annotations
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TARGET_DIRS = ["02-atoms", "03-molecules", "04-organisms", "05-templates", "06-utils"]

# Section headers that should KEEP platform-native syntax untouched.
PLATFORM_SECTIONS = {
    "boas práticas — ios",
    "boas práticas — android",
    "referências",
}

# Ordered list of (regex, replacement) applied to neutral sections only.
# Use Python regex; flags inline.
SUBSTITUTIONS: list[tuple[str, str]] = [
    # Closures / actions
    (r"\(\(\) -> Void\)\?", "Action?"),
    (r"\(\) -> Void", "Action"),
    (r"\(\(\) -> some View\)\?", "Slot?"),
    (r"\(\) -> some View", "Slot"),
    (r"\(\(\) -> View\)\?", "Slot?"),
    (r"\(\) -> View", "Slot"),
    (r"@ViewBuilder\s+", ""),
    (r"@escaping\s+", ""),
    # Numeric / dimension types
    (r"\bCGFloat\b", "Length"),
    # Dot-shorthand for surface enum (Swift-only convention)
    (r"(?<![A-Za-z0-9_])\.onLite\b", "ZodiakSurface.onLite"),
    (r"(?<![A-Za-z0-9_])\.onHeavy\b", "ZodiakSurface.onHeavy"),
    (r"(?<![A-Za-z0-9_])\.onPhoto\b", "ZodiakSurface.onPhoto"),
    # `= nil` default → neutral `= none`
    (r"=\s*nil\b", "= none"),
]


HEADING_RE = re.compile(r"^(#{1,6})\s+(.*?)\s*$")


def normalize_heading(text: str) -> str:
    return text.strip().lower()


def neutralize_file(path: Path) -> tuple[int, int]:
    """Returns (replacements_count, sections_touched)."""
    original = path.read_text(encoding="utf-8")
    lines = original.split("\n")
    out: list[str] = []
    # Track current ## section (H2); H3+ inherit parent H2's neutrality status.
    current_h2 = ""
    in_platform_section = False
    in_code_fence = False
    replacements = 0
    for line in lines:
        # Toggle fenced code blocks (don't touch their content).
        if line.lstrip().startswith("```"):
            in_code_fence = not in_code_fence
            out.append(line)
            continue
        m = HEADING_RE.match(line)
        if m and len(m.group(1)) == 2:
            current_h2 = normalize_heading(m.group(2))
            in_platform_section = current_h2 in PLATFORM_SECTIONS
            out.append(line)
            continue
        if in_platform_section or in_code_fence:
            out.append(line)
            continue
        new_line = line
        for pattern, repl in SUBSTITUTIONS:
            new_line, n = re.subn(pattern, repl, new_line)
            replacements += n
        out.append(new_line)
    if replacements:
        path.write_text("\n".join(out), encoding="utf-8")
    return replacements, 0


def main() -> int:
    total_files = 0
    total_repls = 0
    touched_files = 0
    for d in TARGET_DIRS:
        for path in sorted((ROOT / d).rglob("*.md")):
            total_files += 1
            n, _ = neutralize_file(path)
            if n:
                touched_files += 1
                total_repls += n
                print(f"  {path.relative_to(ROOT)}: {n} substituições")
    print(f"\n{touched_files}/{total_files} arquivos modificados — {total_repls} substituições totais")
    return 0


if __name__ == "__main__":
    sys.exit(main())
