# AlphaRING SARS-CoV-2 Spike Variant Validation

## Project overview

This project reconstructs the downstream computational analysis from my MSc Genomics dissertation, *Evaluating AlphaRING for Predicting Functional Effects of SARS-CoV-2 Spike Protein Missense Variants*.

The analysis asks whether AlphaRING v2, a structure-informed variant effect predictor, can distinguish spike protein variants associated with decreased viral fitness from variants with neutral or increased fitness. It combines AlphaRING probability scores with protein stability, residue interaction, structural confidence and positional features, then evaluates the resulting classifications using receiver operating characteristic analysis and SHAP-based feature interpretation.

## Main finding

After stricter curation of the variant labels, AlphaRING achieved an area under the receiver operating characteristic curve of approximately 0.84. This indicates that the model generally ranked decreased-fitness variants as more damaging than the comparison group, although the two classes were not completely separated.

Predicted stability change (`DDG`) and residue interaction degree (`Degree`) were the strongest average contributors to model predictions. This is mechanistically plausible because destabilising substitutions may impair spike folding or function, while substitutions at highly connected residues may disrupt several local interactions at once.

The result should not be interpreted as a complete prediction of viral evolutionary success. Viral fitness also depends on immune escape, receptor binding, lineage background, epistasis and epidemiological context.

## Research question

Can AlphaRING v2 distinguish SARS-CoV-2 spike missense variants associated with decreased viral fitness from variants with neutral or increased fitness?

## Analysis workflow

```text
Curated spike missense variants
        ↓
AlphaRING scores and structural features
        ↓
Data cleaning and class labelling
        ↓
ROC/AUC and threshold analysis
        ↓
Score and feature visualisation
        ↓
SHAP-based interpretation
```

## Scope of the repository

The repository starts from the final processed AlphaRING output used in the dissertation. It reproduces the classification, visualisation and interpretation stages, but it does not rerun AlphaRING v2 from raw protein structures.

The main analysis file is:

```text
data/processed/Final_AlphaRING_for_classification.xlsx
```

Important columns include:

| Column | Meaning |
|---|---|
| `Substitution` | AlphaRING-style variant label |
| `Simplified` | Standard amino-acid substitution, such as `N61H` |
| `pLDDT` | Local AlphaFold confidence score |
| `Degree` | Residue interaction network degree from RING |
| `DDG` | FoldX-predicted change in protein stability |
| `RSP` | Relative substitute position |
| `label` | AlphaRING classification label |
| `Probability` | AlphaRING probability score |
| `*_SHAP` | Feature-level SHAP contribution values |
| `true_class` | Curated class used for ROC analysis |

Within this dataset, `true_class = 0` represents decreased-fitness variants and `true_class = 1` represents neutral, non-deleterious or increased-fitness variants.

## Running the analysis

Create and activate the Conda environment:

```bash
conda env create -f environment.yml
conda activate alpharing-sarscov2-validation
```

Run the analysis from the repository root:

```bash
Rscript scripts/01_domain_plot.R
Rscript scripts/02_roc_analysis.R
Rscript scripts/03_score_distribution_boxplot.R
Rscript scripts/04_feature_summary_plots.R
python scripts/variant_parser.py \
  data/processed/Final_AlphaRING_for_classification.xlsx \
  results/tables/parsed_variants.csv
```

## Main outputs

| Output | Description |
|---|---|
| `figures/reproduced/roc_curve_reproduced.png` | ROC curve for the curated classification analysis |
| `figures/reproduced/alpharing_score_distribution_reproduced.png` | AlphaRING score distributions by curated class |
| `results/tables/roc_best_threshold.csv` | Best threshold identified from the ROC analysis |
| `results/tables/roc_fixed_thresholds.csv` | Thresholds at fixed sensitivity and specificity values |
| `results/tables/roc_thresholds_all.csv` | Full threshold table |
| `results/tables/parsed_variants.csv` | Parsed amino-acid substitutions |

## Documentation

- [Project summary](docs/PROJECT_SUMMARY.md)
- [Interpretation](docs/INTERPRETATION.md)
- [Reproducibility notes](docs/REPRODUCIBILITY_NOTES.md)
- [Build notes](docs/BUILD_NOTES.md)

## Limitations

The final dataset is a curated dissertation dataset rather than a complete benchmark of spike variation. The term *decreased fitness* refers to viral fitness and not to pathogenicity in an infected person. In addition, the analysis tests a tool originally benchmarked using human missense variants in a viral setting, where the relationship between local structural effects and observed fitness may differ.

AlphaRING therefore provides one source of structural evidence. Experimental, epidemiological and evolutionary evidence remains necessary when interpreting real-world SARS-CoV-2 variants.
