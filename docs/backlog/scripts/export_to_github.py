#!/usr/bin/env python3
"""Export Zodiak Design System backlog to GitHub Issues + Project v2.

Parses all story .md files in docs/backlog/ and GAPS.md, creates GitHub
Issues with labels, then organises them in a GitHub Project v2 board with
Priority, Layer and Platform custom fields.

Usage:
    python3 docs/backlog/scripts/export_to_github.py --repo owner/repo
    python3 docs/backlog/scripts/export_to_github.py --repo owner/repo --dry-run

Requirements:
    - gh CLI installed and authenticated (gh auth login)
    - Scopes: repo (issues) + project (project:write)
      If project scope is missing run: gh auth refresh -s project
"""

from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
import time
from dataclasses import dataclass
from pathlib import Path
from typing import Any

# ── Paths ──────────────────────────────────────────────────────────────────────

ROOT = Path(__file__).resolve().parent.parent  # docs/backlog/
STORY_DIRS = [
    "00-foundations",
    "01-theme",
    "02-atoms",
    "03-molecules",
    "04-organisms",
    "05-templates",
    "06-utils",
]
LAYER_MAP = {
    "00-foundations": "foundation",
    "01-theme": "theme",
    "02-atoms": "atom",
    "03-molecules": "molecule",
    "04-organisms": "organism",
    "05-templates": "template",
    "06-utils": "utils",
}

# ── Labels ─────────────────────────────────────────────────────────────────────

LABELS: list[dict[str, str]] = [
    # Priority
    {"name": "P0", "color": "B60205", "description": "Blocker — must ship first"},
    {"name": "P1", "color": "E4E669", "description": "High priority"},
    {"name": "P2", "color": "0075CA", "description": "Medium priority"},
    # Platform
    {"name": "ios", "color": "1D76DB", "description": "iOS / SwiftUI"},
    {"name": "android", "color": "0E8A16", "description": "Android / Jetpack Compose"},
    {"name": "cross-platform", "color": "5319E7", "description": "Both platforms"},
    # Layer
    {"name": "foundation", "color": "F9D0C4", "description": "Design token / foundation"},
    {"name": "theme", "color": "FAD8C7", "description": "Theme layer"},
    {"name": "atom", "color": "BFD4F2", "description": "Atomic component"},
    {"name": "molecule", "color": "C5DEF5", "description": "Molecule component"},
    {"name": "organism", "color": "BFDADC", "description": "Organism component"},
    {"name": "template", "color": "D4C5F9", "description": "Layout template"},
    {"name": "utils", "color": "E4E669", "description": "Utility / helpers"},
    # Type
    {"name": "story", "color": "EDEDED", "description": "Implementation story"},
    {"name": "gap", "color": "E11D48", "description": "Open design/spec gap"},
    # Status
    {"name": "em-progresso", "color": "FBCA04", "description": "In progress"},
    {"name": "backlog", "color": "CCCCCC", "description": "Not yet started"},
]

# ── Data classes ───────────────────────────────────────────────────────────────

@dataclass
class Issue:
    title: str
    body: str
    labels: list[str]
    priority: str        # P0 / P1 / P2
    layer: str           # foundation / atom / … / gap
    platform: str        # ios / android / cross-platform
    source_file: str     # relative path for traceability


@dataclass
class CreatedIssue:
    issue: Issue
    node_id: str
    number: int
    url: str


# ── gh API helpers ─────────────────────────────────────────────────────────────

def gh_rest(method: str, path: str, data: dict | None = None) -> Any:
    """Call gh api REST endpoint. Returns parsed JSON (dict or list)."""
    cmd = ["gh", "api", "--method", method, path]
    input_bytes: bytes | None = None
    if data is not None:
        input_bytes = json.dumps(data).encode()
        cmd += ["--input", "-"]
    result = subprocess.run(cmd, input=input_bytes, capture_output=True)
    if result.returncode != 0:
        err = result.stderr.decode().strip()
        raise RuntimeError(f"gh api failed [{method} {path}]:\n{err}")
    raw = result.stdout.strip()
    return json.loads(raw) if raw else {}


