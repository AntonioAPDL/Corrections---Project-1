# Corrections Article Crosswalk Audit Plan

Date: 2026-06-14

## Purpose

This plan defines the next one-by-one audit pass connecting:

- the response letter in `Corrections---Project-1/main.tex`;
- the revised manuscript in
  `project1_ucsc_phd/Evironmetrics---REVISED-DOC-Corrected-2/wileyNJD-APA.tex`;
- the current authoritative workflow evidence in `project1_ucsc_phd`;
- generated manuscript tables/figures and article-local artifacts.

The current numerical outputs are frozen as the authoritative baseline for this
revision snapshot. The goal now is not to relaunch models. The goal is to make
every response claim traceable to exact revised-manuscript text, tables,
figures, or documented evidence, and then polish the response/manuscript wording
one reviewer item at a time with user confirmation.

## Current Baseline

Repos and heads at audit kickoff:

| Repo | Branch | Current role |
|---|---|---|
| `project1_ucsc_phd` | `feature/export_posterior_tables` | workflow/evidence source of truth |
| `Evironmetrics---REVISED-DOC-Corrected-2` | `main` | revised manuscript and manuscript-local artifact freeze |
| `Corrections---Project-1` | `main` | response letter and response-side generated tables |

Authoritative planning document:

`/data/muscat_data/jaguir26/project1_ucsc_phd/docs/current_publication_authority_cleanup_and_corrections_audit_plan_20260614.md`

Current manuscript-local evidence surface:

- `MANUSCRIPT_ASSET_MANIFEST.json`;
- `artifacts/`;
- `figures/`;
- `tables/generated_tex/`;
- `reports/manuscript_asset_review/`;
- `docs/figure_table_provenance.md`;
- `docs/manuscript_revision_checklist.md`.

Current corrections generated-table surface:

- `tables/generated_tex/he2_benchmark_crps_response_table.tex`;
- `tables/generated_tex/he3_ablation_crps_response_table.tex`;
- `tables/generated_tex/he3_ablation_crps_nws_horizon_response_table.tex`;
- `tables/generated_tex/he4_quantile_check_loss_response_table.tex`.

## Working Rule

For each editor/reviewer item:

1. audit the current response text;
2. identify the exact revised-manuscript location(s) that implement the promise;
3. check generated table/figure references and values;
4. decide whether the response is already complete, needs manuscript prose, needs
   response prose, or needs both;
5. ask for confirmation on the item-level interpretation before editing text;
6. edit only that item and its directly linked manuscript text;
7. compile and validate before marking the item complete.

Do not hand-edit generated TeX tables. Regenerate from the article/workflow
source scripts if a generated table must change.

## Global Validation Gates

Run these after any substantive response/manuscript edit:

```bash
python3 -m unittest discover -s tests
```

from the revised article repo.

```bash
python3 scripts/validate_revision_cross_repo_wiring.py \
  --workflow-root /data/muscat_data/jaguir26/project1_ucsc_phd \
  --article-root /data/muscat_data/jaguir26/project1_ucsc_phd/Evironmetrics---REVISED-DOC-Corrected-2 \
  --corrections-root /data/muscat_data/jaguir26/Corrections---Project-1 \
  --output-dir reports/revision_cross_repo_wiring_check_CURRENT \
  --check-only --strict

python3 scripts/validate_publication_freeze.py \
  --workflow-root /data/muscat_data/jaguir26/project1_ucsc_phd \
  --article-root /data/muscat_data/jaguir26/project1_ucsc_phd/Evironmetrics---REVISED-DOC-Corrected-2 \
  --corrections-root /data/muscat_data/jaguir26/Corrections---Project-1 \
  --require-clean
```

from the workflow repo, after tracked edits are committed.

Compile the response letter after any response edit:

```bash
pdflatex -interaction=nonstopmode -halt-on-error main.tex
```

Compile the revised manuscript after manuscript edits:

```bash
pdflatex -interaction=nonstopmode -halt-on-error -jobname=output wileyNJD-APA.tex
bibtex output
pdflatex -interaction=nonstopmode -halt-on-error -jobname=output wileyNJD-APA.tex
pdflatex -interaction=nonstopmode -halt-on-error -jobname=output wileyNJD-APA.tex
```

## Manuscript Anchor Map

Current revised-manuscript structure:

