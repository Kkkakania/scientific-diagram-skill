# Install targets

## Codex user install

```bash
mkdir -p ~/.codex/skills
cp -R skills/scientific-diagram-skill ~/.codex/skills/
```

## Project-local install

Use this when you want the skill checked into a project instead of your global
Codex directory:

```bash
mkdir -p .codex/skills
cp -R skills/scientific-diagram-skill .codex/skills/
```

## Verify the checkout

```bash
python3 scripts/check_diagram_examples.py
./tests/test_scientific_diagram_skill.sh
./tests/test_scientific_diagram_examples.sh
```

These checks validate the example `.drawio` source, SVG preview, provenance
note, skill metadata, and README references.
