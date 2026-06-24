# Validatimg Sars-CoV-2 Spike Variants using AlphaRING

![R](https://img.shields.io/badge/R-ROC%20Analysis-blue)
![Python](https://img.shields.io/badge/Python-Variant%20Parsing-green)
![Bioinformatics](https://img.shields.io/badge/Bioinformatics-Structural%20Variant%20Prediction-purple)
![Status](https://img.shields.io/badge/Status-Reproducible%20Analysis-lightgrey)

## Project overview

This repository reconstructs and documents the computational analysis from my MSc Genomics dissertation project:

**Evaluating AlphaRING for Predicting Functional Effects of SARS-CoV-2 Spike Protein Missense Variants**

The project evaluates whether **AlphaRING v2**, a structure-informed variant effect prediction tool, can predict the functional impact of SARS-CoV-2 spike protein missense variants using AlphaRING output scores, structural features, SHAP values, and known viral fitness classifications.

Rather than simply storing dissertation outputs, this repository presents the analysis as a reproducible bioinformatics portfolio project, with cleaned scripts, processed data, figures, and documentation.

---

## Project at a glance

| Area                   | Description                                                                                      |
| ---------------------- | ------------------------------------------------------------------------------------------------ |
| Biological focus       | SARS-CoV-2 spike protein missense variants                                                       |
| Main tool evaluated    | AlphaRING v2                                                                                     |
| Data type              | Variant-level structural and prediction features                                                 |
| Key methods            | ROC/AUC analysis, score distribution analysis, SHAP interpretation                               |
| Main languages         | R, Python                                                                                        |
| Portfolio skills shown | Structural bioinformatics, variant interpretation, reproducible analysis, statistical evaluation |

---

## Research question

Can AlphaRING v2 accurately distinguish SARS-CoV-2 spike protein variants associated with decreased viral fitness from variants with neutral or increased fitness?

---

## Workflow

```text
Curated SARS-CoV-2 spike variants
        ↓
AlphaRING v2 output scores and features
        ↓
Data cleaning and class labelling
        ↓
ROC/AUC performance analysis
        ↓
Feature and score distribution visualisation
        ↓
SHAP-based interpretation
```

---

## Key result

The final analysis showed that AlphaRING had useful predictive performance for SARS-CoV-2 spike protein variant classification, with the ROC analysis producing an AUC of approximately **0.84**.

This suggests that structure-informed features such as residue interaction degree, predicted stability change, and local structural confidence can provide meaningful information when evaluating viral missense variants.

---

## Example outputs

### ROC curve

![ROC curve](figures/original/Roc%20Curve.png)

### AlphaRING score distribution

![AlphaRING score distribution](figures/original/Distribution%20of%20AlphaRING%20scores%20by%20class.png)

### Spike protein domain organisation

![Spike protein domain organisation](figures/original/Spike%20protein%20Domain%20organisation.png)

---

## Repository structure

```text
alpharing-sarscov2-validation/
├── data/
│   └── processed/
│       └── Final_AlphaRING_for_classification.xlsx
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
│   ├── REPRODUCIBILITY_NOTES.md
│   └── BUILD_NOTES.md
├── environment.yml
└── README.md
```

---

## Data

The main analysis file is:

```text
data/processed/Final_AlphaRING_for_classification.xlsx
```

Key columns include:

| Column         | Description                                                |
| -------------- | ---------------------------------------------------------- |
| `Substitution` | AlphaRING-style variant label                              |
| `Simplified`   | Standard amino-acid substitution label, for example `N61H` |
| `pLDDT`        | AlphaFold local confidence score                           |
| `Degree`       | Residue interaction network degree from RING               |
| `DDG`          | FoldX predicted stability change                           |
| `RSP`          | Relative substitute position                               |
| `label`        | AlphaRING prediction label                                 |
| `Probability`  | AlphaRING probability score                                |
| `*_SHAP`       | SHAP contribution values for model interpretation          |
| `true_class`   | Ground truth class used for ROC analysis                   |

In this dataset, `true_class = 0` represents deleterious or decreased-fitness variants, while `true_class = 1` represents non-deleterious, neutral, or increased-fitness variants.

---

## How to run the analysis

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

---

## Expected outputs

Reproduced figures are saved to:

```text
figures/reproduced/
```

Summary tables are saved to:

```text
results/tables/
```

---

## Skills demonstrated

This project demonstrates:

* structural bioinformatics
* SARS-CoV-2 spike protein variant interpretation
* variant effect prediction
* ROC/AUC analysis in R
* biological data cleaning and feature extraction
* SHAP-based model interpretation
* Python scripting for variant parsing
* reproducible GitHub project organisation

---

## Notes on reproducibility

This repository reconstructs the downstream analysis from the final AlphaRING output dataset. It does not rerun AlphaRING v2 itself. Instead, it focuses on making the final classification, visualisation, and statistical evaluation steps transparent and reproducible.

---

## Project context

This project was developed from an MSc Genomics dissertation investigating whether AlphaRING v2 could be applied beyond human missense variant prediction and used to evaluate SARS-CoV-2 spike protein variants.

The repository has been structured as a bioinformatics portfolio project to demonstrate computational genomics, structural variant interpretation, and reproducible analysis practices.