| Section | Lines at kickoff | Main role |
|---|---:|---|
| Introduction | `68-80` | motivation, uncertainty separation, contribution framing |
| Methodology | `82-239` | model, inference, CRPS selection |
| Application data and forecasting design | `240-343` | data roles, forecast covariates, model spec, rolling-origin design |
| Forecast validation results | `345-377` | HE2/HE3/HE4 tables and interpretation |
| Interpretation of selected specification | `378-430` | covariates, regime diagnostics, synthesis illustration |
| Conclusions | `432-443` | final summary and operational caveats |
| Code availability | `451-455` | package/repo availability |
| Supplementary material | `472+` | parameter summaries, long-cycle figure, historical-only synthesis, setup panels |

Important labels:

- `tab:benchmark_crps_models`;
- `tab:benchmark_crps_models_nws_horizon`;
- `tab:he3_ablation_crps`;
- `tab:he3_ablation_crps_nws_horizon`;
- `tab:he4_quantile_check_loss`;
- `fig:sanlorenzo`, `fig:covariates`, `fig:retrospectives`, `fig:ensembles`;
- `fig:dry_quantile`, `fig:rainy_quantile`, `fig:synth1`,
  `fig:80_components`, `fig:synth2`;
- `fig:setupsupport_20210123`, `fig:setupsupport_20211112`,
  `fig:setupsupport_20211221`, `fig:setupsupport_20220511`.

## Item-By-Item Checklist

Status legend:

- `needs_audit`: inspect response, manuscript, and evidence before editing.
- `likely_complete`: appears implemented but still needs exact cross-reference
  and confirmation.
- `needs_polish`: implemented in substance, but wording/cross-reference likely
  needs tightening.
- `needs_manuscript_text`: response promises text that is not clearly present in
  the revised manuscript.
- `needs_decision`: requires user/advisor wording or policy decision.

### Handling Editor

| ID | Current status | Evidence / manuscript anchors | Audit question | Confirmation gate |
|---|---|---|---|---|
| HE-1 computational cost and feasibility | `done` | Response `main.tex` around HE-1; manuscript posterior computation `208-223`; article runtime manifest `artifacts/runtime_benchmark/runtime_manifest.json`; workflow contract `docs/he1_runtime_feasibility_contract_20260615.md` | The response and manuscript now report a representative total wall-clock runtime benchmark only. They use `runtime_sec_total` / `runtime_sec`, retain the 1620 completed interface-row versus 54 done/18 pending planned-run nuance, and avoid the unsupported 100-minute fitting / 20-minute post-processing split. | If the raw runtime worktree is mounted later, regenerate the compact runtime manifest from the source CSV before changing numerical claims. |
| HE-2 validation against alternatives/raw products/exAL vs AL | `done` | Manuscript `348-363`; tables `tab:benchmark_crps_models`, `tab:benchmark_crps_models_nws_horizon`; response HE-2 generated 28-day table and HE-2 generated NWS-horizon table | Response now matches the horizon split: the 28-day table excludes NWS, the separate eight-day table includes NWS, and `N` rows are normal DLM baselines rather than quantile lanes. | Re-run the revised-article table sync script after any future calibration refresh so the response fragments stay generated from the manuscript table bodies. |
| HE-3 ablation study | `done` | Manuscript main-text pointer near Forecast Validation Results; appendix `app:he3ablation`; tables `tab:he3_ablation_crps`, `tab:he3_ablation_crps_nws_horizon`; response HE-3 generated tables | Response and manuscript now place the ablation as an appendix sensitivity analysis, preserve both horizon contracts, and define `noH3` as the retained noninteger seasonal frequency \(1/6.8068493\). | Re-run article table generation and corrections-table sync after any future selected-model refresh. |
| HE-4 CRPS and quantile diagnostics | `done` | Manuscript `223-238` and `351-365`; table `tab:he4_quantile_check_loss`; response HE-4 | CRPS is described as both a model-selection and out-of-sample forecast-validation score; quantile check-loss diagnostics are generated from the current HE2 publication manifest and reported for the four principal synthesis competitors. | Completed with restrained cutoff--quantile interpretation, no retained PIT analysis, and generated-table sync validation. |
| HE-5 code/reproducibility | `done_pending_final_archive_doi` | Manuscript code availability `443-447`; response HE-5; article software manifest `artifacts/software_availability/software_availability_manifest.json`; workflow contract `repro/run/REVISION_SOFTWARE_REPRODUCIBILITY_CONTRACT_20260615.md` | The revised manuscript and response now cite the CRAN `exdqlm` package, the CRAN package DOI, and the public workflow repository. The workflow archive DOI is intentionally pending until final revision freeze. | Before final resubmission, create the permanent workflow release/archive, replace `pending` DOI fields, and re-run the cross-repo validators and compiles. |
| HE-6 out-of-sample validation | `done` | Manuscript data-role and rolling-origin paragraphs; response HE-6; article `artifacts/forecast_design/forecast_design_manifest.json`; workflow `docs/he6_out_of_sample_forecast_design_contract_20260615.md` | The revised article and response now explicitly distinguish fit-time inputs, forecast-origin inputs, and held-out post-cutoff USGS verification. Forecast-window PPT/SOIL enter as transfer covariates from the staged origin bundle, while GDPC/PCA is the canonical deterministic climate-index covariate rather than an operational forecast product. | Keep the compact forecast-design manifest, workflow contract, article test, and cross-repo validators synchronized after any future input-bundle protocol change. |
| HE-7 latest-forecast-only protocol | `done` | Manuscript `332-336`; response HE-7; article `artifacts/latest_forecast_issue/latest_forecast_issue_manifest.json`; workflow `docs/he7_latest_forecast_issue_contract_20260615.md`; figures `fig:ensembles` and cutoff support panels | Response and manuscript now state the source-specific latest-only rule: GloFAS uses the cutoff daily issue, NWS uses the most recent available issuance per target/member before daily aggregation, and older issuances are not averaged into publication matrices. | Completed with HE-7 contract tests and cross-repo validators; legacy `weighted_daily` names are documented as compatibility aliases. |

