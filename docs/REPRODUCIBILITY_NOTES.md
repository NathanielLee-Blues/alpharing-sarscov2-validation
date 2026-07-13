# Reproducibility notes

## Reproducible scope

This repository reproduces the analysis performed after AlphaRING v2 generated its final variant-level output. It covers data cleaning, class labelling, ROC analysis, threshold extraction, score visualisation, feature summaries and variant-label parsing.

It does not reproduce model training, AlphaFold structure generation, RING network construction or FoldX calculations. Those stages are upstream of the processed workbook included here.

## Environment

The R and Python dependencies are recorded in `environment.yml`. The intended setup is:

```bash
conda env create -f environment.yml
conda activate alpharing-sarscov2-validation
```

The scripts should then be run from the repository root so that relative paths resolve consistently.

## Execution order

```bash
Rscript scripts/01_domain_plot.R
Rscript scripts/02_roc_analysis.R
Rscript scripts/03_score_distribution_boxplot.R
Rscript scripts/04_feature_summary_plots.R
python scripts/variant_parser.py \
  data/processed/Final_AlphaRING_for_classification.xlsx \
  results/tables/parsed_variants.csv
```

Each script has a defined input and writes its outputs to `figures/reproduced/` or `results/tables/`. Existing outputs can therefore be compared with newly generated files after a clean run.

## Data provenance

The workbook in `data/processed/` is the final processed AlphaRING dataset used for the reconstructed analysis. It contains prediction scores, structural features, SHAP values and curated classes. Because the workbook is already processed, the repository should be described as a downstream analytical reconstruction rather than a complete end-to-end AlphaRING run.

## Expected variation

Small numerical or graphical differences may arise from package versions, font rendering or image-device settings. The central quantities, including the approximate ROC AUC and the ordering of the main feature contributions, should remain consistent when the same data and analytical choices are used.

## Reproducibility boundary

Reproducibility is strongest for the statistical and visual outputs contained in this repository. Reproducing the original structural feature generation would require the upstream AlphaRING workflow, its model files and the original protein-processing environment.
