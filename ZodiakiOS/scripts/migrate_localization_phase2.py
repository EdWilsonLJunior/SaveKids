#!/usr/bin/env python3
"""
Localization Migration — Phase 2
Fixes:
 1. 24 CatalogModel enum case raw values that were missed in Phase 1
 2. Escaped-quote format strings that Phase 1 failed to rename
 3. App UI strings (icon search, country search, etc.)
"""

import os
import re

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
EN_STRINGS  = os.path.join(ROOT, "ZodiakiOS/en.lproj/Localizable.strings")
PTBR_STRINGS = os.path.join(ROOT, "ZodiakiOS/pt-BR.lproj/Localizable.strings")
CATALOG_MODEL = os.path.join(ROOT, "ZodiakiOS/App/Catalog/CatalogModel.swift")

SWIFT_ROOTS = [
    os.path.join(ROOT, "ZodiakiOS/Features"),
    os.path.join(ROOT, "ZodiakiOS/App"),
    os.path.join(ROOT, "ZodiakiOS/Models"),
    os.path.join(ROOT, "ZodiakiOS/Services"),
    os.path.join(ROOT, "ZodiakiOS/Shared"),
]

# ─────────────────────────────────────────────────────────────────────────────
# Phase-2 mapping: old key → new key
# ─────────────────────────────────────────────────────────────────────────────

# NOTE: The escaped-quote strings require special handling (see below).
# Regular strings listed here use simple matching.
MAPPING = {
    # ── CatalogSection enum cases ─────────────────────────────────────────────
    "Composições":               "catalog.section.compositions",
    "Visual Assets":             "catalog.section.visual_assets",

    # ── CatalogItem enum cases ────────────────────────────────────────────────
    "Info Row":                  "catalog.component_name.info_row",
    "View Modifiers":            "catalog.section.view_modifiers",
    "Card Grid":                 "catalog.component_name.card_grid",
    "Composições de Conteúdo":   "catalog.section.content_compositions",
    "Media Button":              "catalog.component_name.media_button",
    "Video Preview Button":      "catalog.component_name.video_preview_button",
    "Slider Counter":            "catalog.component_name.slider_counter",
    "Combobox":                  "catalog.component_name.combobox",
    "Dropdown":                  "catalog.component_name.dropdown",
    "Multiselect":               "catalog.component_name.multiselect",
    "Share":                     "catalog.component_name.share",
    "Form in Drawer":            "catalog.component_name.form_in_drawer",
    "Login Form":                "catalog.component_name.login_form",
    "Heróis":                    "catalog.section.hero_compositions",
    "Tipográfico":               "catalog.section.typographic_compositions",
    "Grade de Cards":            "catalog.section.card_grid_compositions",
    "Imagem e Texto":            "catalog.section.image_compositions",
    "Mídia":                     "catalog.section.media_compositions",
    "Ações":                     "catalog.section.action_ribbons",
    "Acessibilidade":            "catalog.section.accessibility",
    "Sizing":                    "catalog.section.sizing",
    "Layout Grid":               "catalog.section.layout_grid",

    # ── App UI: icon / country search ─────────────────────────────────────────
    "Buscar ícone...":           "catalog.home.search_icon_placeholder",
    "Nenhum ícone encontrado":   "catalog.home.no_icons_found",
    "Buscar país...":            "catalog.home.search_country_placeholder",
    "País não encontrado":       "catalog.home.no_country_found",
}

# Keys that contain literal " inside them — stored here as (old, new) pairs
# because the file representation uses backslash-escaped quotes.
ESCAPED_MAPPING = [
    (r'Nenhum resultado para \"%@\"',          "catalog.home.no_results"),
    (r'Nenhuma tarefa encontrada para \"%@\".', "feature.task_manager.no_tasks_found"),
]

