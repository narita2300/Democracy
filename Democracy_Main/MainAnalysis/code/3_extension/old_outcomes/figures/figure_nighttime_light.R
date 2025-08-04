################################################################################
# Load libraries
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)
library(ggrepel)

################################################################################
# Load paths
source("../../../../paths.R")

################################################################################
# Load dataset
total <- read_dta(file.path(path_data, "total.dta"))
total <- as.data.frame(total)
output_dir <- file.path(path_output_figures, "extensions/old")
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}
setwd(output_dir)

################################################################################

# Mean Growth Rate Nighttime Light in 1992-2000
ggplot(total, 
       aes(x = democracy_vdem1990, 
           y = mean_g_night_light_1992_2000,
           weight = total_gdp1990,
           size = total_gdp1990,
           fill = democracy_vdem1990)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean Growth Rate Nighttime Light in 1992-2000") +
  xlab("Democracy Index (V-Dem) in 1990") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(-10, 20)) +
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

ggsave("figure_mean_g_night_light_1992_2000.png", width=8, height=6)


# Mean Growth Rate Nighttime Light in 2001-2013
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = mean_g_night_light_2001_2013,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean Growth Rate Nighttime Light in 2001-2013") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(-10, 20)) +
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

ggsave("figure_mean_g_night_light_2001_2013.png", width=8, height=6)
