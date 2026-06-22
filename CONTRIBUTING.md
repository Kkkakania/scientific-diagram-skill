# Contributing

Thanks for taking a look. This repository is small on purpose, so contributions
should stay close to the current scope: research diagrams, Mermaid drafts,
editable `.drawio` source, SVG previews, and provenance notes.

Good contributions include:

- clearer skill instructions;
- fixes to the `.drawio` or SVG example;
- better checks for private paths, copied source markers, or unsafe exports;
- small documentation changes that help a first-time user.

Do not attach private diagrams, paper figures, screenshots with hidden metadata,
local paths, email addresses, or source packs. If a diagram idea came from a
private project, describe the communication task and use synthetic labels.

Before opening a pull request, run:

```bash
./scripts/check_static_quality.sh
```

In the pull request, explain what changed, what check you ran, and whether the
change affects public provenance.
