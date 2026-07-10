#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PRIVATE_MARKER_PATTERN='(/[Uu]sers/|/[Hh]ome/|/[Mm]nt/[A-Za-z]/|[A-Za-z]:\\+[Uu]sers\\+|%USERPROFILE%[\\/]|/workspaces/|/Volumes/|[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}|身份证|银行卡|手机号|家庭住址|微信号)'

"$ROOT_DIR/tests/test_scientific_diagram_skill.sh"
"$ROOT_DIR/tests/test_scientific_diagram_examples.sh"
"$ROOT_DIR/tests/test_repository_contract.sh"
"$ROOT_DIR/tests/test_static_quality_scope.sh"
"$ROOT_DIR/tests/test_static_quality_private_patterns.sh"

QUALITY_SCAN_ROOTS=(
  "$ROOT_DIR/README.md"
  "$ROOT_DIR/README.zh-CN.md"
  "$ROOT_DIR/CONTRIBUTING.md"
  "$ROOT_DIR/SECURITY.md"
  "$ROOT_DIR/.github"
  "$ROOT_DIR/docs"
  "$ROOT_DIR/skills"
)

if grep -RInE "seamless|game-changing|行业领先|赋能|一站式" "${QUALITY_SCAN_ROOTS[@]}"; then
  echo "hype wording found" >&2
  exit 1
fi

if grep -RInE "$PRIVATE_MARKER_PATTERN" "${QUALITY_SCAN_ROOTS[@]}"; then
  echo "private marker found" >&2
  exit 1
fi

echo "Static quality checks passed."
