# Reproducibility Notes

This repository reconstructs the analysis from the final AlphaRING output dataset rather than rerunning AlphaRING v2 itself.

## What is reproducible here

- Loading and cleaning the final AlphaRING classification dataset.
- Recreating ROC/AUC analysis using `pROC`.
- Generating score distribution plots.
- Generating feature and SHAP summary plots.
- Parsing amino-acid substitution labels into wild-type residue, position, and variant residue.
- Recreating the SARS-CoV-2 spike protein domain organisation figure.

## What is not rerun here

- AlphaFold2 structure generation.
- RING4 interaction network calculation.
- FoldX ΔΔG calculation.
- AlphaRING v2 model execution.

Those steps are represented by the final AlphaRING output spreadsheet.

## Recommended future improvement

A later extension could add a Snakemake or Nextflow pipeline that starts from a mutation list and produces AlphaRING-ready input tables. That would make this repository a stronger workflow-engineering demonstration while keeping the current project honest about what was performed during the MSc dissertation.
