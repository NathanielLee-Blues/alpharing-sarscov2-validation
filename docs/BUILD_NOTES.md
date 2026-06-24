# Build Notes

The Python variant parser was tested in this environment and successfully parsed 102/102 variants from `Simplified` into residue-level fields.

The R scripts were written by cleaning and restructuring the available `.Rhistory` into standalone scripts. They were not executed in this container because `Rscript` is not installed here. They are intended to run in R/RStudio or the provided conda environment.

Recommended local check after cloning:

```bash
conda env create -f environment.yml
conda activate alpharing-sarscov2-validation
Rscript scripts/02_roc_analysis.R
Rscript scripts/03_score_distribution_boxplot.R
Rscript scripts/04_feature_summary_plots.R
Rscript scripts/01_domain_plot.R
```
