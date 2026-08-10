#!/usr/bin/env python3
"""Lint de neutralidade: falha se sintaxe Swift/Kotlin aparecer em stories fora
das seções de plataforma.

Seções neutras: todas, EXCETO:
  - `## Boas práticas — iOS`
  - `## Boas práticas — Android`
  - `## Referências`

Uso: python3 scripts/lint-neutrality.py
Exit code 0 se limpo; 1 se houver vazamento.
"""
from __future__ import annotations
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TARGET_DIRS = ["02-atoms", "03-molecules", "04-organisms", "05-templates", "06-utils"]

PLATFORM_SECTIONS = {
    "boas práticas — ios",
    "boas práticas — android",
    "referências",
}

# H3 sub-sections that, when nested under a neutral H2, switch to platform mode.
PLATFORM_SUBSECTIONS = {
    "ios",
    "android",
    "swiftui",
    "compose",
    "kotlin / compose",
    "swift / swiftui",
}

# (regex, descrição)
SWIFT_PATTERNS = [
    (r"\bCGFloat\b", "CGFloat (use Length)"),
    (r"\(\) -> Void", "() -> Void (use Action)"),
    (r"\(\) -> View", "() -> View (use Slot)"),
    (r"\(\) -> some View", "() -> some View (use Slot)"),
    (r"@ViewBuilder", "@ViewBuilder (omitir — implícito em Slot)"),
    (r"@escaping", "@escaping (omitir — implícito em Action/Slot)"),
    (r"@State\b", "@State (linguagem-específica)"),
    (r"@Environment\b", "@Environment (linguagem-específica)"),
    (r"\bUIImage\b", "UIImage (use ImageSource)"),
    (r"\bUIColor\b", "UIColor (use Color)"),
    (r"(?<![A-Za-z0-9_])\.onLite\b", ".onLite dot-shorthand (use ZodiakSurface.onLite)"),
    (r"(?<![A-Za-z0-9_])\.onHeavy\b", ".onHeavy dot-shorthand (use ZodiakSurface.onHeavy)"),
    (r"(?<![A-Za-z0-9_])\.onPhoto\b", ".onPhoto dot-shorthand (use ZodiakSurface.onPhoto)"),
    (r"=\s*nil\b", "= nil (use = none)"),
    (r"\bSwiftUI\b", "menção a SwiftUI fora da seção iOS"),
]

KOTLIN_PATTERNS = [
    (r"@Composable\b", "@Composable (linguagem-específica)"),
    (r"\bMutableState\b", "MutableState (use Binding<T>)"),
    # Flag Modifier only when used as a Kotlin/Compose API (Modifier. or Modifier =)
    (r"\bModifier[.=]", "Modifier (linguagem-específica)"),
    (r"\bremember\s*\{", "remember { (linguagem-específica)"),
    # Flag Dp only when used as a type (followed by . or before identifier in type position)
    (r"(?<![A-Za-z0-9_])\d+\.dp\b", "valor literal em Dp (use token)"),
    (r":\s*Dp\b", "Dp como tipo (use Length)"),
]

HEADING_RE = re.compile(r"^(#{1,6})\s+(.*?)\s*$")


def lint_file(path: Path) -> list[tuple[int, str, str]]:
    """Returns list of (line_no, pattern_desc, line_excerpt)."""
    issues: list[tuple[int, str, str]] = []
    text = path.read_text(encoding="utf-8")
    current_h2 = ""
    in_platform_section = False
    in_platform_subsection = False
    in_code_fence = False
    for i, line in enumerate(text.split("\n"), start=1):
        if line.lstrip().startswith("```"):
            in_code_fence = not in_code_fence
            continue
        m = HEADING_RE.match(line)
        if m:
            level = len(m.group(1))
            title = m.group(2).strip().lower()
            if level == 2:
                current_h2 = title
                in_platform_section = title in PLATFORM_SECTIONS
                in_platform_subsection = False
                continue
            if level == 3:
                in_platform_subsection = title in PLATFORM_SUBSECTIONS
                continue
        if in_platform_section or in_platform_subsection or in_code_fence:
            continue
        for pattern, desc in SWIFT_PATTERNS + KOTLIN_PATTERNS:
            if re.search(pattern, line):
                issues.append((i, desc, line.strip()[:140]))
    return issues


def main() -> int:
    total_issues = 0
    for d in TARGET_DIRS:
        for path in sorted((ROOT / d).rglob("*.md")):
            issues = lint_file(path)
            if issues:
                rel = path.relative_to(ROOT)
                for ln, desc, excerpt in issues:
                    print(f"{rel}:{ln}: {desc}\n    > {excerpt}")
                    total_issues += 1
    if total_issues:
        print(f"\n❌ {total_issues} vazamento(s) de sintaxe específica fora das seções de plataforma.")
        return 1
    print("✅ Stories neutras — nenhum vazamento detectado.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
