# LFS101 — Linux Foundations (Independent Production Simulation)

This repository contains an independently authored course-aligned summary and a production-grade single-node Linux workstation simulation. It is intended for learning, teaching, and portfolio presentation.

## What is included
- `course-summary/` — Chapter-by-chapter Markdown summaries aligned with LFS101
- `project/` — Production-grade simulation: implementation, scripts, and validation
- `assets/` — Diagrams and assets used in documentation

## Quickstart (developer/testing)
1. Clone the repo
```bash
git clone <repo-url>
cd lfs101-linux-foundations
````

2. Inspect scripts and run local linters

```bash
# install shellcheck and markdownlint-cli
# Debian/Ubuntu example
sudo apt update && sudo apt install -y shellcheck
npm install -g markdownlint-cli

# run checks
shellcheck project/scripts/*.sh
markdownlint '**/*.md'
```

3. Review `project/implementation.md` for step-by-step setup

## Repository Structure

Refer to `repo-tree.txt` or top-level folders. Key directories:

* `course-summary/`
* `project/` (scripts, systemd units, docs)
* `assets/` (diagrams)

## License

This project is released under the MIT License. See `LICENSE` for details.

## Contributing

See `CONTRIBUTING.md` for contribution guidelines, code style, and PR workflow.

## Contact

For questions or security disclosures, open an issue or contact fadynabilfadymofeed@gmail.com.