def gh_graphql(query: str, variables: dict | None = None, _retries: int = 4) -> dict:
    """Call gh api graphql. Returns the 'data' dict from the response.
    Retries up to _retries times on transient HTTP/2 or 5xx errors.
    """
    payload: dict[str, Any] = {"query": query}
    if variables:
        payload["variables"] = variables
    input_bytes = json.dumps(payload).encode()

    for attempt in range(1, _retries + 1):
        result = subprocess.run(
            ["gh", "api", "graphql", "--input", "-"],
            input=input_bytes,
            capture_output=True,
        )
        if result.returncode == 0:
            response = json.loads(result.stdout)
            if "errors" in response:
                raise RuntimeError(f"GraphQL errors: {json.dumps(response['errors'], indent=2)}")
            return response.get("data", {})

        err = result.stderr.decode().strip()
        # Transient errors worth retrying
        transient = (
            "REFUSED_STREAM" in err
            or "http2" in err.lower()
            or "502" in err
            or "503" in err
            or "504" in err
        )
        if transient and attempt < _retries:
            wait = 2 ** attempt  # 2, 4, 8 seconds
            print(f"   ⚠ Transient error (attempt {attempt}/{_retries}), retrying in {wait}s...")
            time.sleep(wait)
            continue

        raise RuntimeError(f"gh graphql failed:\n{err}")

    raise RuntimeError("gh graphql: exhausted retries")


# ── Parsing ────────────────────────────────────────────────────────────────────

# Matches: **Prioridade**: P0 · **Plataformas**: iOS · Android (· **Status**: ...)
# NOTE: platform section may contain multiple · separated values (e.g. "iOS · Android");
# we stop only at the next **Bold** field marker, not at the first ·.
_PRIORITY_RE = re.compile(r"\*\*Prioridade\*\*:\s*(P\d)")
_PLATFORM_RE = re.compile(r"\*\*Plataformas\*\*:\s*(.*?)(?=\s*·\s*\*\*|\n|$)")
_STATUS_RE   = re.compile(r"\*\*Status\*\*:\s*([^·\n]+)")
_IMPACT_RE   = re.compile(r"\*\*Impacto\*\*:\s*(P\d)")

# Each gap section: ### G-NNN — … up to the next ### G- or end-of-string
_GAP_SECTION_RE = re.compile(
    r"^(###\s+G-\d+\s+—.+?)(?=\n###\s+G-|\Z)",
    re.MULTILINE | re.DOTALL,
)


def _detect_platform(plat_str: str) -> str:
    has_ios     = "ios" in plat_str.lower()
    has_android = "android" in plat_str.lower()
    if has_ios and has_android:
        return "cross-platform"
    if has_ios:
        return "ios"
    if has_android:
        return "android"
    return "cross-platform"


def parse_story(path: Path, layer: str) -> Issue | None:
    text  = path.read_text(encoding="utf-8")
    lines = text.splitlines()

    # Title: first line starting with "# "
    title = next((ln[2:].strip() for ln in lines if ln.startswith("# ")), None)
    if not title:
        return None

    pm = _PRIORITY_RE.search(text)
    fm = _PLATFORM_RE.search(text)
    if not pm or not fm:
        return None  # not a story file

    priority = pm.group(1)
    platform = _detect_platform(fm.group(1))

    sm = _STATUS_RE.search(text)
    status_raw   = sm.group(1).strip().lower() if sm else ""
    status_label = "em-progresso" if "progresso" in status_raw else "backlog"

    labels = [priority, platform, layer, "story", status_label]
    return Issue(
        title=title,
        body=text,
        labels=labels,
        priority=priority,
        layer=layer,
        platform=platform,
        source_file=str(path.relative_to(ROOT)),
    )


