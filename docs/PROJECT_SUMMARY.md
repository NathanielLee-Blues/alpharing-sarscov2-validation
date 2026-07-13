# Project summary

## Scientific context

The SARS-CoV-2 spike protein controls receptor binding and membrane fusion and is also a major target of host immunity. A missense substitution may therefore affect viral fitness by altering protein stability, local residue interactions, receptor engagement, antigenic recognition or compatibility with other substitutions.

Many variant effect predictors rely heavily on sequence conservation. AlphaRING v2 adds structural information derived from AlphaFold, residue interaction networks and FoldX stability estimates, which may provide a more mechanistic assessment of how an amino-acid change affects a protein.

## Question

The dissertation asked whether AlphaRING v2 could distinguish spike variants associated with decreased viral fitness from variants with neutral or increased fitness.

## Analytical approach

The final AlphaRING output was cleaned and matched to curated fitness classifications. Model performance was assessed using receiver operating characteristic analysis, while score distributions and SHAP values were used to examine why individual variants received their predictions.

The principal features were:

- `DDG`, representing predicted change in protein stability;
- `Degree`, representing residue interaction network connectivity;
- `pLDDT`, representing local AlphaFold confidence; and
- `RSP`, representing relative substitute position.

## Main result

Following stricter curation of the comparison labels, the analysis produced an ROC AUC of approximately 0.84. This represents good discrimination within the final dataset, although it does not imply perfect classification or direct prediction of epidemiological success.

`DDG` and `Degree` contributed most strongly on average. The result suggests that destabilisation and disruption of highly connected residues contain useful information for identifying spike substitutions that reduce viral fitness.

## Interpretation

The model performed more strongly at identifying variants that were not associated with decreased fitness than at detecting every decreased-fitness variant. This pattern is consistent with the biology: some substitutions reduce fitness through effects that are not captured by local structure, while others may appear structurally disruptive but remain tolerated in a particular lineage background.

## Conclusion

The analysis supports the use of structure-informed evidence in viral variant interpretation. Its strongest practical implication is not that AlphaRING can replace experimental or epidemiological assessment, but that structural features can help prioritise substitutions for closer investigation when variant labels are carefully curated.
