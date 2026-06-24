# How to add this to GitHub

From WSL/Linux terminal:

```bash
cd ~/bioinformatics-projects
unzip alpharing-sarscov2-validation.zip
cd alpharing-sarscov2-validation
```

Initialise Git if needed:

```bash
git init
git add README.md docs environment.yml .gitignore
git commit -m "Add project documentation and environment"
```

Add data and original figures:

```bash
git add data/processed figures/original
git commit -m "Add final AlphaRING dataset and original figures"
```

Add analysis scripts:

```bash
git add scripts
git commit -m "Add reproducible analysis scripts"
```

Run scripts, then commit reproduced outputs:

```bash
Rscript scripts/02_roc_analysis.R
Rscript scripts/03_score_distribution_boxplot.R
Rscript scripts/04_feature_summary_plots.R
python scripts/variant_parser.py data/processed/Final_AlphaRING_for_classification.xlsx results/tables/parsed_variants.csv

git add figures/reproduced results/tables
git commit -m "Reproduce AlphaRING validation figures and tables"
```

Connect to GitHub:

```bash
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/alpharing-sarscov2-validation.git
git push -u origin main
```