def parse_gaps(gaps_path: Path) -> list[Issue]:
    text   = gaps_path.read_text(encoding="utf-8")
    issues = []
    for m in _GAP_SECTION_RE.finditer(text):
        section    = m.group(1).strip()
        title_line = section.splitlines()[0]
        gap_title  = "[GAP] " + re.sub(r"^###\s+", "", title_line).strip()

        im       = _IMPACT_RE.search(section)
        priority = im.group(1) if im else "P2"

        issues.append(Issue(
            title=gap_title,
            body=section,
            labels=[priority, "gap"],
            priority=priority,
            layer="gap",
            platform="cross-platform",
            source_file="GAPS.md",
        ))
    return issues


def collect_stories() -> list[Issue]:
    stories: list[Issue] = []
    for dir_name in STORY_DIRS:
        layer    = LAYER_MAP[dir_name]
        dir_path = ROOT / dir_name
        if not dir_path.exists():
            print(f"   ⚠ Directory not found, skipping: {dir_path}")
            continue
        for md_file in sorted(dir_path.rglob("*.md")):
            if md_file.name == "README.md":
                continue
            if "_template" in md_file.parts:
                continue
            issue = parse_story(md_file, layer)
            if issue:
                stories.append(issue)
    return stories


# ── Label creation ─────────────────────────────────────────────────────────────

def ensure_labels(repo: str, dry_run: bool) -> None:
    print(f"\n📌 Creating {len(LABELS)} labels...")
    existing_raw = gh_rest("GET", f"/repos/{repo}/labels?per_page=100")
    existing = {lbl["name"] for lbl in (existing_raw if isinstance(existing_raw, list) else [])}

    for label in LABELS:
        name = label["name"]
        if name in existing:
            print(f"   ↩  skip (exists): {name}")
            continue
        if dry_run:
            print(f"   [DRY] create label: {name}")
            continue
        gh_rest("POST", f"/repos/{repo}/labels", data=label)
        print(f"   ✓  created: {name}")
        time.sleep(0.1)


# ── Issue creation ─────────────────────────────────────────────────────────────

def fetch_all_repo_issues(repo: str) -> dict[str, dict]:
    """Fetch all open issues from the repo. Returns {title: issue_dict}."""
    print("   Fetching existing issues from repo...")
    all_issues: list[dict] = []
    page = 1
    while True:
        batch = gh_rest("GET", f"/repos/{repo}/issues?state=open&per_page=100&page={page}")
        if not isinstance(batch, list) or not batch:
            break
        all_issues.extend(batch)
        if len(batch) < 100:
            break
        page += 1
    by_title = {item["title"]: item for item in all_issues if "pull_request" not in item}
    print(f"   Found {len(by_title)} existing issues.")
    return by_title


def create_issues(
    repo: str,
    all_issues: list[Issue],
    dry_run: bool,
    start_from: int = 1,
) -> list[CreatedIssue]:
    created: list[CreatedIssue] = []
    total = len(all_issues)
    print(f"\n🐛 Creating issues {start_from}–{total} of {total}...")

    for i, issue in enumerate(all_issues, 1):
        if i < start_from:
            continue
        if dry_run:
            print(f"   [DRY] [{i:>3}/{total}] {issue.labels[0]} {issue.title[:70]}")
            continue

        data = {
            "title":  issue.title,
            "body":   issue.body,
            "labels": issue.labels,
        }
        resp = gh_rest("POST", f"/repos/{repo}/issues", data=data)
        ci = CreatedIssue(
            issue=issue,
            node_id=resp["node_id"],
            number=resp["number"],
            url=resp["html_url"],
        )
        created.append(ci)
        print(f"   ✓ [{i:>3}/{total}] #{resp['number']:>4}  {issue.title[:60]}")
        time.sleep(2.0)  # conservative delay to avoid secondary rate limit

    return created


# ── GitHub Project v2 ──────────────────────────────────────────────────────────

_GET_PROJECT_ID = """
query GetProject($login: String!, $number: Int!) {
  user(login: $login) {
    projectV2(number: $number) {
      id
      url
      fields(first: 20) {
        nodes {
          ... on ProjectV2SingleSelectField {
            id
            name
            options { id name }
          }
        }
      }
    }
  }
}
"""


