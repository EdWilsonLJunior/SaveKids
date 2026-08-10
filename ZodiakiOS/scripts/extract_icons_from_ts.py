#!/usr/bin/env python3
"""
extract_icons_from_ts.py — Zodiak DS icon pipeline
Converts TypeScript icon components from the Zodiak React library into SVG files
ready to be imported into Assets.xcassets via import-visual-assets.sh.

Usage:
    python3 scripts/extract_icons_from_ts.py <ts-directory> [options]

Options:
    --output DIR   Output directory for SVGs (default: visual-assets/icons/)
    --force        Overwrite existing SVG files
    --dry-run      Preview what would be generated without writing files

Component naming convention (Zodiak React):
    AddPlusIcon → zodiak-icon-add-plus.svg
    AIBrainIcon → zodiak-icon-ai-brain.svg

Pipeline:
    1. Run this script with the directory Kamila shared
    2. Run: ./scripts/import-visual-assets.sh
    3. Build Xcode — icons appear in ZodiakIconView automatically
"""

import argparse
import re
import sys
from pathlib import Path


# ---------------------------------------------------------------------------
# Name derivation: PascalCase component name → kebab-case icon name
# ---------------------------------------------------------------------------

def pascal_to_kebab(name: str) -> str:
    """Convert PascalCase to kebab-case, handling consecutive uppercase correctly.

    Examples:
        AddPlusIcon → add-plus-icon
        AIBrainIcon → ai-brain-icon
        OpenAIChatGPTIcon → open-ai-chat-gpt-icon
    """
    # Insert hyphen before a capital letter that follows a lowercase letter or digit
    step1 = re.sub(r"([a-z0-9])([A-Z])", r"\1-\2", name)
    # Insert hyphen before a capital letter that is followed by a lowercase letter
    # and preceded by another capital (e.g. "AIBrain" → "AI-Brain")
    step2 = re.sub(r"([A-Z]+)([A-Z][a-z])", r"\1-\2", step1)
    return step2.lower()


def component_name_to_asset_name(component_name: str) -> str:
    """Convert e.g. 'AddPlusIcon' → 'zodiak-icon-add-plus'."""
    # Strip trailing 'Icon' suffix (case-sensitive)
    base = re.sub(r"Icon$", "", component_name)
    return "zodiak-icon-" + pascal_to_kebab(base)


# ---------------------------------------------------------------------------
# JSX → SVG attribute conversion
# ---------------------------------------------------------------------------

CAMEL_TO_KEBAB_ATTRS = {
    "strokeLinecap":    "stroke-linecap",
    "strokeLinejoin":   "stroke-linejoin",
    "strokeWidth":      "stroke-width",
    "strokeMiterlimit": "stroke-miterlimit",
    "fillRule":         "fill-rule",
    "clipRule":         "clip-rule",
    "clipPath":         "clip-path",
    "fillOpacity":      "fill-opacity",
    "strokeOpacity":    "stroke-opacity",
}


def convert_jsx_attrs(svg_block: str) -> str:
    """Replace JSX camelCase attributes with SVG kebab-case equivalents."""
    result = svg_block
    for camel, kebab in CAMEL_TO_KEBAB_ATTRS.items():
        result = result.replace(camel + "=", kebab + "=")
    return result


def resolve_jsx_props(svg_block: str) -> str:
    """Resolve dynamic JSX prop references to static SVG values.

    Rules applied:
    - stroke={color}      → stroke="currentColor"
    - fill={color}        → fill="currentColor"
    - {strokeWidth}       → "1"  (default from IconProps)
    - width={width}       → removed  (no fixed size in asset)
    - height={height}     → removed  (no fixed size in asset)
    - {...props}          → removed
    - className={...}     → removed
    - {...otherProps}     → removed
    """
    result = svg_block

    # stroke/fill referencing {color} prop
    result = re.sub(r'stroke=\{color\}', 'stroke="currentColor"', result)
    result = re.sub(r'fill=\{color\}', 'fill="currentColor"', result)

    # strokeWidth prop reference — use the spec default (1)
    result = re.sub(r'stroke-width=\{strokeWidth\}', 'stroke-width="1"', result)
    result = re.sub(r'strokeWidth=\{strokeWidth\}', 'stroke-width="1"', result)

    # Remove width/height dynamic props
    result = re.sub(r'\s+width=\{width\}', '', result)
    result = re.sub(r'\s+height=\{height\}', '', result)

    # Remove spread props
    result = re.sub(r'\s+\{\.\.\.(props|otherProps|rest)\}', '', result)

    # Remove className
    result = re.sub(r'\s+className=\{[^}]+\}', '', result)

    return result


def self_close_empty_elements(svg_block: str) -> str:
    """Convert <g></g> → <g/> and similar trivially empty elements."""
    return re.sub(r"<(\w+)([^>]*)>\s*</\1>", r"<\1\2/>", svg_block)


