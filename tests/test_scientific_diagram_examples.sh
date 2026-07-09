#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXAMPLE_DIR="$ROOT_DIR/skills/scientific-diagram-skill/assets/examples"

if [[ ! -x "$ROOT_DIR/scripts/check_diagram_examples.py" ]]; then
  echo "missing executable diagram example checker" >&2
  exit 1
fi

if [[ ! -s "$EXAMPLE_DIR/research-method-flow.drawio" ]]; then
  echo "missing research method drawio example" >&2
  exit 1
fi

if [[ ! -s "$EXAMPLE_DIR/research-method-flow.svg" ]]; then
  echo "missing research method SVG preview" >&2
  exit 1
fi

if [[ ! -s "$EXAMPLE_DIR/provenance.md" ]]; then
  echo "missing diagram example provenance note" >&2
  exit 1
fi

if [[ ! -s "$EXAMPLE_DIR/manifest.json" ]]; then
  echo "missing diagram example manifest" >&2
  exit 1
fi

python3 "$ROOT_DIR/scripts/check_diagram_examples.py"
python3 - "$ROOT_DIR" <<'PY'
import importlib.util
import io
import pathlib
import sys
from contextlib import redirect_stderr

root = pathlib.Path(sys.argv[1])
script = root / "scripts" / "check_diagram_examples.py"
spec = importlib.util.spec_from_file_location("check_diagram_examples", script)
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)

malicious_svg = '<svg xmlns="http://www.w3.org/2000/svg" onload="alert(1)"><title>Research method flow</title></svg>'
try:
    with redirect_stderr(io.StringIO()):
        module.check_svg_safety(root / "bad.svg", malicious_svg)
except SystemExit as exc:
    if exc.code != 1:
        raise
else:
    raise AssertionError("expected active SVG content to fail")
PY

grep -q "research-method-flow.drawio" "$ROOT_DIR/skills/scientific-diagram-skill/SKILL.md"
grep -q "research-method-flow.svg" "$ROOT_DIR/skills/scientific-diagram-skill/SKILL.md"
grep -q "manifest.json" "$ROOT_DIR/skills/scientific-diagram-skill/SKILL.md"
grep -q "check_diagram_examples.py" "$ROOT_DIR/README.md"
grep -q "check_diagram_examples.py" "$ROOT_DIR/README.zh-CN.md"
grep -q "check_diagram_examples.py" "$ROOT_DIR/docs/install-targets.md"
grep -q "manifest.json" "$ROOT_DIR/README.md"
grep -q "manifest.json" "$ROOT_DIR/README.zh-CN.md"
grep -q "example manifest" "$ROOT_DIR/docs/install-targets.md"

echo "scientific diagram examples test passed."
