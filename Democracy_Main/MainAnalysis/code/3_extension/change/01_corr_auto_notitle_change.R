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
total <- read_dta(file.path(main_path, "Democracy/MainAnalysis/output/data/total.dta"))
total <- as.data.frame(total)
setwd(file.path(main_path, "Democracy/MainAnalysis/output/figures/extensions"))

total$mean_dem_vdem_change_1981_1990 = 10*total$mean_dem_vdem_change_1981_1990
total$mean_dem_vdem_change_1991_2000 = 10*total$mean_dem_vdem_change_1991_2000
total$mean_dem_vdem_change_2001_2010 = 10*total$mean_dem_vdem_change_2001_2010
total$mean_dem_vdem_change_2011_2019 = 10*total$mean_dem_vdem_change_2011_2019
total$mean_dem_vdem_change_1993_2000 = 10*total$mean_dem_vdem_change_1993_2000
total$mean_dem_vdem_change_2001_2013 = 10*total$mean_dem_vdem_change_2001_2013
total$democracy_vdem_change1981 = 10*total$democracy_vdem_change1981
total$democracy_vdem_change1990 = 10*total$democracy_vdem_change1990
total$democracy_vdem_change2000 = 10*total$democracy_vdem_change2000
total$democracy_vdem_change2010 = 10*total$democracy_vdem_change2010

# Mean GDP growth in 1981-1990
ggplot(total, 
       aes(x = mean_dem_vdem_change_1981_1990, 
           y = mean_growth_rate_1981_1990,
           weight = total_gdp1980,
           size = total_gdp1980,
           fill = mean_dem_vdem_change_1981_1990)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean GDP Growth Rate in 1981-1990") +
  xlab("Mean Democracy Annual Change in 1981-1990") +
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

ggsave("figure_mean_growth_rate_1981_1990_dem_change.png", width=8, height=6)

# Mean GDP growth in 1991-2000
ggplot(total, 
       aes(x = mean_dem_vdem_change_1991_2000, 
           y = mean_growth_rate_1991_2000,
           weight = total_gdp1990,
           size = total_gdp1990,
           fill = mean_dem_vdem_change_1991_2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean GDP Growth Rate in 1991-2000") +
  xlab("Mean Democracy Annual Change in 1991-2000") +
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

ggsave("figure_mean_growth_rate_1991_2000_dem_change.png", width=8, height=6)

# Mean GDP growth in 2001-2010
ggplot(total, 
       aes(x = mean_dem_vdem_change_2001_2010, 
           y = mean_growth_rate_2001_2010,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = mean_dem_vdem_change_2001_2010)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean GDP Growth Rate in 2001-2010") +
  xlab("Mean Democracy Annual Change in 2001-2010") +
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

ggsave("figure_mean_growth_rate_2001_2010_dem_change.png", width=8, height=6)

# Mean GDP growth in 2011-2019
ggplot(total, 
       aes(x = mean_dem_vdem_change_2011_2019, 
           y = mean_growth_rate_2011_2019,
           weight = total_gdp2010,
           size = total_gdp2010,
           fill = mean_dem_vdem_change_2011_2019)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean GDP Growth Rate in 2011-2019") +
  xlab("Mean Democracy Annual Change in 2011-2019") +
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

ggsave("figure_mean_growth_rate_2011_2019_dem_change.png", width=8, height=6)

# Mean Growth Rate Nighttime Light in 1993-2000
ggplot(total, 
       aes(x = mean_dem_vdem_change_1993_2000, 
           y = mean_g_night_light_1993_2000,
           weight = total_gdp1990,
           size = total_gdp1990,
           fill = mean_dem_vdem_change_1993_2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean Night-time Light Intensity Growth Rate in 1993-2000") +
  xlab("Mean Democracy Annual Change in 1993-2000") +
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

ggsave("figure_mean_g_night_light_1993_2000_dem_change.png", width=8, height=6)


# Mean Growth Rate Nighttime Light in 2001-2013
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


ggsave("figure_mean_g_night_light_2001_2013_dem_change.png", width=8, height=6)


# Mean GDP growth in 1981-1990
ggplot(total, 
       aes(x = democracy_vdem_change1981, 
           y = mean_growth_rate_1981_1990,
           weight = total_gdp1980,
           size = total_gdp1980,
           fill = democracy_vdem_change1981)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean GDP Growth Rate in 1981-1990") +
  xlab("Democracy Annual Change in 1981") +
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

ggsave("figure_mean_growth_rate_1981_1990_dem_annual_change.png", width=8, height=6)

# Mean GDP growth in 1991-2000
ggplot(total, 
       aes(x = democracy_vdem_change1990, 
           y = mean_growth_rate_1991_2000,
           weight = total_gdp1990,
           size = total_gdp1990,
           fill = democracy_vdem_change1990)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean GDP Growth Rate in 1991-2000") +
  xlab("Democracy Annual Change in 1990") +
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

ggsave("figure_mean_growth_rate_1991_2000_dem_annual_change.png", width=8, height=6)

# Mean GDP growth in 2001-2010
ggplot(total, 
       aes(x = democracy_vdem_change2000, 
           y = mean_growth_rate_2001_2010,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem_change2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean GDP Growth Rate in 2001-2010") +
  xlab("Democracy Annual Change in 2000") +
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

ggsave("figure_mean_growth_rate_2001_2010_dem_annual_change.png", width=8, height=6)

# Mean GDP growth in 2011-2019
ggplot(total, 
       aes(x = democracy_vdem_change2010, 
           y = mean_growth_rate_2011_2019,
           weight = total_gdp2010,
           size = total_gdp2010,
           fill = democracy_vdem_change2010)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean GDP Growth Rate in 2011-2019") +
  xlab("Democracy Annual Change in 2010") +
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

ggsave("figure_mean_growth_rate_2011_2019_dem_annual_change.png", width=8, height=6)

# Mean Growth Rate Nighttime Light in 1993-2000
ggplot(total, 
       aes(x = democracy_vdem_change1990, 
           y = mean_g_night_light_1993_2000,
           weight = total_gdp1990,
           size = total_gdp1990,
           fill = democracy_vdem_change1990)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean Night-time Light Intensity Growth Rate in 1993-2000") +
  xlab("Democracy Annual Change in 1990") +
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

ggsave("figure_mean_g_night_light_1993_2000_dem_annual_change.png", width=8, height=6)


# Mean Growth Rate Nighttime Light in 2001-2013
ggplot(total,
       aes(x = democracy_vdem_change2000, 
           y =  mean_g_night_light_2001_2013,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem_change2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean Night-time Light Intensity Growth Rate in 2001-2013") +
  xlab("Democracy Annual Change in 2000") +
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


ggsave("figure_mean_g_night_light_2001_2013_dem_annual_change.png", width=8, height=6)