### Reviewer 1 Overview And Major Comments

| ID | Current status | Evidence / manuscript anchors | Audit question | Confirmation gate |
|---|---|---|---|---|
| R1-O overview / forecasting emphasis | `done` | Response overview `main.tex` around R1-O; manuscript Introduction `68-80`, Forecast validation `347-370`, Interpretation `372-424`, Conclusions `429-431` | Response now says the manuscript has been reframed from model-development emphasis toward rolling-origin forecast validation, CRPS and quantile diagnostics, horizon-aware raw-product comparisons, and selected-model interpretation. | Completed with R1-O prose gates in the publication-freeze and cross-repo validators; stale future-tense contribution wording is forbidden. |
| R1-M1 meteorological vs hydrological uncertainty | `done` | Response R1-M1 `main.tex` around `308`; manuscript Introduction `70-78`, External Data Sources `264`; workflow reviewer notes `docs/reviewer_refs/R1_M1_uncertainty_notes.md` | The response now states that the revised introduction separates hydrological uncertainty from meteorological/input uncertainty before introducing the Bayesian framework. The data-source prose now uses hydrometeorological covariate terminology for precipitation and soil-moisture transfer inputs. | Completed with article unit-test coverage and publication-freeze/cross-repo prose gates forbidding stale future-tense response language and the former purely hydrological covariate wording. |
| R1-M2 link model formulation to results | `done` | Response R1-M2 `main.tex` around `317`; manuscript Methodology `96-192`, Forecast validation `347-370`, Interpretation `372-424`; article checklist `docs/manuscript_revision_checklist.md` | The response now states that the revised manuscript no longer uses the staged A/B/C presentation as the main organizing device. The article presents one common state-space framework, connects benchmark rows to the \(L\)-\(S\)-\(T\) likelihood/source/transfer labels, and focuses interpretation on the selected `exAL-M-T1` specification. | Completed with article unit-test coverage and publication-freeze/cross-repo prose gates forbidding the old staged model labels in the main manuscript body and stale future-tense response language. |
| R1-M3 reduce mathematical detail/PIT/quantile crossing | `needs_manuscript_text` | Manuscript CRPS selection `223-239`, MCMC/VB appendices `553+`; response R1-M3 | Manuscript still contains substantial mathematical detail and algorithm appendices. Check whether detailed PIT was removed and whether quantile-crossing discussion is appropriately minimized. | Confirm acceptable level of math retained in main text vs appendix. |
| R1-M4 expanded forecast evidence beyond one event | `likely_complete` | Manuscript Rolling-origin design `330-334`, Forecast validation `345-377`, synthesis illustration `417-430`; response R1-M4 | Check response clearly says synthesis figure is illustrative, not extra validation evidence. | Confirm five-cutoff justification language is sufficient or needs a stronger archive/version explanation. |
| R1-M5 cross-validation/fair forecast assessment | `likely_complete` | Manuscript Rolling-origin design `330-334`; response R1-M5 | Check “rolling-origin cutoff-based folds” is explained as the forecast-assessment analogue of cross-validation. | Confirm whether to add a sentence about why dense rolling origins were not used. |

### Reviewer 1 Minor Comments

