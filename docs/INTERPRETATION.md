# Interpretation

## Summary of findings

This project evaluates whether AlphaRING v2 can predict the functional effects of SARS-CoV-2 spike protein missense variants using structure-informed features and known viral fitness classifications.

The initial broader variant set produced weak classification performance, with an AUC of approximately 0.54. This suggested that the first set of “gold standard” variants was too permissive and likely contained uncertain or inconsistently classified examples.

After applying stricter curation criteria, the final higher-confidence variant set produced substantially stronger performance, with an ROC AUC of approximately **0.84**. This indicates that AlphaRING scores contained meaningful signal for distinguishing decreased-fitness spike variants from non-deleterious or increased-fitness variants.

## Biological interpretation

The SARS-CoV-2 spike protein is central to viral entry, ACE2 receptor binding, membrane fusion, immune recognition, and viral transmissibility. Missense variants in this protein can therefore affect viral fitness through changes in protein stability, structural integrity, receptor interaction, immune escape, or compatibility with other mutations.

AlphaRING v2 is useful in this context because it incorporates structural information rather than relying only on sequence conservation. The model combines AlphaFold-derived structural confidence, residue interaction network features from RING, FoldX-predicted stability change, and relative substitute position. These features provide a mechanistic view of how an amino-acid substitution may affect the protein.

The observed performance suggests that structure-informed prediction can contribute to viral variant interpretation, particularly when assessing variants likely to disrupt spike protein structure or function.

## ROC/AUC interpretation

The ROC AUC of approximately **0.84** indicates good discriminatory performance. In practical terms, AlphaRING usually ranked decreased-fitness variants as more damaging than non-deleterious variants.

The sensitivity and specificity values suggest that AlphaRING performed better at correctly identifying neutral or non-deleterious variants than capturing all decreased-fitness variants. This implies that the model may be more reliable when identifying variants that are structurally tolerated than when identifying every variant that may reduce viral fitness.

This is biologically reasonable because viral fitness is affected by factors beyond local protein structure. A mutation may increase or decrease fitness through immune escape, epidemiological context, lineage background, or epistatic interactions with other mutations.

## Feature interpretation

The feature-level interpretation showed that `DDG` and `Degree` were the most influential contributors to AlphaRING predictions.

`DDG` represents predicted change in protein stability. Variants with strongly destabilising effects are more likely to interfere with folding, structural integrity, or spike protein function. The importance of `DDG` therefore supports the idea that protein stability is a major factor in predicting deleterious spike variants.

`Degree` represents residue interaction network connectivity. A mutation at a highly connected residue may disrupt multiple local interactions, making it more likely to affect protein structure or function. The importance of `Degree` suggests that residue interaction context is also important for variant interpretation.

`pLDDT` and `RSP` contributed less strongly on average. `pLDDT` provides local AlphaFold structural confidence, while `RSP` captures relative position within the protein. These features may still influence individual predictions, but their effects appear more context-dependent.

## Interpretation of score distributions

The AlphaRING score distributions showed separation between decreased-fitness and non-deleterious variants, but the classes were not perfectly separated. This is expected in biological variant effect prediction.

Some variants may appear structurally damaging but still be tolerated by the virus. Others may have modest structural effects but important biological consequences through immune escape, receptor binding, or lineage-specific interactions.

Therefore, AlphaRING scores should be interpreted as structural evidence, not as complete evidence of viral evolutionary behaviour.

## Comparison with existing approaches

Compared with sequence-based tools such as CADD, AlphaRING has the advantage of incorporating protein structural information. This makes its predictions more interpretable, because the model can highlight whether stability, residue connectivity, local structural confidence, or position contributed to the prediction.

This is especially useful for non-human proteins and viral genomes, where human-trained or conservation-based predictors may not always transfer cleanly.

## Limitations

This project has several important limitations:

* The repository reconstructs downstream analysis from final AlphaRING outputs rather than rerunning AlphaRING v2 from raw protein inputs.
* The term “deleterious” refers to decreased viral fitness, not clinical pathogenicity in humans.
* Viral fitness is affected by structural, immunological, epidemiological, and evolutionary factors.
* Some variants may be misclassified because fitness effects can depend on lineage background or interactions with other mutations.
* The final dataset was curated for dissertation analysis and should not be treated as a complete benchmark of SARS-CoV-2 spike variation.
* The analysis tests AlphaRING in a viral context, while the tool was originally benchmarked against human missense variants.

## Overall conclusion

This project supports the idea that AlphaRING v2 can provide useful structure-informed predictions for SARS-CoV-2 spike protein missense variants. The improved performance after stricter dataset curation suggests that high-quality variant labels are essential when benchmarking variant effect predictors.

Overall, the results indicate that structural bioinformatics can contribute meaningfully to viral variant interpretation, but should be combined with experimental, epidemiological, and evolutionary evidence when assessing real-world viral fitness.
