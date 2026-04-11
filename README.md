# Point-by-Point Response Workbook

This repo contains the LaTeX workbook used to coordinate point-by-point responses to reviewer comments.

## Revision Control Files

- `tracker_master.csv`: canonical per-comment tracker (ID-level status across response/manuscript/evidence).
- `WORKFLOW.md`: strict operating protocol to synchronize implementation evidence, response letter text, and manuscript edits.

## Build

### Overleaf
- Upload `main.tex` (and keep it as the project entrypoint).
- Compile with pdfLaTeX (TeX Live 2025).

### Local
If `latexmk` is available:

```bash
latexmk -pdf -interaction=nonstopmode -halt-on-error main.tex
```

If `latexmk` is not available:

```bash
pdflatex -interaction=nonstopmode -halt-on-error main.tex
pdflatex -interaction=nonstopmode -halt-on-error main.tex
```

### Makefile shortcut

```bash
make
```

Clean auxiliary files:

```bash
make clean
```
