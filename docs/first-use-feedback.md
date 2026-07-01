# First-Use Feedback

Use this note before reporting a first run of `scientific-diagram-skill`.
The goal is to make feedback useful without exposing private diagrams or source
material.

## What To Include

- Diagram job: method flow, system block diagram, signal chain, experiment
  pipeline, comparison map, or maintainer workflow.
- Starting point: plain text, Mermaid draft, existing `.drawio`, or a redacted
  description of a private diagram.
- Output needed: Mermaid only, editable `.drawio`, SVG preview, or a short
  review checklist.
- Handoff friction: labels too long, layout too dense, provenance unclear,
  export format wrong, or missing verification command.
- Verification: whether `python3 scripts/check_diagram_examples.py` or
  `./scripts/check_static_quality.sh` was run.

## What Not To Include

- Private diagrams, screenshots, slide decks, copied paper figures, or raw
  exports with hidden metadata.
- Local absolute paths, school or lab names, email addresses, personal names,
  private logos, or watermark text.
- Claims that the diagram is accepted, endorsed, paper-ready, or externally
  adopted.

## Short Report Template

```text
Diagram job:
Starting point:
Output needed:
What worked:
What was confusing:
Verification run:
Public-source boundary:
```

For public issue feedback, use the
[diagram feedback form](https://github.com/Kkkakania/scientific-diagram-skill/issues/new?template=diagram_feedback.md).
Keep the report short; a redacted description is enough.