def extract_svg_from_jsx(jsx_content: str) -> str | None:
    """Extract and clean the SVG block from a JSX/TSX icon component.

    Returns a clean SVG string, or None if no SVG block is found.
    """
    # Find the outermost <svg ...>...</svg> block
    match = re.search(r"(<svg\b[^>]*>.*?</svg>)", jsx_content, re.DOTALL)
    if not match:
        return None

    svg = match.group(1)

    # Resolve dynamic props before attribute conversion
    svg = resolve_jsx_props(svg)
    svg = convert_jsx_attrs(svg)
    svg = self_close_empty_elements(svg)

    # Ensure xmlns attribute
    if "xmlns=" not in svg:
        svg = svg.replace("<svg", '<svg xmlns="http://www.w3.org/2000/svg"', 1)

    # Remove leftover JSX-only fragments like {/* ... */}
    svg = re.sub(r"\{/\*.*?\*/\}", "", svg, flags=re.DOTALL)

    # Collapse excess whitespace between tags (cosmetic)
    svg = re.sub(r">\s{2,}<", ">\n  <", svg)

    return svg.strip()


def find_component_name(file_content: str) -> str | None:
    """Extract the exported component name from a TypeScript file.

    Matches patterns like:
        export const AddPlusIcon = ...
        export function ArrowDownIcon ...
    """
    match = re.search(
        r"export\s+(?:const|function)\s+([A-Z][A-Za-z0-9]+Icon)\b",
        file_content
    )
    return match.group(1) if match else None


# ---------------------------------------------------------------------------
# File processing
# ---------------------------------------------------------------------------

def process_file(ts_path: Path, output_dir: Path, force: bool, dry_run: bool) -> bool:
    """Process a single .ts/.tsx file. Returns True if an SVG was generated."""
    content = ts_path.read_text(encoding="utf-8")

    component_name = find_component_name(content)
    if not component_name:
        print(f"  ⚠ skip  {ts_path.name} — no exported Icon component found")
        return False

    asset_name = component_name_to_asset_name(component_name)
    output_path = output_dir / f"{asset_name}.svg"

    if output_path.exists() and not force:
        print(f"  ↩ skip  {asset_name}.svg (already exists — use --force to overwrite)")
        return False

    svg = extract_svg_from_jsx(content)
    if not svg:
        print(f"  ⚠ skip  {ts_path.name} — no <svg> block found")
        return False

    if dry_run:
        print(f"  ✓ would write  {asset_name}.svg  [{component_name}]")
        return True

    output_path.write_text(svg, encoding="utf-8")
    print(f"  ✓ wrote  {asset_name}.svg  [{component_name}]")
    return True


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def main() -> None:
    parser = argparse.ArgumentParser(
        description="Convert Zodiak TypeScript icon components to SVG files."
    )
    parser.add_argument(
        "ts_directory",
        metavar="TS_DIRECTORY",
        help="Directory containing .ts/.tsx icon files from Kamila",
    )
    parser.add_argument(
        "--output",
        default="visual-assets/icons",
        metavar="DIR",
        help="Output directory for SVG files (default: visual-assets/icons/)",
    )
    parser.add_argument(
        "--force",
        action="store_true",
        help="Overwrite existing SVG files",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Preview output without writing files",
    )
    args = parser.parse_args()

    ts_dir = Path(args.ts_directory).expanduser().resolve()
    output_dir = Path(args.output).expanduser()

    # Resolve output dir relative to project root when not absolute
    if not output_dir.is_absolute():
        script_dir = Path(__file__).parent
        project_root = script_dir.parent
        output_dir = (project_root / output_dir).resolve()

    if not ts_dir.is_dir():
        print(f"Error: '{ts_dir}' is not a directory.", file=sys.stderr)
        sys.exit(1)

    ts_files = sorted(ts_dir.glob("**/*.ts")) + sorted(ts_dir.glob("**/*.tsx"))
    if not ts_files:
        print(f"No .ts/.tsx files found in '{ts_dir}'.")
        sys.exit(0)

    if not args.dry_run:
        output_dir.mkdir(parents=True, exist_ok=True)

    mode = "DRY RUN — " if args.dry_run else ""
    print(f"\n{mode}→ Processing {len(ts_files)} file(s) from '{ts_dir}'")
    print(f"  Output: {output_dir}\n")

    generated = sum(
        process_file(f, output_dir, force=args.force, dry_run=args.dry_run)
        for f in ts_files
    )

    print(f"\n{'Would generate' if args.dry_run else 'Generated'} {generated}/{len(ts_files)} SVG(s).")
    if not args.dry_run and generated > 0:
        print("\nNext step: run './scripts/import-visual-assets.sh' to create xcassets imagesets.")


if __name__ == "__main__":
    main()