# ─────────────────────────────────────────────────────────────────────────────
# EN values for new keys (English)
# ─────────────────────────────────────────────────────────────────────────────
EN_VALUES = {
    "catalog.section.compositions":        "Compositions",
    "catalog.section.visual_assets":       "Visual Assets",
    "catalog.component_name.info_row":     "Info Row",
    "catalog.section.view_modifiers":      "View Modifiers",
    "catalog.component_name.card_grid":    "Card Grid",
    "catalog.section.content_compositions": "Content Compositions",
    "catalog.component_name.media_button": "Media Button",
    "catalog.component_name.video_preview_button": "Video Preview Button",
    "catalog.component_name.slider_counter": "Slider Counter",
    "catalog.component_name.combobox":     "Combobox",
    "catalog.component_name.dropdown":     "Dropdown",
    "catalog.component_name.multiselect":  "Multiselect",
    "catalog.component_name.share":        "Share",
    "catalog.component_name.form_in_drawer": "Form in Drawer",
    "catalog.component_name.login_form":   "Login Form",
    "catalog.section.hero_compositions":   "Hero",
    "catalog.section.typographic_compositions": "Typographic",
    "catalog.section.card_grid_compositions": "Card Grid",
    "catalog.section.image_compositions":  "Image and Text",
    "catalog.section.media_compositions":  "Media",
    "catalog.section.action_ribbons":      "Actions",
    "catalog.section.accessibility":       "Accessibility",
    "catalog.section.sizing":              "Sizing",
    "catalog.section.layout_grid":         "Layout Grid",
    "catalog.home.search_icon_placeholder": "Search icon...",
    "catalog.home.no_icons_found":         "No icons found",
    "catalog.home.search_country_placeholder": "Search country...",
    "catalog.home.no_country_found":       "Country not found",
    "catalog.home.no_results":             "No results for \"%@\"",
    "feature.task_manager.no_tasks_found": "No tasks found for \"%@\".",
}

# ─────────────────────────────────────────────────────────────────────────────
# PT-BR values for new keys
# ─────────────────────────────────────────────────────────────────────────────
PTBR_VALUES = {
    "catalog.section.compositions":        "Composições",
    "catalog.section.visual_assets":       "Visual Assets",
    "catalog.component_name.info_row":     "Info Row",
    "catalog.section.view_modifiers":      "View Modifiers",
    "catalog.component_name.card_grid":    "Card Grid",
    "catalog.section.content_compositions": "Composições de Conteúdo",
    "catalog.component_name.media_button": "Media Button",
    "catalog.component_name.video_preview_button": "Video Preview Button",
    "catalog.component_name.slider_counter": "Slider Counter",
    "catalog.component_name.combobox":     "Combobox",
    "catalog.component_name.dropdown":     "Dropdown",
    "catalog.component_name.multiselect":  "Multiselect",
    "catalog.component_name.share":        "Share",
    "catalog.component_name.form_in_drawer": "Form in Drawer",
    "catalog.component_name.login_form":   "Login Form",
    "catalog.section.hero_compositions":   "Heróis",
    "catalog.section.typographic_compositions": "Tipográfico",
    "catalog.section.card_grid_compositions": "Grade de Cards",
    "catalog.section.image_compositions":  "Imagem e Texto",
    "catalog.section.media_compositions":  "Mídia",
    "catalog.section.action_ribbons":      "Ações",
    "catalog.section.accessibility":       "Acessibilidade",
    "catalog.section.sizing":              "Sizing",
    "catalog.section.layout_grid":         "Layout Grid",
    "catalog.home.search_icon_placeholder": "Buscar ícone...",
    "catalog.home.no_icons_found":         "Nenhum ícone encontrado",
    "catalog.home.search_country_placeholder": "Buscar país...",
    "catalog.home.no_country_found":       "País não encontrado",
    "catalog.home.no_results":             "Nenhum resultado para \"%@\"",
    "feature.task_manager.no_tasks_found": "Nenhuma tarefa encontrada para \"%@\".",
}


def rename_strings_key(content: str, old_key: str, new_key: str) -> tuple[str, int]:
    """
    Rename a key in .strings file content.
    Handles escaped-quote keys via raw matching.
    Returns (updated_content, count_of_replacements).
    """
    # Build search/replace patterns (quotes are literal in the file)
    old_pattern = f'"{old_key}"'
    new_pattern = f'"{new_key}"'
    count = content.count(old_pattern)
    return content.replace(old_pattern, new_pattern), count