| ID | Current status | Evidence / manuscript anchors | Audit question | Confirmation gate |
|---|---|---|---|---|
| R1-m1 conceptual vs physically based hydrological models | `needs_manuscript_text` | Manuscript Introduction `68-80`; response R1-m1 | Response says manuscript will broaden this point. Search did not find clear conceptual-model wording. | Decide whether to add one introduction sentence or soften/remove this response claim. |
| R1-m2 “flexile” typo | `needs_audit` | Manuscript full text search; response R1-m2 | Check the typo is absent and response says corrected. | If absent, mark complete and no manuscript edit needed. |
| R1-m3 ERA5/reanalysis uncertainty | `likely_complete` | Manuscript `262`; response R1-m3 | Manuscript now notes ERA5-Land variables may include short forecast components. | Confirm whether wording should mention “not uncertainty-free” explicitly. |
| R1-m4 introduce USGS and separate data/methodology | `likely_complete` | Manuscript Data section `240-290`; figures `fig:sanlorenzo`, `fig:retrospectives`; response R1-m4 | Check USGS target vs retrospective external inputs are introduced in the right order. | Confirm no further section reorganization needed. |
| R1-m5 precipitation zeros/censoring | `needs_manuscript_text` | Response R1-m5; manuscript transfer covariates `262-268`, model spec `292-328` | Response says zero precipitation is retained as a covariate and no censoring model is used. Manuscript may not state this explicitly. | Decide where to add a concise sentence, likely External Data Sources or Application-Specific Model Specification. |
| R1-m6 latest forecast vs lagged forecasts | `done` | Manuscript `332-336`; response R1-m6; HE-7 latest-forecast manifest | Same substance as HE-7; response cross-references HE-7 and avoids duplicating a separate protocol. | Completed with HE-7 contract validation. |
| R1-m7 vague “General Results” / separate checking vs forecasting | `needs_polish` | Manuscript section map now has `Forecast validation results` and `Interpretation` split | Response says “will”; manuscript appears implemented. | Convert to completed-action language and cite new section titles. |
| R1-m8 table captions mean vs median | `needs_audit` | Manuscript `387`, generated representative tables, appendix gamma/sigma tables | Need verify whether affected tables report posterior means or medians; current manuscript says posterior means for transfer coefficients and appendix summaries may differ. | Confirm which original Tables 1/2 correspond to current tables and whether response still accurate. |
| R1-m9 figures explanation / constant variance vs variable predictive distributions | `needs_polish` | Manuscript selected-model dynamics `391-430`, long-cycle appendix `484-496`, historical-only synthesis `498-510`; response R1-m9 | Check response accurately maps old Figure 8/9 to current figure numbering and roles. | Confirm whether to mention current figure numbers explicitly in response. |

## Execution Order

Work in this order so high-impact scientific claims settle before wording-only
items:

1. HE-2, HE-3, HE-4: numerical validation, horizon split, generated tables.
2. HE-6, HE-7, R1-M4, R1-M5, R1-m6: out-of-sample design and forecast protocol.
3. HE-1, HE-5: computational cost and reproducibility/code availability.
4. R1-M1, R1-M2, R1-M3: introduction/methodology structure and math reduction.
5. R1-m1 to R1-m9: minor wording, data-role, figure/table-caption polish.
6. Global pass: summary of major revisions, conclusion, and response-letter
   consistency.

## Per-Item Completion Template

When finishing an item, update `tracker_master.csv` with:

- `status=done`;
- `response_stage=done`;
- `manuscript_stage=done` or `not_applicable`;
- `evidence_stage=done`;
- `planned_action` summarizing what was changed;
- `paper_repo_targets` listing exact revised-manuscript section/label targets;
- `impl_repo_evidence_paths` listing workflow/article artifact sources;
- `figure_table_targets` listing table/figure labels used in the response.

Add an item-level note in the final response to the user with:

1. what was verified;
2. what was edited;
3. what evidence supports it;
4. what remains unresolved, if anything;
5. whether the item needs user/advisor wording confirmation.

## Immediate Readiness Assessment

We are ready to begin the item-by-item audit with the current authoritative
results. The highest-risk items to inspect first are:

1. HE-1, because the runtime claim has now been softened to a total wall-clock
   benchmark and must stay tied to the compact runtime manifest.
2. R1-M3, because the manuscript still has substantial mathematical and
   algorithmic detail; we need to decide what level is acceptable.
3. R1-m5, because the no-censoring precipitation handling claim should be
   explicitly present in the manuscript.
4. R1-m8, because the mean/median table-caption correction must be reconciled
   against the current generated table semantics.
5. HE-2/HE-3, because these are numerically central and must preserve the
   28-day vs 8-day horizon split in both article and response text.

Recommended first user-confirmation checkpoint:

Start with HE-2/HE-3/HE-4 as the numerical core, confirm those response sections
against the current authoritative tables, then move to HE-6/HE-7 and the
forecast-design language.
