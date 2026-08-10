#!/bin/bash
# import-visual-assets.sh
# Cria imagesets em Assets.xcassets para todos os SVGs em visual-assets/flags/ e visual-assets/logo/
# Uso: ./scripts/import-visual-assets.sh (rodar a partir da raiz do projeto)
# Idempotente: pula imagesets já existentes.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_FLAGS="$SCRIPT_DIR/visual-assets/flags"
SOURCE_LOGOS="$SCRIPT_DIR/visual-assets/logo"
XCASSETS="$SCRIPT_DIR/ZodiakiOS/Assets.xcassets"

# ---------------------------------------------------------------------------
# slugify <filename-with-extension>
# → lowercase, spaces/underscores→hyphens, remove _color suffix, remove accents
# ---------------------------------------------------------------------------
slugify() {
    local name="$1"
    # Remove extension
    name="${name%.*}"
    # Remove _color suffix (case-sensitive, before lowercasing)
    name="${name/_color/}"
    # Remove accents via Python (reliable unicode normalization on macOS)
    name=$(python3 -c "
import unicodedata, sys
s = sys.argv[1]
s = unicodedata.normalize('NFD', s)
s = ''.join(c for c in s if unicodedata.category(c) != 'Mn')
print(s)
" "$name")
    # Lowercase
    name=$(echo "$name" | tr '[:upper:]' '[:lower:]')
    # Spaces and underscores → hyphens
    name=$(echo "$name" | tr ' _' '-')
    # Collapse multiple consecutive hyphens
    name=$(echo "$name" | sed 's/-\+/-/g')
    # Trim leading/trailing hyphens
    name=$(echo "$name" | sed 's/^-//;s/-$//')
    echo "$name"
}

# ---------------------------------------------------------------------------
# make_imageset <src-svg-path> <asset-prefix>
# Creates: Assets.xcassets/<prefix>-<slug>.imageset/
# ---------------------------------------------------------------------------
make_imageset() {
    local src="$1"
    local prefix="$2"
    local filename
    filename=$(basename "$src")
    local slug
    slug=$(slugify "$filename")
    local asset_name="${prefix}-${slug}"
    local imageset_dir="$XCASSETS/${asset_name}.imageset"

    if [ -d "$imageset_dir" ]; then
        echo "  ↩ skip  $asset_name"
        return
    fi

    mkdir -p "$imageset_dir"
    cp "$src" "$imageset_dir/$filename"

    cat > "$imageset_dir/Contents.json" << CONTENTS_EOF
{
  "images" : [
    {
      "filename" : "${filename}",
      "idiom" : "universal",
      "scale" : "1x"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  },
  "properties" : {
    "preserves-vector-representation" : true,
    "template-rendering-intent" : "original"
  }
}
CONTENTS_EOF

    echo "  ✓ created $asset_name"
}

# ---------------------------------------------------------------------------
# Icon imagesets (expects SVGs exported from Figma in visual-assets/icons/)
# Naming convention: export each icon as "zodiak-icon-{name}.svg" from Figma
# The file is copied as-is; asset name must already match the convention.
# ---------------------------------------------------------------------------
import_icons() {
    local icons_dir="$SCRIPT_DIR/visual-assets/icons"
    if [ ! -d "$icons_dir" ] || [ -z "$(ls -A "$icons_dir" 2>/dev/null)" ]; then
        echo "  ⚠ icons/ is empty — skipping (export SVGs from Figma first)"
        return
    fi
    for f in "$icons_dir"/*.svg; do
        local filename
        filename=$(basename "$f")
        local asset_name="${filename%.svg}"
        local imageset_dir="$XCASSETS/${asset_name}.imageset"
        if [ -d "$imageset_dir" ]; then
            echo "  ↩ skip  $asset_name"
            continue
        fi
        mkdir -p "$imageset_dir"
        cp "$f" "$imageset_dir/$filename"
        cat > "$imageset_dir/Contents.json" << ICON_EOF
{
  "images" : [
    {
      "filename" : "${filename}",
      "idiom" : "universal",
      "scale" : "1x"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  },
  "properties" : {
    "preserves-vector-representation" : true,
    "template-rendering-intent" : "template"
  }
}
ICON_EOF
        echo "  ✓ created $asset_name"
    done
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
echo ""
echo "→ Importing flags..."
for f in "$SOURCE_FLAGS"/*.svg; do
    [ -f "$f" ] && make_imageset "$f" "zodiak-flag"
done

echo ""
echo "→ Importing logos..."
for f in "$SOURCE_LOGOS"/*.svg; do
    [ -f "$f" ] && make_imageset "$f" "zodiak-logo"
done

echo ""
echo "→ Importing icons (from Figma export)..."
import_icons

echo ""
echo "Done. Open Xcode and verify Assets.xcassets."