def get_existing_project(owner: str, project_number: int) -> tuple[str, str, dict[str, dict[str, str]]]:
    """Fetch an existing project and return (project_id, project_url, field_maps)."""
    login = owner.split("/")[0] if "/" in owner else owner
    data  = gh_graphql(_GET_PROJECT_ID, {"login": login, "number": project_number})
    proj  = data["user"]["projectV2"]
    project_id  = proj["id"]
    project_url = proj["url"]

    field_maps: dict[str, dict[str, str]] = {}
    for node in proj["fields"]["nodes"]:
        if not node:  # non-SingleSelect fields come back as empty dicts
            continue
        name = node.get("name")
        fid  = node.get("id")
        opts = node.get("options", [])
        if name and fid and opts:
            field_maps[name] = {"_field_id": fid}
            for opt in opts:
                field_maps[name][opt["name"]] = opt["id"]

    return project_id, project_url, field_maps


_CREATE_PROJECT = """
mutation CreateProject($ownerId: ID!, $title: String!) {
  createProjectV2(input: {ownerId: $ownerId, title: $title}) {
    projectV2 { id number url }
  }
}
"""

_CREATE_FIELD = """
mutation CreateField(
  $projectId: ID!
  $name: String!
  $options: [ProjectV2SingleSelectFieldOptionInput!]!
) {
  createProjectV2Field(input: {
    projectId: $projectId
    dataType: SINGLE_SELECT
    name: $name
    singleSelectOptions: $options
  }) {
    projectV2Field {
      ... on ProjectV2SingleSelectField {
        id
        options { id name }
      }
    }
  }
}
"""

_ADD_ITEM = """
mutation AddItem($projectId: ID!, $contentId: ID!) {
  addProjectV2ItemById(input: {projectId: $projectId, contentId: $contentId}) {
    item { id }
  }
}
"""

_SET_FIELD = """
mutation SetField(
  $projectId: ID!
  $itemId: ID!
  $fieldId: ID!
  $optionId: String!
) {
  updateProjectV2ItemFieldValue(input: {
    projectId: $projectId
    itemId: $itemId
    fieldId: $fieldId
    value: { singleSelectOptionId: $optionId }
  }) {
    projectV2Item { id }
  }
}
"""


def _get_owner_node_id(repo: str) -> str:
    data = gh_rest("GET", f"/repos/{repo}")
    return data["owner"]["node_id"]


def create_project(owner_node_id: str, dry_run: bool) -> tuple[str, str]:
    """Returns (project_id, project_url)."""
    title = "Zodiak DS Backlog"
    if dry_run:
        print(f"\n📋 [DRY] Would create project: '{title}'")
        return ("dry_project_id", "https://github.com/users/.../projects/1")

    print(f"\n📋 Creating GitHub Project v2: '{title}'...")
    data = gh_graphql(_CREATE_PROJECT, {"ownerId": owner_node_id, "title": title})
    proj = data["createProjectV2"]["projectV2"]
    print(f"   ✓ Project #{proj['number']}: {proj['url']}")
    return proj["id"], proj["url"]


def create_custom_fields(project_id: str, dry_run: bool) -> dict[str, dict[str, str]]:
    """
    Creates Priority, Layer, Platform single-select fields.
    Returns:
        {
          "Priority": {"_field_id": "...", "P0": "opt_id", "P1": "opt_id", "P2": "opt_id"},
          "Layer":    {"_field_id": "...", "foundation": "opt_id", ...},
          "Platform": {"_field_id": "...", "ios": "opt_id", ...},
        }
    """
    fields_spec = [
        ("Priority", [
            {"name": "P0", "color": "RED",    "description": "Blocker"},
            {"name": "P1", "color": "YELLOW", "description": "High"},
            {"name": "P2", "color": "BLUE",   "description": "Medium"},
        ]),
        ("Layer", [
            {"name": n, "color": "GRAY", "description": ""}
            for n in ["foundation", "theme", "atom", "molecule", "organism", "template", "utils", "gap"]
        ]),
        ("Platform", [
            {"name": "ios",            "color": "BLUE",   "description": ""},
            {"name": "android",        "color": "GREEN",  "description": ""},
            {"name": "cross-platform", "color": "PURPLE", "description": ""},
        ]),
    ]

    print("\n🔧 Creating custom project fields...")
    field_maps: dict[str, dict[str, str]] = {}

    for field_name, options in fields_spec:
        if dry_run:
            print(f"   [DRY] Would create field: {field_name} ({len(options)} options)")
            field_maps[field_name] = {"_field_id": f"dry_{field_name}_id"}
            for o in options:
                field_maps[field_name][o["name"]] = f"dry_{o['name']}_opt"
            continue

        data = gh_graphql(_CREATE_FIELD, {
            "projectId": project_id,
            "name":      field_name,
            "options":   options,
        })
        f = data["createProjectV2Field"]["projectV2Field"]
        field_maps[field_name] = {"_field_id": f["id"]}
        for opt in f["options"]:
            field_maps[field_name][opt["name"]] = opt["id"]
        print(f"   ✓ '{field_name}' — {len(f['options'])} options")
        time.sleep(0.2)

    return field_maps


