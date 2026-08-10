#!/usr/bin/env python3
"""
Convert Localizable.strings files to Localizable.xcstrings (String Catalog).
Reads en.lproj and pt-BR.lproj .strings files and generates the xcstrings JSON.
"""

import json
import os
import re

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
EN_STRINGS  = os.path.join(ROOT, "ZodiakiOS/en.lproj/Localizable.strings")
PTBR_STRINGS = os.path.join(ROOT, "ZodiakiOS/pt-BR.lproj/Localizable.strings")
OUTPUT = os.path.join(ROOT, "ZodiakiOS/Localizable.xcstrings")


# ─────────────────────────────────────────────────────────────────────────────
# Parser for .strings files
# ─────────────────────────────────────────────────────────────────────────────

def parse_strings(path: str) -> dict[str, str]:
    """
    Parse a .strings file and return {key: value} dict.
    Handles escaped quotes and multi-line values.
    """
    entries: dict[str, str] = {}
    with open(path, encoding="utf-8") as fh:
        content = fh.read()

    # Match: "key" = "value";
    # Handles backslash-escaped characters inside strings
    pattern = re.compile(
        r'"((?:[^"\\]|\\.)*)"\s*=\s*"((?:[^"\\]|\\.)*?)"\s*;',
        re.DOTALL
    )

    for match in pattern.finditer(content):
        raw_key   = match.group(1)
        raw_value = match.group(2)
        # Unescape \n, \t, \" → keep \n as newline in xcstrings value
        key   = raw_key.replace('\\"', '"').replace("\\n", "\n").replace("\\t", "\t")
        value = raw_value.replace('\\"', '"').replace("\\n", "\n").replace("\\t", "\t")
        entries[key] = value

    return entries


def build_xcstrings(en: dict[str, str], ptbr: dict[str, str]) -> dict:
    """Build the xcstrings JSON structure."""
    all_keys = sorted(set(en.keys()) | set(ptbr.keys()))

    strings: dict = {}

    for key in all_keys:
        en_val   = en.get(key, "")
        ptbr_val = ptbr.get(key, "")

        localizations: dict = {}

        if en_val:
            localizations["en"] = {
                "stringUnit": {
                    "state": "translated",
                    "value": en_val
                }
            }

        if ptbr_val:
            localizations["pt-BR"] = {
                "stringUnit": {
                    "state": "translated",
                    "value": ptbr_val
                }
            }

        strings[key] = {
            "extractionState": "manual",
            "localizations": localizations
        }

    return {
        "sourceLanguage": "en",
        "strings": strings,
        "version": "1.0"
    }


def main() -> None:
    print("Parsing en.lproj/Localizable.strings ...")
    en = parse_strings(EN_STRINGS)
    print(f"  → {len(en)} entries")

    print("Parsing pt-BR.lproj/Localizable.strings ...")
    ptbr = parse_strings(PTBR_STRINGS)
    print(f"  → {len(ptbr)} entries")

    print("Building Localizable.xcstrings ...")
    xcstrings = build_xcstrings(en, ptbr)
    total_keys = len(xcstrings["strings"])
    print(f"  → {total_keys} total keys")

    with open(OUTPUT, "w", encoding="utf-8") as fh:
        json.dump(xcstrings, fh, ensure_ascii=False, indent=2)

    size_kb = os.path.getsize(OUTPUT) // 1024
    print(f"\n✅  Written to {os.path.relpath(OUTPUT, ROOT)} ({size_kb} KB)")


if __name__ == "__main__":
    main()
