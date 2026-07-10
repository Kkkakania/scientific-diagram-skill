#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT="$ROOT_DIR/scripts/check_static_quality.sh"

if ! grep -Fq '$ROOT_DIR/.github' "$SCRIPT"; then
  echo "static quality scan must include .github templates" >&2
  exit 1
fi

echo "Static quality scope checks passed."
