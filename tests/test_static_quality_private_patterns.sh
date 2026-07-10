#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
pattern="$(sed -n "s/^PRIVATE_MARKER_PATTERN='\(.*\)'/\1/p" "$ROOT_DIR/scripts/check_static_quality.sh")"

if [[ -z "$pattern" ]]; then
  echo "PRIVATE_MARKER_PATTERN is not defined" >&2
  exit 1
fi

printf '%s\n' 'C:\Users\Example\diagram.svg' | grep -Eq "$pattern"
printf '%s\n' 'C:\\Users\\Example\\diagram.svg' | grep -Eq "$pattern"

echo "static private marker pattern test passed."
