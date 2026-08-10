#!/usr/bin/env bash
# extract_zodiak_pdfs.sh
#
# Extracts text content from all Zodiak PDF source-of-truth documents in
# docs/zodiak-pdf/ into docs/zodiak-pdf/_extracted/*.txt for diffing when
# Capgemini publishes updated Zodiak DS pages.
#
# Requirements:
#   - pdftotext (poppler) — install via `brew install poppler`
#
# Usage:
#   ./scripts/extract_zodiak_pdfs.sh        # extract all
#   ./scripts/extract_zodiak_pdfs.sh --diff # extract + git-diff against last commit
#
# Exit codes:
#   0 success
#   1 missing dependency
#   2 source folder not found

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$ROOT/docs/zodiak-pdf"
DST="$SRC/_extracted"

if ! command -v pdftotext >/dev/null 2>&1; then
    echo "error: pdftotext not found. Install via: brew install poppler" >&2
    exit 1
fi

if [ ! -d "$SRC" ]; then
    echo "error: source folder not found: $SRC" >&2
    exit 2
fi

mkdir -p "$DST"

count=0
for pdf in "$SRC"/*.pdf; do
    [ -e "$pdf" ] || continue
    name="$(basename "$pdf" .pdf)"
    out="$DST/${name}.txt"
    pdftotext -layout -nopgbrk "$pdf" "$out"
    count=$((count + 1))
done

echo "✅ Extracted $count PDFs into $DST"

if [ "${1:-}" = "--diff" ]; then
    echo ""
    echo "Diff against last commit:"
    git -C "$ROOT" diff --stat -- "$DST" || true
fi
