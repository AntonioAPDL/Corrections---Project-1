# Point-by-Point Response Workbook

This repo contains the LaTeX workbook used to coordinate point-by-point responses to reviewer comments.

## Revision Control Files

- `tracker_master.csv`: canonical per-comment tracker (ID-level status across response/manuscript/evidence).
- `WORKFLOW.md`: strict operating protocol to synchronize implementation evidence, response letter text, and manuscript edits.

## Build

### Overleaf
- Upload `main.tex` (and keep it as the project entrypoint), plus the tracked
  generated response-table fragments under `tables/generated_tex/`.
- Compile with pdfLaTeX (TeX Live 2025).

Generated response fragments currently required by `main.tex`:

- `tables/generated_tex/he2_benchmark_crps_response_table.tex`
- `tables/generated_tex/he3_ablation_crps_response_table.tex`
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
