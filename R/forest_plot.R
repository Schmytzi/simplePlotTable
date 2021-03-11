library(magrittr)
library(data.table)
library(forcats)
library(stringr)
library(cowplot)
library(ggplot2)
library(patchwork)

genes <- c("SRD5A2", "SRD5A2", "TTC27", "LINC01324", "UGT2B7", "UGT3A1", "CYP3A7", "ABO", "FKBP4", " ", "IGHV3-7", "CYP19A1", "CYP19A1", "SHBG", "RBBP8", "SULT2A1", "MCM8", "FAM9A", "AR")

all_signals[, GENE := rep(genes, each=4)]


plot_signals <- all_signals[!(as.character(ID) %in% c('rs62142080', 'rs56174704', 'rs28892005', 'rs11849588'))]
plot_signals[, ID := fct_drop(ID)]

plot_signals$ID <- plot_signals[cohort == "males"][order(OR), ID] %>%
  fct_inorder() %>% 
  levels() %>% 
  fct_relevel(plot_signals$ID, .)

forest <- ggplot(plot_signals) +
  geom_pointrange(
    aes(y=ID, x=OR, xmin=L95, xmax=U95, col=cohort),
    position = position_dodge(.5),
    shape = 5
  ) +
  geom_vline(xintercept = 1, lty="dotted") +
  theme_classic() +
  theme(
    axis.text.y = element_blank(),
    axis.title.y = element_blank(),
    axis.ticks.y = element_blank(),
    legend.position = "top",
    text = element_text(family = "Helvetica")
  ) + 
  scale_color_viridis_d(end=.85, guide=guide_legend(direction = "horizontal", title=NULL))

plot_genes <- plot_signals[cohort == "males", GENE]

label_dt <- plot_signals[cohort == "males"][order(ID), .(
  ID=rep(ID, 2),
  label=c(levels(ID), GENE),
  column=factor(rep(c("SNP", "Locus"), each=.N), levels=c("SNP", "Locus")))]

table <- ggplot(label_dt) +
  geom_text(
    aes(x=column,
        y=ID,
        label=label,
        fontface=ifelse(column=="Locus", "italic", "bold")
    ),
    hjust=0,
    family="Helvetica"
  ) +
  theme_void() + 
  theme(
      text = element_text(family="Helvetica"),
      axis.text.x = element_text(face = "bold", hjust = 0),
      axis.text.y = element_blank()
  ) +
  scale_x_discrete(position="top")

plot_grid(table, forest, align="h", nrow=1, axis="bt", rel_widths = c(1,1.8))
