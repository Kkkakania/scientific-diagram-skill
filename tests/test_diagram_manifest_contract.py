#!/usr/bin/env python3
from __future__ import annotations

import importlib.util
import contextlib
import io
import json
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
        manifest = tmp_root / "manifest.json"
        manifest.write_text(
            json.dumps(
                {
                    "schemaVersion": 1,
                    "exampleCount": 1,
                    "examples": [
                        {
                            "id": "research-method-flow",
                            "drawio": "research-method-flow.drawio",
                            "svg": "research-method-flow.svg",
                            "provenance": "provenance.md",
                            "privateData": True,
                        }
                    ],
                }
            ),
            encoding="utf-8",
        )

        checker.ROOT = tmp_root
        checker.MANIFEST = manifest
        try:
            with contextlib.redirect_stderr(io.StringIO()):
                checker.check_manifest()
        except SystemExit as exc:
            if int(exc.code) == 1:
                print("diagram manifest contract test passed")
                return 0
            return int(exc.code)

    print("manifest privateData=true should fail")
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
