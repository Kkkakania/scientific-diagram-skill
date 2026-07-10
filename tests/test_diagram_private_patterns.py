#!/usr/bin/env python3
from __future__ import annotations

import contextlib
import importlib.util
import io
import pathlib


ROOT = pathlib.Path(__file__).resolve().parents[1]


def load_checker():
    path = ROOT / "scripts" / "check_diagram_examples.py"
    spec = importlib.util.spec_from_file_location("check_diagram_examples", path)
    if spec is None or spec.loader is None:
        raise RuntimeError("could not load check_diagram_examples.py")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def expect_private_marker(checker, text: str) -> None:
    try:
        with contextlib.redirect_stderr(io.StringIO()):
            checker.check_no_private_markers(ROOT / "sample.txt", text)
    except SystemExit as exc:
        if int(exc.code) == 1:
            return
        raise
    raise AssertionError(f"expected private marker for: {text}")


def main() -> int:
    checker = load_checker()
    expect_private_marker(checker, "author: copied source")
    expect_private_marker(checker, "copyright copied source")
    print("diagram private pattern test passed")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
