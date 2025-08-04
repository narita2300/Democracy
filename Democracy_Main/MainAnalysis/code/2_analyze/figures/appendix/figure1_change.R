################################################################################
# Load paths
source(file.path(dirname(dirname(dirname(dirname(dirname(getwd()))))), "paths.R"))

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
total <- read_dta(file.path(main_path, "Democracy/Democracy_Main/MainAnalysis/output/data/total.dta"))
total <- as.data.frame(total)
setwd(file.path(main_path, "Democracy/Democracy_Main/MainAnalysis/output/figures/appendix"))

################################################################################

## Change in Democracy vs GDP Growth
ggplot(total, 
       aes(x = change_democracy_vdem_2001_2019, 
           y = mean_growth_rate_2001_2019,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean GDP Growth Rate in 2001-2019") +
  xlab("Change in Democracy Index (V-Dem) 2001-2019") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(-2, 10)) +
  geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                | total$countries == "Nigeria"
                                ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 4, 
                   min.segment.length = 2,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))

ggsave("figure1_change.png", width=8, height=6, bg = 'white')

################################################################################
## Nighttime light growth 2001-2013
ggplot(total,
       aes(x = mean_dem_vdem_change_2001_2013, 
           y =  mean_g_night_light_2001_2013,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = mean_dem_vdem_change_2001_2013)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean Night-time Light Intensity Growth Rate in 2001-2013") +
  xlab("Mean Democracy Annual Change in 2001-2013") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14) ) + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(-2, 10), xlim = c(-0.2, 0.2)) +
  geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                | total$countries == "Nigeria"
                                ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 4, 
                   min.segment.length = 2,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))

ggsave("figure1b_change.png", width=8, height=6, bg = 'white')

################################################################################
## Mean Democracy Annual Change in 2001-2019
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = mean_dem_vdem_change_2001_2019,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean Democracy Annual Change in 2001-2019") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(-0.2, 0.2)) +
  geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                | total$countries == "Nigeria"
                                ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 4, 
                   min.segment.length = 2,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))

ggsave("figure1c_change.png", width=8, height=6,bg = 'white')