def populate_project(
    project_id: str,
    created_issues: list[CreatedIssue],
    field_maps: dict[str, dict[str, str]],
    dry_run: bool,
    start_from: int = 1,
) -> None:
    total = len(created_issues)
    print(f"\n🔗 Adding issues {start_from}–{total} to project + setting fields...")

    priority_fid = field_maps["Priority"]["_field_id"]
    layer_fid    = field_maps["Layer"]["_field_id"]
    platform_fid = field_maps["Platform"]["_field_id"]

    for i, ci in enumerate(created_issues, 1):
        if i < start_from:
            continue
        if dry_run:
            print(f"   [DRY] [{i:>3}/{total}] #{ci.number}")
            continue

        # 1. Add issue to project
        item_data = gh_graphql(_ADD_ITEM, {
            "projectId": project_id,
            "contentId": ci.node_id,
        })
        item_id = item_data["addProjectV2ItemById"]["item"]["id"]
        time.sleep(0.1)

        # 2. Set Priority
        pri_opt = field_maps["Priority"].get(ci.issue.priority)
        if pri_opt:
            gh_graphql(_SET_FIELD, {
                "projectId": project_id, "itemId": item_id,
                "fieldId": priority_fid,  "optionId": pri_opt,
            })
            time.sleep(0.05)

        # 3. Set Layer
        layer_opt = field_maps["Layer"].get(ci.issue.layer)
        if layer_opt:
            gh_graphql(_SET_FIELD, {
                "projectId": project_id, "itemId": item_id,
                "fieldId": layer_fid,    "optionId": layer_opt,
            })
            time.sleep(0.05)

        # 4. Set Platform
        plat_opt = field_maps["Platform"].get(ci.issue.platform)
        if plat_opt:
            gh_graphql(_SET_FIELD, {
                "projectId": project_id, "itemId": item_id,
                "fieldId": platform_fid, "optionId": plat_opt,
            })
            time.sleep(0.05)

        print(
            f"   ✓ [{i:>3}/{total}] #{ci.number:>4} "
            f"P={ci.issue.priority} L={ci.issue.layer:<12} "
            f"Pl={ci.issue.platform}"
        )


# ── Fix platform labels ────────────────────────────────────────────────────────

