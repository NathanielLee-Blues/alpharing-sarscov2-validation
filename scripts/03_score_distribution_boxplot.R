#!/usr/bin/env Rscript

# Reproduce AlphaRING probability score distribution by true class.
# Run from repository root:
# Rscript scripts/03_score_distribution_boxplot.R

suppressPackageStartupMessages({
  library(readxl)
  library(dplyr)
  library(ggplot2)
  library(pROC)
})

input_file <- "data/processed/Final_AlphaRING_for_classification.xlsx"
out_dir <- "figures/reproduced"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

annotations <- read_excel(input_file, sheet = "AlphaRING_with_annotations") %>%
  mutate(
    Probability = as.numeric(Probability),
    true_class = as.integer(true_class),
    true_class_label = factor(
      true_class,
      levels = c(0, 1),
      labels = c("Deleterious / decreased fitness", "Non-deleterious")
    )
  ) %>%
  filter(!is.na(Probability), !is.na(true_class))

roc_obj <- roc(
  response = annotations$true_class,
  predictor = annotations$Probability,
  levels = c(1, 0),
  direction = "<",
  quiet = TRUE
)

best_threshold <- coords(
  roc_obj,
  x = "best",
  best.method = "youden",
  ret = "threshold",
  transpose = FALSE
)$threshold

p <- ggplot(annotations, aes(x = true_class_label, y = Probability, fill = true_class_label)) +
  geom_boxplot(outlier.alpha = 0.8) +
  geom_jitter(width = 0.12, alpha = 0.45, size = 1.5) +
  geom_hline(yintercept = best_threshold, linetype = "dashed", linewidth = 0.8) +
  annotate(
    "text",
    x = 1.5,
    y = best_threshold + 0.04,
    label = paste0("ROC threshold (", round(best_threshold, 3), ")"),
    size = 4,
    fontface = "italic"
  ) +
  labs(
    title = "Distribution of AlphaRING Scores by True Class",
    x = "True class",
    y = "AlphaRING probability score"
  ) +
  theme_minimal(base_size = 13) +
  theme(legend.position = "none")

ggsave(file.path(out_dir, "alpharing_score_distribution_reproduced.png"), p, width = 9, height = 6, dpi = 300)
