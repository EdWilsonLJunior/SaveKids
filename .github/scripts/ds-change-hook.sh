#!/usr/bin/env bash
# .github/scripts/ds-change-hook.sh
# Hook: PostToolUse — reminds to run /sync-zodiak-ds when a DS file is modified.
# Called by .github/hooks/ds-sync-reminder.json
# Input: JSON on stdin. Output: systemMessage JSON if DS file was modified.

set -euo pipefail

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

# Check if the file is inside Shared/DesignSystem/
if [[ "$FILE_PATH" != */Shared/DesignSystem/* ]]; then
  exit 0
fi

# Only trigger for Swift files
if [[ "$FILE_PATH" != *.swift ]]; then
  exit 0
fi

FILE_NAME=$(basename "$FILE_PATH")

# Distinguish token vs component change for a more actionable message
if [[ "$FILE_PATH" == */Tokens/* ]]; then
  KIND="token"
else
  KIND="component"
fi

echo "{\"systemMessage\": \"📐 Design System $KIND modified: $FILE_NAME — run /sync-zodiak-ds to keep the skill knowledge base up to date.\"}"

exit 0
