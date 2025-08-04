################################################################################
# Load paths
source(here::here("Democracy_Main", "MainAnalysis", "paths.R"))

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

# Mean GDP growth in 1981-1990
ggplot(total, 
       aes(x = democracy_vdem1980, 
           y = mean_growth_rate_1981_1990,
           weight = total_gdp1980,
           size = total_gdp1980,
           fill = democracy_vdem1980)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean GDP Growth Rate in 1981-1990") +
  xlab("Democracy Index (V-Dem) in 1980") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14) ) + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), color = "black")+
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

ggsave("figure_mean_growth_rate_1981_1990_quad.png", width=8, height=6)

# Mean GDP growth in 1991-2000
ggplot(total, 
       aes(x = democracy_vdem1990, 
           y = mean_growth_rate_1991_2000,
           weight = total_gdp1990,
           size = total_gdp1990,
           fill = democracy_vdem1990)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean GDP Growth Rate in 1991-2000") +
  xlab("Democracy Index (V-Dem) in 1990") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14) ) + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), color = "black")+
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

ggsave("figure_mean_growth_rate_1991_2000_quad.png", width=8, height=6)

# Mean GDP growth in 2001-2010
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = mean_growth_rate_2001_2010,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean GDP Growth Rate in 2001-2010") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14) ) + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), color = "black")+
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

ggsave("figure_mean_growth_rate_2001_2010_quad.png", width=8, height=6)

# Mean GDP growth in 2011-2019
ggplot(total, 
       aes(x = democracy_vdem2010, 
           y = mean_growth_rate_2011_2019,
           weight = total_gdp2010,
           size = total_gdp2010,
           fill = democracy_vdem2010)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean GDP Growth Rate in 2011-2019") +
  xlab("Democracy Index (V-Dem) in 2010") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14) ) + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), color = "black")+
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

ggsave("figure_mean_growth_rate_2011_2019_quad.png", width=8, height=6)

# Mean Growth Rate Nighttime Light in 1993-2000
ggplot(total, 
       aes(x = democracy_vdem1990, 
           y = mean_g_night_light_1993_2000,
           weight = total_gdp1990,
           size = total_gdp1990,
           fill = democracy_vdem1990)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean Night-time Light Intensity Growth Rate in 1993-2000") +
  xlab("Democracy Index (V-Dem) in 1990") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14) ) + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), color = "black")+
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

ggsave("figure_mean_g_night_light_1993_2000_quad.png", width=8, height=6)


# Mean Growth Rate Nighttime Light in 2001-2013
ggplot(total,
       aes(x = democracy_vdem2000, 
           y =  mean_g_night_light_2001_2013,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean Night-time Light Intensity Growth Rate in 2001-2013") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14) ) + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), color = "black")+
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


ggsave("figure_mean_g_night_light_2001_2013_quad.png", width=8, height=6)

################################################################################

# Mean GDP growth in 1981-1990 resid

total_complete <- total[!is.na(total$mean_growth_rate_1981_1990) & 
                          !is.na(total$abs_lat) &
                          !is.na(total$mean_temp_1971_1980) & 
                          !is.na(total$mean_precip_1971_1980) &
                          !is.na(total$median_age1980) &
                          !is.na(total$pop_density1980) &
                          !is.na(total$total_gdp1980),]

reg <- lm(formula = mean_growth_rate_1981_1990 ~ abs_lat + mean_temp_1971_1980 + 
            mean_precip_1971_1980 + median_age1980 + pop_density1980, 
          weights = total_gdp1980, data = total_complete)
total_complete$mean_growth_rate_1981_1990_resid <- reg$residuals

ggplot(total_complete, 
       aes(x = democracy_vdem1980, 
           y = mean_growth_rate_1981_1990_resid,
           weight = total_gdp1980,
           size = total_gdp1980,
           fill = democracy_vdem1980)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_complete") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean GDP Growth Rate in 1981-1990") +
  xlab("Democracy Index (V-Dem) in 1980") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14) ) + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), color = "black")+
  coord_cartesian(ylim = c(-5, 7)) +
  geom_label_repel(data = total_complete[(total_complete$total_gdp2000 > 1000 | total_complete$population2000 > 100)
                                         | total_complete$countries == "Nigeria"
                                         ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 4, 
                   min.segment.length = 2,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))

