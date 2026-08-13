# Point-by-Point Response Letter

This repo contains the LaTeX source for the revised point-by-point response to
the editor and reviewers.

## Main Files

- `main.tex`: response-letter source used by Overleaf
- `figures/`: response-only version-coverage timeline figures
- `tables/generated_tex/`: generated response table fragments synchronized from
  the revised article repository

## Build

### Overleaf
- Upload `main.tex` and keep it as the project entrypoint.
- Compile with pdfLaTeX (TeX Live 2025).

Generated response fragments are tracked under `tables/generated_tex/` as
synchronized validation/provenance artifacts. They are not currently inserted
into `main.tex`; the response letter instead points readers to the corresponding
tables in the revised manuscript.

- `tables/generated_tex/he2_benchmark_crps_response_table.tex`
- `tables/generated_tex/he2_benchmark_crps_nws_horizon_response_table.tex`
- `tables/generated_tex/he3_ablation_crps_response_table.tex`
- `tables/generated_tex/he3_ablation_crps_nws_horizon_response_table.tex`
- `tables/generated_tex/he4_quantile_check_loss_response_table.tex`

For future HE2 publication-authority refreshes, do not hand-edit these numeric
tables. Promote and validate the new authority in the workflow repo, refresh the
revised article freeze, then regenerate the corrections fragments with:

```bash
python3 /data/muscat_data/jaguir26/project1_ucsc_phd/Evironmetrics---REVISED-DOC-Corrected-2/scripts/sync_corrections_generated_table_includes.py \
  --article-root /data/muscat_data/jaguir26/project1_ucsc_phd/Evironmetrics---REVISED-DOC-Corrected-2 \
  --corrections-root /data/muscat_data/jaguir26/Corrections---Project-1
```

The full cross-repo authority-refresh runbook is:

- `/data/muscat_data/jaguir26/project1_ucsc_phd/docs/current_authority_refresh_runbook.md`

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