def _fix_platform_labels(repo: str, all_issues: list[Issue], dry_run: bool) -> None:
    """
    Re-parses platform from source files and corrects wrong platform labels on
    existing GitHub issues. Reads github_export_manifest.json to map source
    files to issue numbers.
    """
    manifest_path = ROOT / "scripts" / "github_export_manifest.json"
    if not manifest_path.exists():
        raise FileNotFoundError(f"Manifest not found: {manifest_path}")

    manifest: list[dict] = json.loads(manifest_path.read_text(encoding="utf-8"))
    by_source = {entry["source"]: entry for entry in manifest}

    platform_labels = {"ios", "android", "cross-platform"}
    needs_fix: list[tuple[int, str, str]] = []  # (issue_number, old_platform, new_platform)

    for issue in all_issues:
        entry = by_source.get(issue.source_file)
        if not entry:
            continue
        old_platform = entry.get("platform", "")
        new_platform = issue.platform
        if old_platform != new_platform:
            needs_fix.append((entry["number"], old_platform, new_platform))

    print(f"\n🏷  Platform label audit: {len(needs_fix)} issues need correction.")
    if not needs_fix:
        print("   ✓ All platform labels are already correct.")
        return

    # Print summary by change type
    from collections import Counter
    changes = Counter(f"{o} → {n}" for _, o, n in needs_fix)
    for change, count in sorted(changes.items()):
        print(f"   {change}: {count} issues")

    print()
    total = len(needs_fix)
    updated_manifest: dict[str, dict] = {e["source"]: e for e in manifest}

    for i, (number, old_platform, new_platform) in enumerate(needs_fix, 1):
        if dry_run:
            print(f"   [DRY] [{i:>3}/{total}] #{number:>4}  {old_platform} → {new_platform}")
            continue

        # Fetch current labels
        issue_data = gh_rest("GET", f"/repos/{repo}/issues/{number}")
        current_labels = [lbl["name"] for lbl in issue_data.get("labels", [])]

        # Swap platform label
        new_labels = [l for l in current_labels if l not in platform_labels]
        new_labels.append(new_platform)

        gh_rest("PATCH", f"/repos/{repo}/issues/{number}", data={"labels": new_labels})
        print(f"   ✓ [{i:>3}/{total}] #{number:>4}  {old_platform} → {new_platform}")
        time.sleep(0.15)

    if not dry_run:
        # Update manifest with corrected platform values
        for _, old_platform, new_platform in needs_fix:
            for entry in manifest:
                if entry.get("platform") == old_platform and entry["number"] in [n for n, _, _ in needs_fix]:
                    pass  # update below by source matching
        for issue in all_issues:
            src = issue.source_file
            if src in updated_manifest:
                updated_manifest[src]["platform"] = issue.platform

        manifest_path.write_text(
            json.dumps(list(updated_manifest.values()), indent=2, ensure_ascii=False),
            encoding="utf-8",
        )
        print(f"\n✅ Done. {total} issues updated. Manifest saved.")


# ── Main ───────────────────────────────────────────────────────────────────────

