# Corrections Workflow (Strict One-by-One)

This file defines the operating workflow for revision work across:

- Evidence/results repo: `/data/muscat_data/jaguir26/project1_ucsc_phd`
- Response workbook repo: `/data/muscat_data/jaguir26/Corrections---Project-1`
- Manuscript repo: `/data/muscat_data/jaguir26/Environmetrics_paper_repo`

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
4. Apply manuscript updates in `Environmetrics_paper_repo`.
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

## Notes

- Keep edits atomic by ID to avoid drift between response and manuscript.
- Do not mark an item complete without explicit location/evidence references.
- If a row requires new analysis, set `status=blocked` with a concrete unblock note.
