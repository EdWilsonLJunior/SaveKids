#!/usr/bin/env bash
# .github/scripts/swiftlint-check.sh
# Hook: PostToolUse — runs SwiftLint on any edited Swift file.
# Called by .github/hooks/swiftlint-check.json
# Input: JSON on stdin with toolName and toolInput fields.
# Output: systemMessage if violations found; silent on clean.

set -euo pipefail

# Read stdin JSON
INPUT=$(cat)

# Only act on file edit tools
TOOL_NAME=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('toolName',''))" 2>/dev/null || echo "")

case "$TOOL_NAME" in
  create_file|replace_string_in_file|multi_replace_string_in_file) ;;
  *) exit 0 ;;
esac

# Extract file path
FILE_PATH=$(echo "$INPUT" | python3 -c "
import sys, json
d = json.load(sys.stdin)
inp = d.get('toolInput', {})
print(inp.get('filePath', inp.get('file_path', '')))
" 2>/dev/null || echo "")

# Only check Swift files
if [[ "$FILE_PATH" != *.swift ]]; then
  exit 0
fi

# Only check files inside ZodiakiOS/
if [[ "$FILE_PATH" != */ZodiakiOS/*.swift ]]; then
  exit 0
fi

# Run SwiftLint — attempt auto-fix first, then report remaining violations
SWIFTLINT_BIN=$(command -v swiftlint 2>/dev/null || echo "")
if [[ -z "$SWIFTLINT_BIN" ]]; then
  echo "{\"systemMessage\": \"⚠️ swiftlint not found — install via `brew install swiftlint` to enable lint checks.\"}"
  exit 0
fi

# Auto-fix
"$SWIFTLINT_BIN" lint --fix --config .swiftlint.yml --quiet "$FILE_PATH" 2>/dev/null || true

# Report remaining violations
VIOLATIONS=$("$SWIFTLINT_BIN" lint --config .swiftlint.yml --quiet "$FILE_PATH" 2>/dev/null || echo "")

if [[ -n "$VIOLATIONS" ]]; then
  echo "{\"systemMessage\": \"⚠️ SwiftLint: remaining violations in $(basename \"$FILE_PATH\") after auto-fix:\n$VIOLATIONS\"}"
fi

exit 0