def update_strings_file(path: str, mapping: dict, escaped_mapping: list) -> None:
    """Rename keys in a .strings file."""
    with open(path, encoding="utf-8") as fh:
        content = fh.read()

    total = 0

    # Regular keys
    for old_key, new_key in mapping.items():
        content, n = rename_strings_key(content, old_key, new_key)
        if n:
            total += n
            print(f"  [strings] {old_key!r} → {new_key!r}")

    # Escaped-quote keys
    for old_inner, new_key in escaped_mapping:
        old_pattern = f'"{old_inner}"'
        new_pattern = f'"{new_key}"'
        n = content.count(old_pattern)
        content = content.replace(old_pattern, new_pattern)
        if n:
            total += n
            print(f"  [strings] (escaped) {old_inner!r} → {new_key!r}")

    with open(path, "w", encoding="utf-8") as fh:
        fh.write(content)

    print(f"  → {total} keys updated in {os.path.basename(path)}")


def update_swift_file(path: str, mapping: dict, escaped_mapping: list) -> int:
    """Rename string literals in a Swift file. Returns change count."""
    with open(path, encoding="utf-8") as fh:
        content = fh.read()

    original = content
    total = 0

    for old_key, new_key in mapping.items():
        old_pattern = f'"{old_key}"'
        new_pattern = f'"{new_key}"'
        n = content.count(old_pattern)
        if n:
            content = content.replace(old_pattern, new_pattern)
            total += n
            print(f"    {old_key!r} → {new_key!r} ({n}×)")

    # Escaped-quote keys in Swift: the file stores them as "...\"%@\"..."
    # Swift source contains the literal backslash-quote as well.
    for old_inner, new_key in escaped_mapping:
        # old_inner already contains \", so the pattern in the Swift source is
        # "Nenhum resultado para \"%@\""
        old_pattern = f'"{old_inner}"'
        new_pattern = f'"{new_key}"'
        n = content.count(old_pattern)
        if n:
            content = content.replace(old_pattern, new_pattern)
            total += n
            print(f"    (escaped) {old_inner!r} → {new_key!r} ({n}×)")

    if content != original:
        with open(path, "w", encoding="utf-8") as fh:
            fh.write(content)

    return total


def walk_swift_files(roots: list) -> list:
    result = []
    for root in roots:
        for dirpath, _, filenames in os.walk(root):
            for fname in filenames:
                if fname.endswith(".swift"):
                    result.append(os.path.join(dirpath, fname))
    return sorted(result)


def main() -> None:
    print("=" * 70)
    print("Phase-2 Localization Migration — ZodiakiOS")
    print("=" * 70)

    # 1. Update .strings files ─────────────────────────────────────────────────
    print("\n[1/3] Updating en.lproj/Localizable.strings ...")
    update_strings_file(EN_STRINGS, MAPPING, ESCAPED_MAPPING)

    print("\n[2/3] Updating pt-BR.lproj/Localizable.strings ...")
    update_strings_file(PTBR_STRINGS, MAPPING, ESCAPED_MAPPING)

    # 2. Update Swift files (CatalogModel + anything referencing these strings) ─
    print("\n[3/3] Updating Swift files ...")
    swift_files = walk_swift_files(SWIFT_ROOTS)
    total_swift = 0
    for path in swift_files:
        count = update_swift_file(path, MAPPING, ESCAPED_MAPPING)
        if count:
            rel = os.path.relpath(path, ROOT)
            print(f"  {rel}: {count} replacement(s)")
            total_swift += count

    print(f"\n  → {total_swift} total Swift replacements")

    # 3. Append NEW key entries to .strings files ─────────────────────────────
    # Keys that appear as new keys (not renamed from an existing entry) need
    # to be appended. But all of our new keys come from renaming existing ones,
    # so no append is needed — the rename above already handles it.

    print("\n✅  Phase-2 migration complete.\n")


if __name__ == "__main__":
    main()