ggsave("figure_mean_growth_rate_1981_1990_quad_resid.png", width=8, height=6)

# Mean GDP growth in 1991-2000 resid

total_complete <- total[!is.na(total$mean_growth_rate_1991_2000) & 
                          !is.na(total$abs_lat) &
                          !is.na(total$mean_temp_1981_1990) & 
                          !is.na(total$mean_precip_1981_1990) &
                          !is.na(total$median_age1990) &
                          !is.na(total$pop_density1990) &
                          !is.na(total$total_gdp1990),]

reg <- lm(formula = mean_growth_rate_1991_2000 ~ abs_lat + mean_temp_1981_1990 + 
            mean_precip_1981_1990 + median_age1990 + pop_density1990, 
          weights = total_gdp1990, data = total_complete)
total_complete$mean_growth_rate_1991_2000_resid <- reg$residuals

ggplot(total_complete, 
       aes(x = democracy_vdem1990, 
           y = mean_growth_rate_1991_2000_resid,
           weight = total_gdp1990,
           size = total_gdp1990,
           fill = democracy_vdem1990)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_complete") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean GDP Growth Rate in 1991-2000") +
  xlab("Democracy Index (V-Dem) in 1990") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14) ) + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), color = "black")+
  coord_cartesian(ylim = c(-5, 7)) +
  geom_label_repel(data = total_complete[(total_complete$total_gdp2000 > 1000 | total_complete$population2000 > 100)
                                         | total_complete$countries == "Nigeria"
                                         ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 4, 
                   min.segment.length = 2,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))

ggsave("figure_mean_growth_rate_1991_2000_quad_resid.png", width=8, height=6)

# Mean GDP growth in 2001-2010 resid

total_complete <- total[!is.na(total$mean_growth_rate_2001_2010) & 
                          !is.na(total$abs_lat) &
                          !is.na(total$mean_temp_1991_2000) & 
                          !is.na(total$mean_precip_1991_2000) &
                          !is.na(total$median_age2000) &
                          !is.na(total$pop_density2000) &
                          !is.na(total$total_gdp2000),]

reg <- lm(formula = mean_growth_rate_2001_2010 ~ abs_lat + mean_temp_1991_2000 + 
            mean_precip_1991_2000 + median_age2000 + pop_density2000, 
          weights = total_gdp2000, data = total_complete)
total_complete$mean_growth_rate_2001_2010_resid <- reg$residuals

ggplot(total_complete, 
       aes(x = democracy_vdem2000, 
           y = mean_growth_rate_2001_2010_resid,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_complete") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean GDP Growth Rate in 2001-2010") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14) ) + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), color = "black")+
  coord_cartesian(ylim = c(-5, 7)) +
  geom_label_repel(data = total_complete[(total_complete$total_gdp2000 > 1000 | total_complete$population2000 > 100)
                                         | total_complete$countries == "Nigeria"
                                         ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 4, 
                   min.segment.length = 2,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))

ggsave("figure_mean_growth_rate_2001_2010_quad_resid.png", width=8, height=6)

# Mean GDP growth in 2011-2019 resid

total_complete <- total[!is.na(total$mean_growth_rate_2011_2019) & 
                          !is.na(total$abs_lat) &
                          !is.na(total$mean_temp_2001_2010) & 
                          !is.na(total$mean_precip_2001_2010) &
                          !is.na(total$median_age2010) &
                          !is.na(total$pop_density2010) &
                          !is.na(total$total_gdp2010),]

reg <- lm(formula = mean_growth_rate_2011_2019 ~ abs_lat + mean_temp_2001_2010 + 
            mean_precip_2001_2010 + median_age2010 + pop_density2010, 
          weights = total_gdp2010, data = total_complete)