def main() -> None:
    parser = argparse.ArgumentParser(
        description="Export Zodiak backlog to GitHub Issues + Project v2",
    )
    parser.add_argument(
        "--repo",
        required=True,
        help="owner/repo — e.g. mflipe/zodiak-mobile",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print every action without actually creating anything on GitHub",
    )
    parser.add_argument(
        "--start-from",
        type=int,
        default=1,
        metavar="N",
        help="Resume: skip the first N-1 issues (1-based). Use after a rate-limit crash.",
    )
    parser.add_argument(
        "--populate-only",
        action="store_true",
        help="Skip issue creation; only create/populate the Project. "
             "Use --project-number to target an existing project.",
    )
    parser.add_argument(
        "--fix-labels",
        action="store_true",
        help="Re-parse platform from source files and fix wrong platform labels "
             "on existing issues. Reads github_export_manifest.json.",
    )
    parser.add_argument(
        "--project-number",
        type=int,
        default=0,
        metavar="N",
        help="Existing project number to use with --populate-only (e.g. 2).",
    )
    parser.add_argument(
        "--start-populate-from",
        type=int,
        default=1,
        metavar="N",
        help="Resume project population from item N (1-based).",
    )
    args = parser.parse_args()

    repo              = args.repo
    dry_run           = args.dry_run
    start_from        = args.start_from
    populate_only     = args.populate_only
    project_number    = args.project_number
    start_pop_from    = args.start_populate_from
    fix_labels        = args.fix_labels

    banner = "🔍 DRY RUN — " if dry_run else ""
    print(f"{banner}Zodiak backlog → GitHub Issues + Project")
    print(f"Repo       : {repo}")
    print(f"Root       : {ROOT}")
    if start_from > 1:
        print(f"Resuming from issue {start_from} (skipping first {start_from - 1})")
    if populate_only:
        print(f"Mode       : populate-only (project #{project_number})") 

    # ── Phase 1: Parse ────────────────────────────────────────────────────────
    print("\n📂 Parsing story files...")
    stories = collect_stories()
    print(f"   Stories : {len(stories)}")
    gaps = parse_gaps(ROOT / "GAPS.md")
    print(f"   Gaps    : {len(gaps)}")
    all_issues = stories + gaps
    print(f"   Total   : {len(all_issues)}")

    # Priority breakdown
    for p in ("P0", "P1", "P2"):
        n = sum(1 for i in all_issues if i.priority == p)
        print(f"            {p}: {n}")

    # ── --fix-labels early-exit ───────────────────────────────────────────────
    if fix_labels:
        _fix_platform_labels(repo, all_issues, dry_run)
        return

    # ── Phase 2: Labels ───────────────────────────────────────────────────────
    ensure_labels(repo, dry_run)

    # ── Phase 3: Issues ───────────────────────────────────────────────────────
    if not populate_only:
        newly_created = create_issues(repo, all_issues, dry_run, start_from=start_from)
    else:
        print("\n⏭  Skipping issue creation (--populate-only mode).")

    if dry_run:
        print(f"\n✅ Dry run complete — {len(all_issues)} issues would be created.")
        print("   Re-run without --dry-run to execute.")
        return

    # ── Phase 4: Reconcile all issues (handles resume) ────────────────────────
    # Fetch every issue in the repo so we have node_ids for issues created in
    # previous runs, then build a complete CreatedIssue list.
    print("\n🔄 Reconciling all issues for project population...")
    existing_by_title = fetch_all_repo_issues(repo)

    all_created: list[CreatedIssue] = []
    missing: list[str] = []
    for issue in all_issues:
        if issue.title in existing_by_title:
            gh_issue = existing_by_title[issue.title]
            all_created.append(CreatedIssue(
                issue=issue,
                node_id=gh_issue["node_id"],
                number=gh_issue["number"],
                url=gh_issue["html_url"],
            ))
        else:
            missing.append(issue.title)

    if missing:
        print(f"   ⚠ {len(missing)} issues not found on GitHub (will be skipped in project):")
        for t in missing:
            print(f"     – {t}")
    print(f"   ✓ {len(all_created)} issues reconciled for project.")

    # ── Phase 5: Project ──────────────────────────────────────────────────────
    if populate_only and project_number > 0:
        print(f"\n📐 Fetching existing project #{project_number}...")
        owner        = repo.split("/")[0]
        project_id, proj_url, field_maps = get_existing_project(owner, project_number)
        print(f"   ✓ Project: {proj_url}")
    else:
        owner_node_id        = _get_owner_node_id(repo)
        project_id, proj_url = create_project(owner_node_id, dry_run)
        field_maps           = create_custom_fields(project_id, dry_run)

    # ── Phase 6: Populate ─────────────────────────────────────────────────────
    populate_project(project_id, all_created, field_maps, dry_run, start_from=start_pop_from)

    # ── Save manifest ─────────────────────────────────────────────────────────
    manifest_path = ROOT / "scripts" / "github_export_manifest.json"
    manifest = [
        {
            "source":   ci.issue.source_file,
            "number":   ci.number,
            "url":      ci.url,
            "node_id":  ci.node_id,
            "priority": ci.issue.priority,
            "layer":    ci.issue.layer,
            "platform": ci.issue.platform,
        }
        for ci in all_created
    ]
    manifest_path.write_text(
        json.dumps(manifest, indent=2, ensure_ascii=False),
        encoding="utf-8",
    )

    print(f"\n🎉 Done!")
    print(f"   Issues in project : {len(all_created)}")
    print(f"   Project        : {proj_url}")
    print(f"   Manifest       : {manifest_path.relative_to(ROOT.parent.parent)}")
    print()
    print("Next steps:")
    print("  1. Open the project URL above and verify the board.")
    print("  2. In the project settings, add a 'Roadmap' view grouped by Layer.")
    print("  3. Pin the P0 filter view for contributors.")


if __name__ == "__main__":
    main()
