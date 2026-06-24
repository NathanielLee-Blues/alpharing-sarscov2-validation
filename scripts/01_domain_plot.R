#!/usr/bin/env Rscript

# Recreate SARS-CoV-2 spike protein domain organisation plot.
# Run from repository root:
# Rscript scripts/01_domain_plot.R

suppressPackageStartupMessages({
  library(ggplot2)
})

out_dir <- "figures/reproduced"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

domains <- data.frame(
  Domain = c("SP", "NTD", "RBD", "CTD1", "CTD2", "FP", "FPPR", "HR1", "CH", "CD", "HR2", "TM", "CT"),
  Start = c(1, 14, 331, 528, 591, 816, 834, 910, 985, 1068, 1163, 1211, 1235),
  End = c(13, 305, 531, 590, 685, 833, 909, 984, 1035, 1141, 1213, 1234, 1273)
)

cleavage <- data.frame(
  Site = c("S1/S2", "S2'"),
  Position = c(686, 816)
)

subunits <- data.frame(
  Subunit = c("S1", "S2"),
  Start = c(1, 686),
  End = c(685, 1273)
)

label_levels <- c(0.57, 0.61, 0.65, 0.69)
domains$Start_y <- rep(label_levels, length.out = nrow(domains))
domains$End_y <- rep(label_levels, length.out = nrow(domains))

p <- ggplot() +
  geom_rect(data = subunits, aes(xmin = Start, xmax = End, ymin = 0.48, ymax = 0.52, fill = Subunit), alpha = 0.15, color = NA) +
  geom_rect(data = domains, aes(xmin = Start, xmax = End, ymin = 0.49, ymax = 0.51, fill = Domain), color = "black") +
  geom_text(data = domains, aes(x = (Start + End) / 2, y = 0.44, label = Domain), size = 3) +
  geom_segment(data = domains, aes(x = Start, xend = Start, y = 0.51, yend = Start_y - 0.015), color = "black") +
  geom_text(data = domains, aes(x = Start, y = Start_y, label = Start), size = 2.8) +
  geom_segment(data = domains, aes(x = End, xend = End, y = 0.51, yend = End_y - 0.015), color = "black") +
  geom_text(data = domains, aes(x = End, y = End_y, label = End), size = 2.8) +
  geom_segment(data = cleavage, aes(x = Position, xend = Position, y = 0.52, yend = 0.73), linetype = "dashed") +
  geom_text(data = cleavage, aes(x = Position, y = 0.75, label = Site), angle = 90, vjust = 0, size = 3) +
  geom_segment(data = subunits, aes(x = Start, xend = End, y = 0.36, yend = 0.36), linewidth = 0.6) +
  geom_text(data = subunits, aes(x = (Start + End) / 2, y = 0.34, label = paste("Spike", Subunit, "subunit")), fontface = "bold", size = 3.2) +
  scale_fill_brewer(palette = "Set3") +
  scale_x_continuous(limits = c(0, 1300), expand = c(0, 0)) +
  labs(title = "SARS-CoV-2 Spike Protein Domain Organisation") +
  theme_minimal(base_size = 12) +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    legend.position = "none"
  )

ggsave(file.path(out_dir, "spike_domain_organisation_reproduced.png"), p, width = 12, height = 5, dpi = 300)
