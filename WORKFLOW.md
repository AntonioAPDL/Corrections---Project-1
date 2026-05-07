# Corrections Workflow (Strict One-by-One)

This file defines the operating workflow for revision work across:

- Evidence/results repo: `/data/muscat_data/jaguir26/project1_ucsc_phd`
- Response workbook repo: `/data/muscat_data/jaguir26/Corrections---Project-1`
- Revised manuscript repo: `/data/muscat_data/jaguir26/project1_ucsc_phd/Evironmetrics---REVISED-DOC-2`

## Current source-of-truth rule

For the current revision cycle:

- the workflow/evidence source of truth lives in:
  - `/data/muscat_data/jaguir26/project1_ucsc_phd`
- the manuscript-local freeze point for generated figures/tables/audits lives in:
  - `/data/muscat_data/jaguir26/project1_ucsc_phd/Evironmetrics---REVISED-DOC-2/generated`
- the corrections letter should align to the revised manuscript repo above, not to the older `Environmetrics_paper_repo` path.

Key revised-manuscript references:
- manuscript provenance:
  - `/data/muscat_data/jaguir26/project1_ucsc_phd/Evironmetrics---REVISED-DOC-2/FIGURE_TABLE_PROVENANCE.md`
- manuscript revision checklist:
  - `/data/muscat_data/jaguir26/project1_ucsc_phd/Evironmetrics---REVISED-DOC-2/MANUSCRIPT_REVISION_CHECKLIST.md`
- generated-asset manifest:
  - `/data/muscat_data/jaguir26/project1_ucsc_phd/Evironmetrics---REVISED-DOC-2/ARTICLE_GENERATED_ASSET_MANIFEST.json`
- generated asset index:
  - `/data/muscat_data/jaguir26/project1_ucsc_phd/Evironmetrics---REVISED-DOC-2/generated/README.md`
- generated figure selection + table includes:
  - `/data/muscat_data/jaguir26/project1_ucsc_phd/Evironmetrics---REVISED-DOC-2/generated/article_asset_selection/selection_manifest.json`
  - `/data/muscat_data/jaguir26/project1_ucsc_phd/Evironmetrics---REVISED-DOC-2/generated/article_table_includes/README.md`
- current HE2 historical-support audit snapshot:
  - `/data/muscat_data/jaguir26/project1_ucsc_phd/Evironmetrics---REVISED-DOC-2/generated/he2_historical_support_audit_20260507/historical_support_audit.md`

## Canonical Tracker

Use `tracker_master.csv` as the single source of truth for each editor/reviewer ID.

Core fields:

- `status`: `todo`, `in_progress`, `blocked`, `done`
- `response_stage`: status of response text in `main.tex`
- `manuscript_stage`: status of manuscript edits in paper repo
- `evidence_stage`: status of figures/tables/results mapping

## Execution Protocol (per ID)

1. Move one row to `in_progress`.
2. Capture evidence paths from `project1_ucsc_phd`.
3. Draft exact response text in `main.tex` for that ID.
4. Apply manuscript updates in `Evironmetrics---REVISED-DOC-2`.
5. Record figure/table references and target sections.
6. Compile/check docs.
7. Mark row `done` only when response + manuscript + evidence are all complete.

## Revision Themes To Cover

- Retrospective/forecast version matching policy (GloFAS and NWS/NWM).
- Synthetic retrospective construction and rationale.
- Transfer function during the forecast window.
- Forecast covariates (including soil moisture and precipitation forecasts).
- Updated discount-factor setup and Wishart epsilon sensitivity results.
- Cross-link every claim to explicit figures/tables/evidence files.
- Treat the revised article repo `generated/` directory as the manuscript-local evidence freeze point whenever the response letter references current figures/tables/audits.
- When figures or model-derived tables change, refresh the revised article repo first via `scripts/refresh_all_generated_assets.py`; then re-read the refreshed article-side bundles before editing the corrections letter.

## Notes

- Keep edits atomic by ID to avoid drift between response and manuscript.
- Do not mark an item complete without explicit location/evidence references.
- If a row requires new analysis, set `status=blocked` with a concrete unblock note.
- When workflow reruns or regenerated assets change the evidence base, refresh the revised article repo bundles first, then update the corrections text against that refreshed manuscript-local state.
