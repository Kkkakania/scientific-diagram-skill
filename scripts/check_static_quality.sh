#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

"$ROOT_DIR/tests/test_scientific_diagram_skill.sh"
"$ROOT_DIR/tests/test_scientific_diagram_examples.sh"
"$ROOT_DIR/tests/test_repository_contract.sh"

if grep -RInE "seamless|game-changing|行业领先|赋能|一站式" "$ROOT_DIR/README.md" "$ROOT_DIR/README.zh-CN.md" "$ROOT_DIR/docs" "$ROOT_DIR/skills"; then
  echo "hype wording found" >&2
  exit 1
fi

if grep -RInE "(/Users/|/home/|C:\\\\Users\\\\|[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}|身份证|银行卡|手机号|家庭住址|微信号)" "$ROOT_DIR/README.md" "$ROOT_DIR/README.zh-CN.md" "$ROOT_DIR/docs" "$ROOT_DIR/skills"; then
  echo "private marker found" >&2
  exit 1
fi

echo "Static quality checks passed."
