#!/usr/bin/env python3
"""Reformat the Markdown files generated from Zodiak Supernova PDFs.

`markitdown` faithfully preserves PDF text layout, which leaves us with one
line per visual row, broken paragraphs, ligatures, and a navigation footer at
the bottom of every page. This script applies a *conservative* post-processing
pass tuned to that specific output.

Pipeline
========
1. Normalise whitespace and fix common Latin ligatures (``ﬁ ﬂ ﬃ ...``).
2. Strip the trailing Supernova breadcrumb (last line containing a
   ``[a-z][A-Z]`` concatenation, e.g. ``FoundationsColor``) plus the very
   small set of nav links immediately above it. The walk-back stops on the
   first non-nav line, so we never eat hex codes or numbers.
3. Promote the first non-empty line to a level-one heading (``# Title``).
4. Promote a curated set of section names to level-two headings (``## H``)
   when they appear as isolated single-line paragraphs.
5. Detect the page-level navigation cluster (consecutive ``## H2`` lines with
   no body in between) at the top of the file and replace it with a
   ``**Related sections:** ...`` line, keeping the last item as a real
   heading.
6. Merge prose paragraphs that were word-wrapped by the PDF (line ends
   without sentence punctuation and the next line starts with a lowercase
   letter or a known continuation word). Only triggered for clearly
   prose-shaped lines.
7. Wrap inline code-like tokens (hex colors, ``rgba(...)``, design-token
   names like ``spacing-xs``) in backticks when they appear inside prose
   paragraphs (never on isolated data lines).
8. Collapse repeated blank lines and ensure exactly one blank line around
   every heading.

Re-run any time after re-extracting the PDFs:

    python3 scripts/format_zodiak_pdfs.py
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent / "docs" / "zodiak-pdf"

# ---------------------------------------------------------------------------
# Constants & patterns
# ---------------------------------------------------------------------------

LIGATURES = {
    "\ufb00": "ff",
    "\ufb01": "fi",
    "\ufb02": "fl",
    "\ufb03": "ffi",
    "\ufb04": "ffl",
    "\ufb05": "ft",
    "\ufb06": "st",
}

# Curated set of Supernova section names that should become `## H2` when they
# appear isolated on their own line. Single-word labels like "Default",
# "Hover", "Primary", etc. are intentionally excluded — they're table cells.
SECTION_HEADINGS = frozenset({
    "Overview",
    "Specs",
    "Guidelines",
    "Usage",
    "States",
    "Sizes",
    "Size",
    "Style",
    "Color",
    "Colors",
    "Placement",
    "Behavior",
    "Behaviour",
    "Spacing",
    "Spacing scale",
    "Sizing",
    "Sizing scale",
    "Type scale",
    "Typeface",
    "In Figma",
    "In code",
    "Introduction",
    "Accessibility",
    "Primitives",
    "Primitive colors",
    "Semantic colors",
    "Brand colors",
    "Brand accent colors",
    "Accent colors",
    "Lite and heavy",
    "Light and dark theme",
    "Themes",
    "Capgemini shadow",
    "Anatomy",
    "Variants",
    "Properties",
    "Grid adjusted sizes",
    "Applying sizes in Figma",
    "Text layout",
})

CONTINUATION_PREFIXES = (
    "and ", "or ", "but ", "to ", "of ", "in ", "on ", "for ", "with ",
    "the ", "a ", "an ", "by ", "as ", "at ", "from ", "into ", "that ",
    "which ", "when ", "while ", "where ", "is ", "are ", "be ", "use ",
    "such ", "applied ", "automatically ", "primary ", "secondary ",
    "tertiary ", "button ", "buttons ", "components ", "shadows ",
    "tokens ", "token ", "group.",
)

SENTENCE_END = (".", "!", "?", ":", ";", ")", "]", "”", "’", "•", "—")

HEX_RGBA_RE = re.compile(r"(?<![\w/`])(#[0-9a-fA-F]{3,8}|rgba?\([^)]*\))(?![\w`])")
# Match design-token-shaped names: at least 2 hyphens AND at least 3 segments,
# OR contains a digit segment, OR uses a known design-system prefix.
TOKEN_RE = re.compile(r"(?<![\w/`])([a-z][a-z0-9]*(?:-[a-z0-9]+){2,4})(?![\w`])")
# English hyphenated compounds we never want to wrap as code.
COMMON_HYPHENATED = frozenset({
    "full-width", "fixed-width", "full-height", "fixed-height",
    "left-aligned", "right-aligned", "top-aligned", "bottom-aligned",
    "hover-state", "focus-state", "on-screen", "off-screen",
    "left-hand", "right-hand", "high-quality", "low-quality",
    "in-line", "out-of-the-box", "end-to-end", "step-by-step",
    "e-commerce", "co-branded", "on-brand", "off-brand",
    "long-form", "short-form", "real-time",
})

# Breadcrumb at the very end of a page: two title-cased phrases concatenated
# with no separator, e.g. "FoundationsColor", "Regular buttonWarning button".
BREADCRUMB_RE = re.compile(
    r"^[A-Z][a-z]+(?:\s[a-z]+)*[a-z][A-Z][a-z]+(?:\s[a-z]+)*$"
)
# Nav link: 1–3 plain title-case words, no digits/punctuation/hex.
NAV_LINK_RE = re.compile(r"^[A-Z][a-zA-Z]*(?:\s[a-zA-Z]+){0,2}$")
# Heuristic for "data cells" — never merged, never promoted, never wrapped.
DATA_CELL_RE = re.compile(
    r"^("
    r"#[0-9a-fA-F]{3,8}"
    r"|rgba?\([^)]*\)"
    r"|\d+(?:\.\d+)?(?:px|%|pt|em|rem)?"
    r"|[A-Z]{1,4}"
    r"|\d+X[A-Z]+"
    r")$"
)

# ---------------------------------------------------------------------------
# Stages
# ---------------------------------------------------------------------------


def fix_ligatures(text: str) -> str:
    for src, dst in LIGATURES.items():
        text = text.replace(src, dst)
    return text.replace("\u00a0", " ").replace("\u2028", "\n")


def is_breadcrumb(line: str) -> bool:
    line = line.strip()
    if not line or len(line) > 60:
        return False
    if not BREADCRUMB_RE.match(line):
        return False
    # Reject normal title phrases like "Default Hover".
    if re.search(r"\s[A-Z]", line):
        return False
    return True


def is_nav_link(line: str) -> bool:
    line = line.strip()
    if not line or len(line) > 30:
        return False
    return bool(NAV_LINK_RE.match(line))


def strip_footer(lines: list[str]) -> list[str]:
    end = len(lines)
    while end > 0 and not lines[end - 1].strip():
        end -= 1

    breadcrumb_idx = None
    seen_non_blank = 0
    for idx in range(end - 1, max(-1, end - 6), -1):
        if not lines[idx].strip():
            continue
        seen_non_blank += 1
        if is_breadcrumb(lines[idx]):
            breadcrumb_idx = idx
            break
        if seen_non_blank >= 3:
            break

    if breadcrumb_idx is None:
        return lines[:end]

    cut = breadcrumb_idx
    consumed = 0
    blanks = 0
    j = breadcrumb_idx - 1
    while j >= 0 and consumed < 6:
        s = lines[j].strip()
        if not s:
            blanks += 1
            if blanks > 1:
                break
            j -= 1
            continue
        if is_nav_link(s):
            cut = j
            consumed += 1
            blanks = 0
            j -= 1
            continue
        break

    return lines[:cut]


def is_data_cell(line: str) -> bool:
    return bool(DATA_CELL_RE.match(line.strip()))


def is_prose_line(line: str) -> bool:
    s = line.strip()
    if len(s) < 25:
        return False
    if s.startswith(("#", "-", "*", "|", ">", "`", "1.", "2.", "3.")):
        return False
    return True


def merge_wrapped_paragraphs(lines: list[str]) -> list[str]:
    """Merge a prose line with the *next non-blank* line when it looks like
    PDF word-wrap. We allow a single blank line between them — markitdown
    sometimes inserts blank rows between visual lines of the same paragraph.
    """
    out: list[str] = []
    i = 0
    n = len(lines)
    while i < n:
        cur = lines[i]
        cur_s = cur.strip()
        if (
            is_prose_line(cur)
            and not cur_s.endswith(SENTENCE_END)
        ):
            # Find next non-blank line within at most one blank gap.
            j = i + 1
            blanks = 0
            while j < n and not lines[j].strip():
                blanks += 1
                j += 1
                if blanks > 1:
                    break
            if j < n and blanks <= 1:
                nxt = lines[j]
                nxt_s = nxt.strip()
                if nxt_s and not nxt_s.startswith(("#", "-", "*", "|", ">", "`")):
                    first = nxt_s[0]
                    starts_lower = first.islower()
                    starts_continuation = any(
                        nxt_s.lower().startswith(p) for p in CONTINUATION_PREFIXES
                    )
                    if (starts_lower or starts_continuation) and not is_data_cell(nxt_s):
                        out.append(cur.rstrip() + " " + nxt_s)
                        i = j + 1
                        continue
        out.append(cur)
        i += 1
    return out


def promote_headings(lines: list[str]) -> list[str]:
    out: list[str] = []
    title_set = False
    n = len(lines)
    for idx, line in enumerate(lines):
        stripped = line.strip()
        if not title_set and stripped:
            out.append(stripped if stripped.startswith("#") else f"# {stripped}")
            title_set = True
            continue
        if stripped in SECTION_HEADINGS:
            prev_blank = idx == 0 or not lines[idx - 1].strip()
            next_blank = idx + 1 >= n or not lines[idx + 1].strip()
            if prev_blank and next_blank:
                out.append(f"## {stripped}")
                continue
        out.append(line.rstrip())
    return out


def collapse_heading_navigation(lines: list[str]) -> list[str]:
    out: list[str] = []
    i = 0
    n = len(lines)
    while i < n:
        line = lines[i]
        if line.startswith("## "):
            run: list[str] = []
            j = i
            while j < n:
                if lines[j].startswith("## "):
                    run.append(lines[j][3:].strip())
                    j += 1
                elif j < n and not lines[j].strip():
                    j += 1
                else:
                    break
            if len(run) >= 3:
                nav, last = run[:-1], run[-1]
                if out and out[-1].strip():
                    out.append("")
                out.append("**Related sections:** " + " · ".join(nav))
                out.append("")
                out.append(f"## {last}")
                out.append("")
                i = j
                continue
        out.append(line)
        i += 1
    return out


def collapse_blank_lines(lines: list[str]) -> list[str]:
    out: list[str] = []
    blank = 0
    for line in lines:
        if not line.strip():
            blank += 1
            if blank <= 1:
                out.append("")
        else:
            blank = 0
            out.append(line)
    while out and not out[0]:
        out.pop(0)
    while out and not out[-1]:
        out.pop()
    return out


def dedupe_adjacent_headings(lines: list[str]) -> list[str]:
    """Drop a heading that is immediately repeated (separated only by blanks).

    Supernova exports often duplicate a section title because it appears both
    as a page heading and as the first column header of the table below it.
    """
    out: list[str] = []
    i = 0
    n = len(lines)
    while i < n:
        line = lines[i]
        if line.startswith(("## ", "### ")):
            j = i + 1
            while j < n and not lines[j].strip():
                j += 1
            if j < n and lines[j] == line:
                # Skip this duplicate; the next pass will pick up the second.
                i += 1
                continue
        out.append(line)
        i += 1
    return out


def demote_bodyless_headings(lines: list[str]) -> list[str]:
    """Demote a `## H2` back to plain text if its first 3 non-blank body
    lines contain no prose — strong signal it is a table column header that
    happens to share a name with a real section.
    """
    out: list[str] = list(lines)
    n = len(out)
    for idx, line in enumerate(out):
        if not line.startswith("## "):
            continue
        prose_found = False
        seen = 0
        for k in range(idx + 1, n):
            nxt = out[k]
            if not nxt.strip():
                continue
            if nxt.startswith("#"):
                break
            seen += 1
            if is_prose_line(nxt):
                prose_found = True
                break
            if seen >= 3:
                break
        if not prose_found:
            out[idx] = line[3:]
    return out


def add_blank_around_headings(lines: list[str]) -> list[str]:
    out: list[str] = []
    for idx, line in enumerate(lines):
        if line.startswith("#"):
            if out and out[-1].strip():
                out.append("")
            out.append(line)
            if idx + 1 < len(lines) and lines[idx + 1].strip():
                out.append("")
        else:
            out.append(line)
    return out


def wrap_inline_code(lines: list[str]) -> list[str]:
    out: list[str] = []
    for line in lines:
        s = line.strip()
        if (
            not s
            or s.startswith(("#", "-", "*", "|", ">", "`"))
            or len(s) < 30
            or is_data_cell(s)
        ):
            out.append(line)
            continue
        new = HEX_RGBA_RE.sub(lambda m: f"`{m.group(1)}`", line)

        def _wrap_token(match: re.Match[str]) -> str:
            token = match.group(1)
            if token in COMMON_HYPHENATED:
                return token
            # Only wrap if it actually looks like a DS token: contains a digit
            # OR has a known DS prefix.
            ds_prefixes = (
                "spacing-", "sizing-", "radius-", "shadow-", "blur-",
                "color-", "action-", "surface-", "text-", "border-",
                "icon-", "button-", "tab-", "neutral-", "capgemini-",
                "primary-", "secondary-", "tertiary-",
            )
            if any(c.isdigit() for c in token) or token.startswith(ds_prefixes):
                return f"`{token}`"
            return token

        new = TOKEN_RE.sub(_wrap_token, new)
        out.append(new)
    return out


def normalize_inner_spaces(lines: list[str]) -> list[str]:
    out = []
    for line in lines:
        if line.startswith(("```", "    ")):
            out.append(line)
            continue
        out.append(re.sub(r" {2,}", " ", line))
    return out


# ---------------------------------------------------------------------------
# Driver
# ---------------------------------------------------------------------------


def reformat(text: str) -> str:
    text = fix_ligatures(text)
    lines = [ln.rstrip() for ln in text.splitlines()]

    lines = strip_footer(lines)
    lines = collapse_blank_lines(lines)
    lines = merge_wrapped_paragraphs(lines)
    # Second pass after collapsing blanks created new adjacencies.
    lines = collapse_blank_lines(lines)
    lines = merge_wrapped_paragraphs(lines)
    lines = normalize_inner_spaces(lines)
    lines = promote_headings(lines)
    lines = dedupe_adjacent_headings(lines)
    lines = demote_bodyless_headings(lines)
    lines = wrap_inline_code(lines)
    lines = add_blank_around_headings(lines)
    lines = collapse_blank_lines(lines)
    lines = collapse_heading_navigation(lines)
    lines = collapse_blank_lines(lines)
    return "\n".join(lines) + "\n"


def main() -> None:
    # Allow an optional --dir <path> argument to process a different folder.
    target = ROOT
    args = sys.argv[1:]
    if "--dir" in args:
        idx = args.index("--dir")
        if idx + 1 < len(args):
            target = Path(args[idx + 1]).expanduser().resolve()

    md_files = sorted(p for p in target.glob("*.md") if p.name != "README.md")
    print(f"Reformatting {len(md_files)} files in {target}")
    changed = 0
    for path in md_files:
        original = path.read_text(encoding="utf-8")
        updated = reformat(original)
        if updated != original:
            path.write_text(updated, encoding="utf-8")
            changed += 1
            print(f"  ✓ {path.name}")
        else:
            print(f"  · {path.name}")
    print(f"Done — {changed}/{len(md_files)} files modified.")


if __name__ == "__main__":
    main()
