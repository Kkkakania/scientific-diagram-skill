# Scientific Diagram Skill

[English](README.md) | [简体中文](README.zh-CN.md)

[![Quality](https://github.com/Kkkakania/scientific-diagram-skill/actions/workflows/quality.yml/badge.svg)](https://github.com/Kkkakania/scientific-diagram-skill/actions/workflows/quality.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

`scientific-diagram-skill` is a small Codex skill for research diagrams. It
helps an agent draft Mermaid diagrams first, then move to editable draw.io /
diagrams.net files when the diagram needs layout control or a reusable source
file.

The repository is intentionally narrow. It covers method flows, system block
diagrams, signal chains, experiment pipelines, and maintainer workflow diagrams.
It does not generate data plots. For numeric MATLAB figures, use
[`matlab-plotting-skill`](https://github.com/Kkkakania/matlab-plotting-skill)
or [`matlab-scientific-figures`](https://github.com/Kkkakania/matlab-scientific-figures).

## Why this exists

Research projects often need two different kinds of visuals:

- data figures, where the main risk is choosing the right chart and preserving
  numeric meaning;
- diagrams, where the main risk is copying a paper figure, hiding private
  metadata, or handing off an image that nobody can edit later.

This skill handles the second case. It keeps `.drawio` source, SVG preview, and
provenance notes together so a maintainer can review what is public.

## Install

Copy the skill folder into your Codex skill directory:

```bash
mkdir -p ~/.codex/skills
cp -R skills/scientific-diagram-skill ~/.codex/skills/
```

Then ask Codex for tasks such as:

```text
Use scientific-diagram-skill to sketch this method pipeline.
Review this draw.io experiment diagram before I put it in a README.
Turn this system description into Mermaid first, then create an editable draw.io source.
```

See [`docs/install-targets.md`](docs/install-targets.md) for project-local
installation and verification commands.
For first-use reports, use [`docs/first-use-feedback.md`](docs/first-use-feedback.md),
then open the
[diagram feedback form](https://github.com/Kkkakania/scientific-diagram-skill/issues/new?template=diagram_feedback.md).

## What the skill contains

- `SKILL.md`: activation metadata and the core workflow.
- `references/drawio-workflow.md`: practical `.drawio` file guidance.
- `references/diagram-quality-checklist.md`: review checklist for research
  diagrams.
- `references/export-and-provenance.md`: public export and provenance rules.
- `assets/examples/research-method-flow.drawio`: editable example source.
- `assets/examples/research-method-flow.svg`: matching preview.
- `assets/examples/provenance.md`: note explaining how the example was made.

## Check the example

Run the local checks before changing the bundled example:

```bash
python3 scripts/check_diagram_examples.py
./tests/test_scientific_diagram_skill.sh
./tests/test_scientific_diagram_examples.sh
```

The checker parses the `.drawio` XML and SVG preview, verifies expected labels,
and scans for private paths, email addresses, source-platform traces, and common
personal-data keywords.

## Contributing and safety

Use [CONTRIBUTING.md](CONTRIBUTING.md) for pull requests and
[SECURITY.md](SECURITY.md) for privacy or provenance concerns. Do not paste
private diagrams, screenshots, local paths, or copied paper figures into public
issues.

## Relationship to the plotting repos

This repository is part of the same public research-figure workflow:

- [`matlab-scientific-figures`](https://github.com/Kkkakania/matlab-scientific-figures)
  keeps clean-room MATLAB chart templates and gallery outputs.
- [`matlab-figure-ci`](https://github.com/Kkkakania/matlab-figure-ci) checks
  privacy, provenance, forbidden files, gallery files, and optional MATLAB
  rendering.
- [`matlab-plotting-skill`](https://github.com/Kkkakania/matlab-plotting-skill)
  helps agents choose and render MATLAB figures.
- [`python-plotting-skill`](https://github.com/Kkkakania/python-plotting-skill)
  provides the Python plotting counterpart.

The goal is practical maintenance, not fake adoption numbers. The skill is small
because diagrams need clear boundaries more than a large template dump.

## Public-source rules

- Use synthetic labels and clean-room structure for examples.
- Do not trace figures from papers, slides, screenshots, Nature/Science examples,
  or private files.
- Do not commit hidden signatures, emails, school names, local paths, logos, raw
  screenshots, or binary source bundles.
- Keep `.drawio` source and SVG preview together when a diagram belongs in docs.
- Write a short provenance note for public examples.

## Current limits

- The bundled example is intentionally small.
- The skill does not call diagrams.net automatically.
- It does not claim a rendered diagram is paper-ready without human review.
- It is a skill package, not a full diagram editor.

## License

MIT.
