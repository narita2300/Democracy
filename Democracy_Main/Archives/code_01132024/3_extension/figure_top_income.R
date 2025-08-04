################################################################################
# Load libraries
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)
library(ggrepel)

################################################################################
# Load dataset
total <- read_dta("/Users/richardgong/MainAnalysis/output/data/total.dta")
total <- as.data.frame(total)
setwd("/Users/richardgong/MainAnalysis/output/figures/extensions")

################################################################################

# Mean Top 1% Income Share in 2001-2019
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = mean_top1_inc_shr_2001_2019,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean Top 1% Income Share in 2001-2019") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(10, 60)) +
  geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                | total$countries == "Nigeria"
                                ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 5, 
                   min.segment.length = 2,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))

ggsave("figure_mean_top1_inc_shr_2001_2019.png", width=8, height=6)


# Mean Top 10% Income Share in 2001-2019
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = mean_top10_inc_shr_2001_2019,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean Top 10% Income Share in 2001-2019") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(40, 90)) +
  geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                | total$countries == "Nigeria"
                                ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 5, 
                   min.segment.length = 2,
                   direction = "both",
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))

ggsave("figure_mean_top10_inc_shr_2001_2019.png", width=8, height=6)


# Top 1% Income Share in 2020
ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = top1_income_share2020,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Top 1% Income Share in 2020") +
  xlab("Democracy Index (V-Dem) in 2019") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(10, 60)) +
  geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                | total$countries == "Nigeria"
                                ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 5, 
                   min.segment.length = 2,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))

ggsave("figure_top1_income_share2020.png", width=8, height=6)


# Top 10% Income Share in 2020
ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = top10_income_share2020,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Top 10% Income Share in 2020") +
  xlab("Democracy Index (V-Dem) in 2019") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(40, 90)) +
  geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                | total$countries == "Nigeria"
                                ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 5, 
                   min.segment.length = 2,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))

ggsave("figure_top10_income_share2020.png", width=8, height=6)
