#!/usr/bin/env Rscript

# Reproduce ROC/AUC analysis for AlphaRING SARS-CoV-2 spike variant predictions.
# Run from repository root:
# Rscript scripts/02_roc_analysis.R

suppressPackageStartupMessages({
  library(readxl)
  library(dplyr)
  library(pROC)
})

input_file <- "data/processed/Final_AlphaRING_for_classification.xlsx"
out_dir <- "figures/reproduced"
table_dir <- "results/tables"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)

annotations <- read_excel(input_file, sheet = "AlphaRING_with_annotations") %>%
  mutate(
    Probability = as.numeric(Probability),
    true_class = as.integer(true_class)
  ) %>%
  filter(!is.na(Probability), !is.na(true_class))

# Ground truth used in dissertation:
# true_class = 0 -> deleterious/decreased fitness
# true_class = 1 -> non-deleterious/increased or neutral fitness
# pROC expects controls/cases; direction is set so higher AlphaRING probability indicates class 0.
roc_obj <- roc(
  response = annotations$true_class,
  predictor = annotations$Probability,
  levels = c(1, 0),
  direction = "<",
  quiet = TRUE
)

auc_value <- as.numeric(auc(roc_obj))

best_threshold <- coords(
  roc_obj,
  x = "best",
  best.method = "youden",
  ret = c("threshold", "sensitivity", "specificity", "accuracy"),
  transpose = FALSE
)

roc_data <- coords(
  roc_obj,
  x = "all",
  ret = c("threshold", "sensitivity", "specificity", "accuracy"),
  transpose = FALSE
) %>%
  as.data.frame()

fixed_thresholds <- bind_rows(
  roc_data[which.min(abs(roc_data$sensitivity - 0.80)), ] %>% mutate(target = "Sensitivity ~0.80"),
  roc_data[which.min(abs(roc_data$sensitivity - 0.90)), ] %>% mutate(target = "Sensitivity ~0.90"),
  roc_data[which.min(abs(roc_data$specificity - 0.80)), ] %>% mutate(target = "Specificity ~0.80"),
  roc_data[which.min(abs(roc_data$specificity - 0.90)), ] %>% mutate(target = "Specificity ~0.90")
) %>%
  select(target, threshold, sensitivity, specificity, accuracy)

write.csv(roc_data, file.path(table_dir, "roc_thresholds_all.csv"), row.names = FALSE)
write.csv(best_threshold, file.path(table_dir, "roc_best_threshold.csv"), row.names = FALSE)
write.csv(fixed_thresholds, file.path(table_dir, "roc_fixed_thresholds.csv"), row.names = FALSE)

png(file.path(out_dir, "roc_curve_reproduced.png"), width = 1800, height = 1600, res = 220)
plot(
  roc_obj,
  main = "ROC Curve for AlphaRING Probability Scores",
  legacy.axes = TRUE,
  print.auc = FALSE,
  lwd = 3
)
abline(a = 0, b = 1, lty = 2)
text(
  x = 0.58,
  y = 0.42,
  labels = paste0("AUC = ", round(auc_value, 3)),
  cex = 1.3,
  font = 2
)
text(
  x = 0.58,
  y = 0.30,
  labels = paste0(
    "Threshold = ", round(best_threshold$threshold, 3),
    "\nSensitivity = ", round(best_threshold$sensitivity, 3),
    "\nSpecificity = ", round(best_threshold$specificity, 3),
    "\nAccuracy = ", round(best_threshold$accuracy, 3)
  ),
  cex = 0.95
)
dev.off()

cat("ROC analysis complete\n")
cat("AUC:", round(auc_value, 3), "\n")
print(best_threshold)
print(fixed_thresholds)
