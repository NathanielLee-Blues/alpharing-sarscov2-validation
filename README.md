# AlphaRING SARS-CoV-2 Spike Variant Validation

This repository reconstructs and documents the analysis from my MSc Genomics dissertation project: **Evaluating AlphaRING for Predicting Functional Effects of SARS-CoV-2 Spike Protein Missense Variants**.

The project evaluates whether AlphaRING v2 can predict functional effects of SARS-CoV-2 spike protein missense variants using final AlphaRING output scores, structural features, SHAP values, and known viral fitness classifications.

## Project aims

- Curate SARS-CoV-2 spike missense variants with known fitness effects.
- Use AlphaRING v2 outputs to assess predicted variant impact.
- Reproduce ROC/AUC analysis from the final dataset.
- Visualise AlphaRING score distributions and feature behaviour by true class.
- Present the analysis as a reproducible bioinformatics portfolio project.

## Repository structure

```text
alpharing-sarscov2-validation/
├── data/
│   ├── processed/Final_AlphaRING_for_classification.xlsx
│   └── raw/
├── scripts/
│   ├── 01_domain_plot.R
│   ├── 02_roc_analysis.R
│   ├── 03_score_distribution_boxplot.R
│   ├── 04_feature_summary_plots.R
│   └── variant_parser.py
├── figures/
│   ├── original/
│   └── reproduced/
├── results/
│   └── tables/
├── docs/
│   ├── PROJECT_SUMMARY.md
│   └── REPRODUCIBILITY_NOTES.md
├── environment.yml
└── README.md
```

## Data

The main analysis file is:

```text
data/processed/Final_AlphaRING_for_classification.xlsx
```

Key columns include:

- `Substitution`: AlphaRING-style variant label.
- `Simplified`: standard amino-acid substitution label, e.g. `N61H`.
- `pLDDT`: AlphaFold local confidence score.
- `Degree`: residue interaction network degree from RING.
- `DDG`: FoldX stability estimate.
- `RSP`: relative substitute position.
- `label`: AlphaRING prediction label.
- `Probability`: AlphaRING probability score.
- `*_SHAP`: SHAP contribution values.
- `true_class`: ground truth class used for ROC analysis.

In this dataset, `true_class = 0` represents deleterious/decreased-fitness variants and `true_class = 1` represents non-deleterious/increased- or neutral-fitness variants.

## How to run

Create the conda environment:

```bash
conda env create -f environment.yml
conda activate alpharing-sarscov2-validation
```

Run the scripts from the repository root:

```bash
Rscript scripts/01_domain_plot.R
Rscript scripts/02_roc_analysis.R
Rscript scripts/03_score_distribution_boxplot.R
Rscript scripts/04_feature_summary_plots.R
python scripts/variant_parser.py data/processed/Final_AlphaRING_for_classification.xlsx results/tables/parsed_variants.csv
```

## Expected outputs

Reproduced figures are saved to:

```text
figures/reproduced/
```

Summary tables are saved to:

```text
results/tables/
```

## Skills demonstrated

- Structural bioinformatics
- Variant effect prediction
- SARS-CoV-2 spike protein biology
- ROC/AUC analysis in R
- Data cleaning and feature extraction
- SHAP-based model interpretation
- GitHub-ready reproducible project organisation
