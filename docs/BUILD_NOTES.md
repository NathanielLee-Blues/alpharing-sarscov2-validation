# Build notes

## Purpose of the reconstruction

The original dissertation contained a wider research narrative and several exploratory analyses. This repository was built to isolate the parts that can be inspected and rerun from the final AlphaRING output without reproducing the entire dissertation environment.

## Decisions made during the build

- The final processed workbook was retained as the common input to all downstream analyses.
- Plotting and statistical steps were separated into ordered scripts so that each output has a clear source.
- Original figures were kept apart from reproduced figures to avoid implying that a static dissertation image had been regenerated.
- Threshold tables and parsed variant labels were written to machine-readable files rather than reported only in prose.
- Interpretation and reproducibility notes were separated from the main README so that the landing page remains concise.

## What was not included

The repository does not include AlphaRING model training, raw structural inputs, AlphaFold generation, RING network construction or FoldX execution. It also does not claim that the curated classes form a definitive benchmark of all spike variants.

## Naming and terminology

The term *decreased fitness* is used for the curated viral-fitness class. It should not be replaced with *pathogenic* or *clinically severe*, because those terms describe different biological questions.

## Intended use

The repository is intended to make the analytical reasoning transparent: which data were used, how performance was measured, which features influenced predictions and where the interpretation must remain cautious.
