# Point-by-Point Response Workbook

This repo contains the LaTeX workbook used to coordinate point-by-point responses to reviewer comments.

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
