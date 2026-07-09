#!/usr/bin/env python3
from __future__ import annotations

import contextlib
import importlib.util
import io
import pathlib
import tempfile


ROOT = pathlib.Path(__file__).resolve().parents[1]


def load_checker():
    path = ROOT / "scripts" / "check_diagram_examples.py"
    spec = importlib.util.spec_from_file_location("check_diagram_examples", path)
    if spec is None or spec.loader is None:
        raise RuntimeError("could not load check_diagram_examples.py")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def main() -> int:
    checker = load_checker()
    with tempfile.TemporaryDirectory() as tmp:
        tmp_root = pathlib.Path(tmp)
        svg = tmp_root / "bad.svg"
        svg.write_text(
            '<svg xmlns="http://www.w3.org/2000/svg"><title>Research method flow</title><SCRIPT>alert(1)</SCRIPT></svg>',
            encoding="utf-8",
        )
        checker.ROOT = tmp_root
        checker.SVG = svg
        try:
            with contextlib.redirect_stderr(io.StringIO()):
                checker.check_svg()
        except SystemExit as exc:
            if int(exc.code) == 1:
                print("diagram SVG contract test passed")
                return 0
            return int(exc.code)

    print("uppercase SVG script marker should fail")
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
