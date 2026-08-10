#!/usr/bin/env python3
"""Dark Mode Audit — ZodiakiOS.

Generates a deterministic report of "no hardcoded colors" rule violations
across ZodiakiOS Swift sources. Excludes design-system token files
(`Shared/DesignSystem/Tokens/**`) which are the source of truth.

Usage:
    python3 scripts/audit_dark_mode.py [--json] [--strict]

Exit codes:
    0  — no violations outside of allowed pressed-feedback overlays
    1  — violations found
    2  — usage error
"""

import argparse
import json
import re
import sys
from dataclasses import asdict, dataclass, field
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
APP_DIR = ROOT / "ZodiakiOS"
TOKENS_DIR = APP_DIR / "Shared" / "DesignSystem" / "Tokens"

# Allowed pressed-feedback overlays — documented in dark-mode-audit.md (Section B).
ALLOWED_OVERLAYS = {
    "Shared/DesignSystem/Atoms/Button/ZodiakIconButton.swift",
}

# Pattern → severity / category.
PATTERNS = [
    ("legacy_appcolors",    re.compile(r"\bAppColors\."),                "P0"),
    ("legacy_apptheme",     re.compile(r"\bAppTheme\."),                 "P0"),
    ("color_black_literal", re.compile(r"\bColor\.black\b"),             "P1"),
    ("color_white_literal", re.compile(r"\bColor\.white\b"),             "P1"),
    ("fg_white_literal",    re.compile(r"\.foregroundColor\(\.white\)"), "P0"),
    ("fg_black_literal",    re.compile(r"\.foregroundColor\(\.black\)"), "P0"),
    ("color_hex_literal",   re.compile(r"Color\(hex:"),                  "P1"),
    ("color_rgb_literal",   re.compile(r"Color\(red:"),                  "P1"),
    ("shadow_black_literal", re.compile(r"\.shadow\(\s*color:\s*Color\.black"), "P0"),
    ("ios_semantic_color",  re.compile(r"\bColor\.(?:primary|secondary)\b"), "P2"),
]


@dataclass
class Violation:
    """Single violation occurrence."""

    rule: str
    severity: str
    file: str
    line: int
    snippet: str


@dataclass
class Report:
    """Aggregated audit report."""

    total: int = 0
    by_rule: dict = field(default_factory=dict)
    violations: list = field(default_factory=list)


def is_excluded(rel_path: str) -> bool:
    """Return True if path is part of token sources (allowed)."""
    return rel_path.startswith("Shared/DesignSystem/Tokens/")


def is_allowed_overlay(rel_path: str, rule: str) -> bool:
    """Pressed-feedback overlays are intentional in IconButton."""
    if rule not in {"color_black_literal", "color_white_literal"}:
        return False
    return rel_path in ALLOWED_OVERLAYS


def scan_file(path: Path) -> list:
    """Scan a single .swift file and return violations."""
    rel = str(path.relative_to(APP_DIR))
    if is_excluded(rel):
        return []
    out = []
    try:
        text = path.read_text(encoding="utf-8")
    except (OSError, UnicodeDecodeError):
        return []
    for lineno, line in enumerate(text.splitlines(), start=1):
        if line.lstrip().startswith("//"):
            continue
        for rule, pattern, severity in PATTERNS:
            if pattern.search(line):
                if is_allowed_overlay(rel, rule):
                    continue
                out.append(
                    Violation(
                        rule=rule,
                        severity=severity,
                        file=rel,
                        line=lineno,
                        snippet=line.strip(),
                    ),
                )
    return out


def collect_report() -> Report:
    """Walk ZodiakiOS/ and aggregate violations."""
    report = Report()
    for swift_file in APP_DIR.rglob("*.swift"):
        for v in scan_file(swift_file):
            report.violations.append(v)
            report.by_rule[v.rule] = report.by_rule.get(v.rule, 0) + 1
            report.total += 1
    return report


def print_text(report: Report) -> None:
    """Pretty print report as Markdown-ish text."""
    print("# Dark Mode Audit — Auto-generated")
    print(f"\nTotal violations: **{report.total}**\n")
    if not report.total:
        print("✅ No violations found outside of allowed pressed-feedback overlays.")
        return
    print("## By rule")
    for rule, count in sorted(report.by_rule.items()):
        print(f"- `{rule}`: {count}")
    print("\n## Violations\n")
    for v in report.violations:
        print(f"- [{v.severity}] {v.file}:{v.line} ({v.rule}) → `{v.snippet}`")


def main() -> int:
    """CLI entrypoint."""
    parser = argparse.ArgumentParser(description="Dark Mode Audit")
    parser.add_argument("--json", action="store_true", help="emit JSON instead of text")
    parser.add_argument(
        "--strict",
        action="store_true",
        help="exit non-zero on any violation (including P2)",
    )
    args = parser.parse_args()

    if not APP_DIR.exists():
        print(f"error: {APP_DIR} not found", file=sys.stderr)
        return 2

    report = collect_report()

    if args.json:
        payload = {
            "total": report.total,
            "by_rule": report.by_rule,
            "violations": [asdict(v) for v in report.violations],
        }
        print(json.dumps(payload, indent=2, ensure_ascii=False))
    else:
        print_text(report)

    if args.strict and report.total > 0:
        return 1
    blocking = [v for v in report.violations if v.severity in {"P0", "P1"}]
    return 1 if blocking else 0


if __name__ == "__main__":
    sys.exit(main())
