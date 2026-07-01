#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

require_file() {
  local file="$1"
  if [[ ! -s "$ROOT_DIR/$file" ]]; then
    echo "missing or empty required file: $file" >&2
    exit 1
  fi
}

require_text() {
  local file="$1"
  local text="$2"
  if ! grep -Fq "$text" "$ROOT_DIR/$file"; then
    echo "missing text in $file: $text" >&2
    exit 1
  fi
}

require_file "CONTRIBUTING.md"
require_file "SECURITY.md"
require_file "docs/first-use-feedback.md"
require_file ".github/pull_request_template.md"
require_file ".github/workflows/issue-triage.yml"
require_file ".github/ISSUE_TEMPLATE/diagram_feedback.md"
require_file ".github/ISSUE_TEMPLATE/config.yml"

require_text "README.md" "CONTRIBUTING.md"
require_text "README.md" "SECURITY.md"
require_text "README.md" "docs/first-use-feedback.md"
require_text "README.md" "actions/workflows/quality.yml/badge.svg"
require_text "README.zh-CN.md" "CONTRIBUTING.md"
require_text "README.zh-CN.md" "SECURITY.md"
require_text "README.zh-CN.md" "docs/first-use-feedback.md"
require_text "README.zh-CN.md" "actions/workflows/quality.yml/badge.svg"
require_text "README.md" "issues/new?template=diagram_feedback.md"
require_text "README.zh-CN.md" "issues/new?template=diagram_feedback.md"
require_text "docs/first-use-feedback.md" "issues/new?template=diagram_feedback.md"
if grep -Fq "scientific-diagram-skill/issues/1" "$ROOT_DIR/README.md" "$ROOT_DIR/README.zh-CN.md" "$ROOT_DIR/docs/first-use-feedback.md"; then
  echo "stale feedback hub issue link remains" >&2
  exit 1
fi
require_text "docs/first-use-feedback.md" "What Not To Include"
require_text "docs/first-use-feedback.md" "redacted description"
require_text "CONTRIBUTING.md" "Do not attach private diagrams"
require_text "SECURITY.md" "do not open a"
require_text ".github/pull_request_template.md" "Provenance"
require_text ".github/workflows/issue-triage.yml" "scientific-diagram-skill-triage"
require_text ".github/workflows/issue-triage.yml" "private diagrams"
require_text ".github/workflows/issue-triage.yml" "not a claim about adoption"
require_text ".github/ISSUE_TEMPLATE/diagram_feedback.md" "No private diagrams"

echo "Repository contract checks passed."
