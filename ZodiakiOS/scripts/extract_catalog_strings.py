#!/usr/bin/env python3
"""
Extrai todos os strings localizáveis dos gallery views e gera um manifest JSON.
Padrões extraídos:
  - galleryHeader(title:, subtitle:)
  - gallerySectionCard(title:)
  - Text("...")  (excluindo verbatim: e strings puramente técnicas)
  - ZodiakInfoRow("label", value: "value", ...)
"""

import re, json, os, sys
from pathlib import Path

ROOT = Path("/Users/mrocha/Developer/ZodiakiOS/ZodiakiOS/App/Catalog")

def to_snake(name: str) -> str:
    """ActionCompositionsGalleryView -> action_compositions"""
    name = name.replace("GalleryView", "").replace("Gallery", "")
    s = re.sub(r'([A-Z])', r'_\1', name).lstrip('_').lower()
    return s

def is_technical(s: str) -> bool:
    """Strings que são puramente técnicas / já em inglês e não precisam de chave semântica."""
    if not s.strip():
        return True
    # Pure size labels
    if re.fullmatch(r'(XS|S|M|L|XL|XXL|_3XS|_2XS|_XS)', s):
        return True
    # Pure numbers / measurements
    if re.fullmatch(r'[\d\s\.\-\+×/ptxX°%:,]+', s):
        return True
    return False

def extract_strings_from_file(path: Path):
    src = path.read_text(encoding='utf-8')
    view_name = path.stem  # e.g. ActionCompositionsGalleryView
    prefix = "catalog." + to_snake(view_name)

    entries = []

    # 1. galleryHeader subtitle (title is usually the component name - keep as-is)
    for m in re.finditer(r'galleryHeader\([^)]*subtitle:\s*"((?:[^"\\]|\\.)*)"', src, re.DOTALL):
        val = m.group(1)
        entries.append({"pattern": "header.subtitle", "original": val, "raw_match": m.group(0)[:80]})

    # 2. gallerySectionCard title
    for m in re.finditer(r'gallerySectionCard\s*\(\s*title:\s*"((?:[^"\\]|\\.)*)"', src):
        val = m.group(1)
        entries.append({"pattern": "section.title", "original": val, "raw_match": m.group(0)[:80]})

    # 3. Text("...") — excluding verbatim and pure-code strings
    for m in re.finditer(r'\bText\("((?:[^"\\]|\\.)*)"\)', src):
        val = m.group(1)
        # Skip if inside verbatim call context — already handled separately
        if 'verbatim:' in m.group(0):
            continue
        # Skip pure technical / format strings
        if is_technical(val):
            continue
        # Skip if it looks like a code token (ZodiakXxx, starts with uppercase single word)
        if re.fullmatch(r'[A-Z][a-zA-Z]+', val):
            continue
        entries.append({"pattern": "text", "original": val, "raw_match": m.group(0)[:80]})

    # 4. ZodiakInfoRow label + value
    for m in re.finditer(r'ZodiakInfoRow\("((?:[^"\\]|\\.)*)",\s*value:\s*"((?:[^"\\]|\\.)*)"', src):
        lbl, val = m.group(1), m.group(2)
        entries.append({"pattern": "info_row.label", "original": lbl, "raw_match": m.group(0)[:80]})
        entries.append({"pattern": "info_row.value", "original": val, "raw_match": m.group(0)[:80]})

    return prefix, entries


def main():
    manifest = {}
    for swift_file in sorted(ROOT.rglob("*.swift")):
        if "GalleryView" not in swift_file.stem and swift_file.stem != "ZodiakGalleryShell":
            continue
        prefix, entries = extract_strings_from_file(swift_file)
        if entries:
            manifest[str(swift_file.relative_to(ROOT.parent.parent.parent))] = {
                "prefix": prefix,
                "strings": entries
            }

    output = Path("/tmp/catalog_strings_manifest.json")
    output.write_text(json.dumps(manifest, ensure_ascii=False, indent=2), encoding='utf-8')
    print(f"Manifest escrito em {output}")
    print(f"Total de arquivos: {len(manifest)}")
    total = sum(len(v['strings']) for v in manifest.values())
    print(f"Total de strings extraídos: {total}")

    # Print unique originals to help with translations
    all_originals = set()
    for v in manifest.values():
        for e in v['strings']:
            all_originals.add(e['original'])
    print(f"Strings únicos: {len(all_originals)}")

if __name__ == "__main__":
    main()
