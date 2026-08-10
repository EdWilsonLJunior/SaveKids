#!/usr/bin/env python3
"""Prefix all per-feature string resource keys to avoid duplicates after module flatten."""
import os
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
RES_DIRS = [
    ROOT / "app/src/main/res/values",
    ROOT / "app/src/main/res/values-b+pt+BR",
]
KOTLIN_ROOT = ROOT / "app/src/main/kotlin/com/zodiak/android/feature"

string_name_re = re.compile(r'(<string\s+name=")([a-zA-Z][a-zA-Z0-9_]*)(")')

# Build mapping: feature -> {old_key: new_key}
feature_keys: dict[str, set[str]] = {}

for res_dir in RES_DIRS:
    for xml in sorted(res_dir.glob("strings_*.xml")):
        feature = xml.stem.removeprefix("strings_")
        content = xml.read_text(encoding="utf-8")
        prefix = f"{feature}_"
        keys_in_file = set()

        def replace(m: re.Match[str]) -> str:
            key = m.group(2)
            if key.startswith(prefix):
                return m.group(0)
            new_key = f"{prefix}{key}"
            keys_in_file.add(key)
            return f'{m.group(1)}{new_key}{m.group(3)}'

        new_content = string_name_re.sub(replace, content)
        if new_content != content:
            xml.write_text(new_content, encoding="utf-8")
        feature_keys.setdefault(feature, set()).update(keys_in_file)

print(f"Renamed keys in {len(feature_keys)} features")

# Update R.string.* references in feature kotlin files
total = 0
for feature, keys in feature_keys.items():
    if not keys:
        continue
    feature_dir = KOTLIN_ROOT / feature
    if not feature_dir.is_dir():
        print(f"WARN: no kotlin dir for {feature}", file=sys.stderr)
        continue
    # Also scan tests
    test_dir = ROOT / f"app/src/test/kotlin/com/zodiak/android/feature/{feature}"
    dirs = [feature_dir]
    if test_dir.is_dir():
        dirs.append(test_dir)
    for d in dirs:
        for kt in d.rglob("*.kt"):
            content = kt.read_text(encoding="utf-8")
            new_content = content
            for key in keys:
                new_content = re.sub(
                    rf'\bR\.string\.{re.escape(key)}\b',
                    f'R.string.{feature}_{key}',
                    new_content,
                )
            if new_content != content:
                kt.write_text(new_content, encoding="utf-8")
                total += 1

print(f"Updated {total} kotlin files")
