# Interpretation

## Summary of findings

The initial analyses were sensitive to how spike variants were labelled and grouped. After applying stricter curation criteria, the final dataset produced an ROC AUC of approximately 0.84. AlphaRING scores therefore contained a meaningful signal for separating decreased-fitness variants from neutral, non-deleterious or increased-fitness variants in this dataset.

An AUC of 0.84 means that, when one variant is drawn from each class, the model will usually assign the more damaging score to the decreased-fitness variant. It does not mean that 84% of individual variants are classified correctly, and performance at any chosen threshold will depend on the balance between sensitivity and specificity.

## Biological interpretation

The spike protein contributes to ACE2 binding, membrane fusion, immune recognition and viral transmission. Missense substitutions can alter these functions through several routes. Some affect folding or stability; others change local residue interactions, receptor contact surfaces or antibody epitopes. Fitness may also depend on the wider lineage background, because one substitution can compensate for or intensify the effect of another.

AlphaRING is informative because it combines several structural signals rather than treating sequence conservation as the only source of evidence. This provides a plausible link between a prediction and the physical context of the altered residue.

## Sensitivity and specificity

The final analysis showed stronger specificity than sensitivity. AlphaRING was therefore better at identifying variants that were unlikely to be associated with decreased fitness than at recovering every decreased-fitness variant.

This asymmetry is biologically reasonable. A structurally tolerated substitution is less likely to impair spike function, whereas a decrease in viral fitness may arise from mechanisms that are not represented by the model, including immune context, altered processing, lineage-specific epistasis or population-level selection.

## Feature-level interpretation

### Predicted stability change (`DDG`)

`DDG` was one of the strongest contributors to AlphaRING predictions. A strongly destabilising substitution may reduce the proportion of correctly folded spike protein, disturb local conformation or impair the transitions required for membrane fusion. Its importance supports protein stability as a central component of deleteriousness prediction.

### Residue interaction degree (`Degree`)

`Degree` measures how connected a residue is within the local interaction network. A substitution at a highly connected site may affect several contacts simultaneously, which increases the chance of disrupting structural integrity or function. The contribution of `Degree` indicates that local network context adds information beyond the identity of the substituted amino acid.

### Structural confidence and position

`pLDDT` and `RSP` were weaker on average, although they may still be important for individual variants. Low local confidence can reduce certainty in structure-derived features, while position may act as a broad proxy for domain context. Their effects are likely to depend more heavily on the specific residue and surrounding region.

## Score distributions

The score distributions overlapped between classes. This is expected because biological variant effects are continuous and context-dependent rather than divided into two perfectly distinct groups. A variant can appear structurally damaging yet be tolerated, while another can have a modest local structural effect but a substantial influence on receptor binding or immune escape.

AlphaRING scores should therefore be interpreted as graded structural evidence rather than definitive labels.

## Relationship to other predictors

Sequence-based predictors can identify substitutions at evolutionarily constrained positions, but their transfer to viral proteins is not always straightforward. AlphaRING adds a different form of evidence by representing stability, interaction connectivity and structural confidence. This improves interpretability because a high-impact prediction can be traced to specific features.

The approaches are complementary. Agreement between sequence, structure, experimental and epidemiological evidence would provide stronger support than any single score alone.

## Limitations

- The repository reproduces the downstream analysis from final AlphaRING outputs rather than rerunning the model from raw structures.
- The curated dataset is not a complete or independent benchmark of SARS-CoV-2 spike variation.
- Fitness labels may depend on lineage background, experimental system and the time at which a variant was assessed.
- AlphaRING was originally benchmarked on human missense variation, so its calibration may differ in a viral protein.
- The binary classification simplifies effects that may be continuous, uncertain or context-dependent.
- Decreased viral fitness is not equivalent to reduced or increased clinical severity in humans.

## Conclusion

The final analysis indicates that AlphaRING v2 can provide useful structure-informed evidence for SARS-CoV-2 spike missense variants. The improvement after stricter curation also shows that benchmark quality is central to model evaluation. Structural predictions are most useful when they are combined with experimental, epidemiological and evolutionary evidence rather than treated as a complete account of viral fitness.
