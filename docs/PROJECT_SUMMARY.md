# Project Summary

This repository documents a validation analysis of AlphaRING v2 on SARS-CoV-2 spike protein missense variants.

## Scientific context

Missense variants can alter protein function by changing amino-acid residues. In SARS-CoV-2, spike protein mutations can influence viral fitness through effects on transmissibility, immune escape, receptor binding, protein stability, and structural integrity.

AlphaRING v2 combines structural and biophysical features, including AlphaFold-derived pLDDT, RING residue interaction degree, FoldX ΔΔG, and relative substitute position, to produce an interpretable pathogenicity probability score.

## Analysis overview

The final dataset contains curated SARS-CoV-2 spike variants with AlphaRING-derived features, predicted labels, probability scores, SHAP values, and ground truth fitness classifications.

The repository reconstructs:

1. SARS-CoV-2 spike domain visualisation.
2. ROC/AUC analysis of AlphaRING probability scores.
3. Score distribution plots by true class.
4. Feature summary plots for pLDDT, Degree, DDG, RSP, and SHAP values.
5. Variant parsing from amino-acid substitution notation.

## Portfolio purpose

This project is designed to demonstrate reproducible computational genomics skills rather than simply upload a dissertation file. It shows how final analysis data can be converted into clean scripts, documented outputs, and a reviewer-friendly GitHub repository.
