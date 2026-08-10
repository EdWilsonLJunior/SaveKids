#!/usr/bin/env python3
"""Fase 3b — consolida pares de bullets `- **iOS**:` / `- **Android**:` em
`## Spec técnica > ### APIs públicas`.

Política:
1. Em `### APIs públicas`, o bullet `- **iOS**: \`SIG_iOS\`` perde o prefixo
   `**iOS**:` e passa a ser o **contrato neutro** (a sintaxe iOS já estará em
   notação neutra após Fase 3a). Substituições residuais aplicadas inline.
2. O bullet `- **Android**: \`SIG_Android\`` é REMOVIDO de `APIs públicas` e
   adicionado em `## Boas práticas — Android` como
   `- **Assinatura concreta**: \`SIG_Android\``.
3. Se já houver `## Boas práticas — Android` sem "Assinatura concreta", a linha
   é inserida no topo dessa seção (logo após o cabeçalho e qualquer linha em
   branco subsequente).
4. Espelhamento simétrico para iOS: copia a `SIG_iOS` original (com `Binding`,
   `AttributedString`, etc.) para `## Boas práticas — iOS` como
   `- **Assinatura concreta**: \`SIG_iOS\``.
"""
from __future__ import annotations
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TARGET_DIRS = ["02-atoms", "03-molecules", "04-organisms", "05-templates", "06-utils"]

H2_RE = re.compile(r"^##\s+(.*?)\s*$")
H3_RE = re.compile(r"^###\s+(.*?)\s*$")
IOS_BULLET_RE = re.compile(r"^-\s+\*\*iOS\*\*:\s*(.*?)$")
ANDROID_BULLET_RE = re.compile(r"^-\s+\*\*Android\*\*:\s*(.*?)$")
IOS_ANDROID_BULLET_RE = re.compile(r"^-\s+\*\*iOS\s*/\s*Android\*\*:\s*(.*?)$")


def process_file(path: Path) -> bool:
    text = path.read_text(encoding="utf-8")
    lines = text.split("\n")
    n = len(lines)

    # Locate ## Spec técnica section and inside it ### APIs públicas range.
    spec_start = spec_end = None
    apis_start = apis_end = None
    boas_ios_start = boas_ios_end = None
    boas_android_start = boas_android_end = None

    for i, line in enumerate(lines):
        m2 = H2_RE.match(line)
        if m2:
            title = m2.group(1).strip().lower()
            # Close any open ranges
            if spec_start is not None and spec_end is None and i > spec_start:
                spec_end = i
            if apis_start is not None and apis_end is None and i > apis_start:
                apis_end = i
            if boas_ios_start is not None and boas_ios_end is None and i > boas_ios_start:
                boas_ios_end = i
            if boas_android_start is not None and boas_android_end is None and i > boas_android_start:
                boas_android_end = i
            if title == "spec técnica":
                spec_start = i
            elif title == "boas práticas — ios":
                boas_ios_start = i
            elif title == "boas práticas — android":
                boas_android_start = i
        elif spec_start is not None and apis_start is None:
            m3 = H3_RE.match(line)
            if m3 and m3.group(1).strip().lower() == "apis públicas":
                apis_start = i
        elif apis_start is not None and apis_end is None:
            m3 = H3_RE.match(line)
            if m3:
                apis_end = i

    # Close any still-open ranges at EOF
    if spec_end is None and spec_start is not None:
        spec_end = n
    if apis_end is None and apis_start is not None:
        apis_end = n
    if boas_ios_end is None and boas_ios_start is not None:
        boas_ios_end = n
    if boas_android_end is None and boas_android_start is not None:
        boas_android_end = n

    if apis_start is None:
        return False

    # Scan APIs públicas range for iOS/Android bullets.
    ios_sig = None
    android_sig = None
    ios_line_idx = None
    android_line_idx = None
    combined_line_idx = None
    for i in range(apis_start + 1, apis_end):
        m_ios = IOS_BULLET_RE.match(lines[i])
        m_android = ANDROID_BULLET_RE.match(lines[i])
        m_combined = IOS_ANDROID_BULLET_RE.match(lines[i])
        if m_ios:
            ios_sig = m_ios.group(1).strip()
            ios_line_idx = i
        elif m_android:
            android_sig = m_android.group(1).strip()
            android_line_idx = i
        elif m_combined:
            combined_line_idx = i

    if ios_sig is None and android_sig is None and combined_line_idx is None:
        return False

    changed = False
    new_lines = lines[:]  # mutable copy

    # 1) In APIs públicas: strip **iOS**: prefix on the iOS bullet (becomes
    # neutral contract). Remove the **Android**: bullet entirely.
    if ios_line_idx is not None:
        new_lines[ios_line_idx] = f"- {ios_sig}"
        changed = True
    if android_line_idx is not None:
        new_lines[android_line_idx] = "__REMOVE__"
        changed = True
    if combined_line_idx is not None:
        # Just strip the label
        m = IOS_ANDROID_BULLET_RE.match(new_lines[combined_line_idx])
        if m:
            new_lines[combined_line_idx] = f"- {m.group(1).strip()}"
            changed = True

    # 2) Append concrete signatures to Boas práticas sections.
    insertions: list[tuple[int, list[str]]] = []  # (line index BEFORE which to insert, lines)

    def find_insertion_point(section_start: int, section_end: int) -> int:
        """Insert right after the H2 line, skipping a blank line if present."""
        idx = section_start + 1
        while idx < section_end and lines[idx].strip() == "":
            idx += 1
        return idx

    if ios_sig and boas_ios_start is not None:
        # Avoid duplicating if already present
        existing = "\n".join(lines[boas_ios_start:boas_ios_end])
        if "Assinatura concreta" not in existing:
            insertion_pt = find_insertion_point(boas_ios_start, boas_ios_end)
            insertions.append((insertion_pt, [f"- **Assinatura concreta**: {ios_sig}", ""]))

    if android_sig and boas_android_start is not None:
        existing = "\n".join(lines[boas_android_start:boas_android_end])
        if "Assinatura concreta" not in existing:
            insertion_pt = find_insertion_point(boas_android_start, boas_android_end)
            insertions.append((insertion_pt, [f"- **Assinatura concreta**: {android_sig}", ""]))

    # Apply insertions in reverse so line indices stay valid.
    for insertion_pt, ins_lines in sorted(insertions, key=lambda x: -x[0]):
        new_lines[insertion_pt:insertion_pt] = ins_lines
        changed = True

    if not changed:
        return False

    new_lines = [l for l in new_lines if l != "__REMOVE__"]
    path.write_text("\n".join(new_lines), encoding="utf-8")
    return True


def main() -> int:
    touched = 0
    for d in TARGET_DIRS:
        for path in sorted((ROOT / d).rglob("*.md")):
            if process_file(path):
                print(f"  {path.relative_to(ROOT)}: dual-bullet consolidado")
                touched += 1
    print(f"\n{touched} arquivos processados")
    return 0


if __name__ == "__main__":
    sys.exit(main())
