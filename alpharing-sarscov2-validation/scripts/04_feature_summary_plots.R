#!/usr/bin/env Rscript

# Summarise AlphaRING features and SHAP values by true class.
# Run from repository root:
# Rscript scripts/04_feature_summary_plots.R

suppressPackageStartupMessages({
  library(readxl)
  library(dplyr)
  library(tidyr)
  library(ggplot2)
})

input_file <- "data/processed/Final_AlphaRING_for_classification.xlsx"
out_dir <- "figures/reproduced"
table_dir <- "results/tables"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)

annotations <- read_excel(input_file, sheet = "AlphaRING_with_annotations") %>%
  mutate(
    true_class = as.integer(true_class),
    true_class_label = factor(
      true_class,
      levels = c(0, 1),
      labels = c("Deleterious / decreased fitness", "Non-deleterious")
    )
  )

feature_cols <- c("pLDDT", "Degree", "DDG", "RSP")
shap_cols <- c("pLDDT_SHAP", "Degree_SHAP", "DDG_SHAP", "RSP_SHAP")

feature_long <- annotations %>%
  select(true_class_label, all_of(feature_cols)) %>%
  pivot_longer(cols = all_of(feature_cols), names_to = "feature", values_to = "value")

feature_summary <- feature_long %>%
  group_by(true_class_label, feature) %>%
  summarise(
    n = sum(!is.na(value)),
    mean = mean(value, na.rm = TRUE),
    median = median(value, na.rm = TRUE),
    sd = sd(value, na.rm = TRUE),
    .groups = "drop"
  )

write.csv(feature_summary, file.path(table_dir, "feature_summary_by_class.csv"), row.names = FALSE)

feature_plot <- ggplot(feature_long, aes(x = true_class_label, y = value, fill = true_class_label)) +
  geom_boxplot(outlier.alpha = 0.7) +
  geom_jitter(width = 0.12, alpha = 0.35, size = 1.2) +
  facet_wrap(~ feature, scales = "free_y") +
  labs(
    title = "AlphaRING Feature Distributions by True Class",
    x = "True class",
    y = "Feature value"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "none",
    axis.text.x = element_text(angle = 20, hjust = 1)
  )

ggsave(file.path(out_dir, "feature_distributions_by_class.png"), feature_plot, width = 11, height = 7, dpi = 300)

shap_long <- annotations %>%
  select(true_class_label, all_of(shap_cols)) %>%
  pivot_longer(cols = all_of(shap_cols), names_to = "feature", values_to = "shap_value") %>%
  mutate(feature = gsub("_SHAP", "", feature))

shap_summary <- shap_long %>%
  group_by(feature) %>%
  summarise(
    mean_abs_shap = mean(abs(shap_value), na.rm = TRUE),
    median_abs_shap = median(abs(shap_value), na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(mean_abs_shap))

write.csv(shap_summary, file.path(table_dir, "shap_feature_importance_summary.csv"), row.names = FALSE)

shap_plot <- ggplot(shap_summary, aes(x = reorder(feature, mean_abs_shap), y = mean_abs_shap)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Mean Absolute SHAP Contribution by Feature",
    x = "Feature",
    y = "Mean absolute SHAP value"
  ) +
  theme_minimal(base_size = 13)

ggsave(file.path(out_dir, "mean_absolute_shap_by_feature.png"), shap_plot, width = 8, height = 5, dpi = 300)