total_complete$mean_growth_rate_2011_2019_resid <- reg$residuals

ggplot(total_complete, 
       aes(x = democracy_vdem2010, 
           y = mean_growth_rate_2011_2019_resid,
           weight = total_gdp2010,
           size = total_gdp2010,
           fill = democracy_vdem2010)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_complete") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean GDP Growth Rate in 2011-2019") +
  xlab("Democracy Index (V-Dem) in 2010") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14) ) + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), color = "black")+
  coord_cartesian(ylim = c(-5, 7)) +
  geom_label_repel(data = total_complete[(total_complete$total_gdp2000 > 1000 | total_complete$population2000 > 100)
                                         | total_complete$countries == "Nigeria"
                                         ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 4, 
                   min.segment.length = 2,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))

ggsave("figure_mean_growth_rate_2011_2019_quad_resid.png", width=8, height=6)

# Mean Growth Rate Nighttime Light in 1993-2000 resid

total_complete <- total[!is.na(total$mean_g_night_light_1993_2000) & 
                          !is.na(total$abs_lat) &
                          !is.na(total$mean_temp_1981_1990) & 
                          !is.na(total$mean_precip_1981_1990) &
                          !is.na(total$median_age1990) &
                          !is.na(total$pop_density1990) &
                          !is.na(total$total_gdp1990),]

reg <- lm(formula = mean_g_night_light_1993_2000 ~ abs_lat + mean_temp_1981_1990 + 
            mean_precip_1981_1990 + median_age1990 + pop_density1990, 
          weights = total_gdp1990, data = total_complete)
total_complete$mean_g_night_light_1993_2000_resid <- reg$residuals

ggplot(total_complete, 
       aes(x = democracy_vdem1990, 
           y = mean_g_night_light_1993_2000_resid,
           weight = total_gdp1990,
           size = total_gdp1990,
           fill = democracy_vdem1990)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_complete") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean Night-time Light Intensity Growth Rate in 1993-2000") +
  xlab("Democracy Index (V-Dem) in 1990") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14) ) + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), color = "black")+
  coord_cartesian(ylim = c(-5, 7)) +
  geom_label_repel(data = total_complete[(total_complete$total_gdp2000 > 1000 | total_complete$population2000 > 100)
                                         | total_complete$countries == "Nigeria"
                                         ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 4, 
                   min.segment.length = 2,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))

ggsave("figure_mean_g_night_light_1993_2000_quad_resid.png", width=8, height=6)


# Mean Growth Rate Nighttime Light in 2001-2013 resid

total_complete <- total[!is.na(total$mean_g_night_light_2001_2013) & 
                          !is.na(total$abs_lat) &
                          !is.na(total$mean_temp_1991_2000) & 
                          !is.na(total$mean_precip_1991_2000) &
                          !is.na(total$median_age2000) &
                          !is.na(total$pop_density2000) &
                          !is.na(total$total_gdp2000),]

reg <- lm(formula = mean_g_night_light_2001_2013 ~ abs_lat + mean_temp_1991_2000 + 
            mean_precip_1991_2000 + median_age2000 + pop_density2000, 
          weights = total_gdp2000, data = total_complete)
total_complete$mean_g_night_light_2001_2013_resid <- reg$residuals

ggplot(total_complete,
       aes(x = democracy_vdem2000, 
           y =  mean_g_night_light_2001_2013_resid,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_complete") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean Night-time Light Intensity Growth Rate in 2001-2013") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14) ) + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), color = "black")+
  coord_cartesian(ylim = c(-5, 7)) +
  geom_label_repel(data = total_complete[(total_complete$total_gdp2000 > 1000 | total_complete$population2000 > 100)
                                         | total_complete$countries == "Nigeria"
                                         ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 4, 
                   min.segment.length = 2,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))


ggsave("figure_mean_g_night_light_2001_2013_quad_resid.png", width=8, height=6)

