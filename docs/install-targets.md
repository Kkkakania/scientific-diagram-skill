# Install Targets

The distributable unit is `skills/scientific-diagram-skill`. Copy or symlink
that folder into a location your runtime scans for skills.

## Project-local install

Use a project-local directory when the project should pin the skill version:

```bash
mkdir -p .agents/skills
cp -R skills/scientific-diagram-skill .agents/skills/scientific-diagram-skill
```

## User-level examples

Choose the directory supported by the runtime:

| Runtime | Example destination |
|---|---|
| Codex | `~/.codex/skills/scientific-diagram-skill` |
| Claude Code | `~/.claude/skills/scientific-diagram-skill` |
| Generic agent directory | `~/.agents/skills/scientific-diagram-skill` |

Replace the destination with the directory expected by the runtime. Verify that
the installed folder contains `SKILL.md`, `references/`, and `assets/`.

## Verify the checkout

```bash
python3 scripts/check_diagram_examples.py
./tests/test_scientific_diagram_skill.sh
./tests/test_scientific_diagram_examples.sh
```

These checks validate the example `.drawio` source, SVG preview, provenance
note, example manifest, skill metadata, and README references.
For CI inventory, add `--format json`; each example record includes the
validated Draw.io vertex and edge counts.

The install commands only place files on disk. Installation does not edit
runtime configuration, enable plugins, send data, or grant network access.
