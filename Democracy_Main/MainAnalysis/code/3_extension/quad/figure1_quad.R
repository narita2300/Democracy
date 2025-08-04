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

################################################################################

## GDP growth in 2001-2019
ggplot(total, 
       aes(x = democracy_vdem2000, 
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
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) + 
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

ggsave("figure1a_quad.png", width=8, height=6,bg = 'white')

## GDP growth in 2020-2022
ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = mean_growth_rate_2020_2022,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean GDP Growth Rate in 2020-2022") +
  xlab("Democracy Index (V-Dem) in 2019") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) + 
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
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 50))

ggsave("figure1b_quad.png", width=8, height=6, bg = 'white')

## Nighttime light growth 2001-2013
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

ggsave("figure1c_quad.png", width=8, height=6, bg = 'white')

## Covid-related deaths per million
ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = mean_death_per_million_20_22,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean Covid-19 Deaths per Million in 2020-2022") +
  xlab("Democracy Index (V-Dem) in 2019") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), color = "black")+
  coord_cartesian(ylim = c(0, 1500)) +
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

ggsave("figure1d_quad.png", width=8, height=6, bg = 'white')


################################################################################

## GDP growth in 2001-2019 resid

total_complete <- total[!is.na(total$mean_growth_rate_2001_2019) & 
                                            !is.na(total$abs_lat) &
                                            !is.na(total$mean_temp_1991_2000) & 
                                            !is.na(total$mean_precip_1991_2000) &
                                            !is.na(total$pop_density2000) &
                                            !is.na(total$median_age2000) &
                                            !is.na(total$total_gdp2000),]

reg <- lm(formula = mean_growth_rate_2001_2019 ~ abs_lat + mean_temp_1991_2000 + 
            mean_precip_1991_2000 + pop_density2000 + median_age2000, 
          weights = total_gdp2000, data = total_complete)
total_complete$mean_growth_rate_2001_2019_resid <- reg$residuals

ggplot(total_complete, 
       aes(x = democracy_vdem2000, 
           y = mean_growth_rate_2001_2019_resid,
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
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), color = "black")+
  coord_cartesian(ylim = c(-4, 8)) +
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

ggsave("figure1a_quad_resid.png", width=8, height=6,bg = 'white')

## GDP growth in 2020-2022 resid

total_complete <- total[!is.na(total$mean_growth_rate_2020_2022) & 
                          !is.na(total$abs_lat) &
                          !is.na(total$mean_temp_1991_2016) & 
                          !is.na(total$mean_precip_1991_2016) &
                          !is.na(total$pop_density2019) &
                          !is.na(total$median_age2020) &
                          !is.na(total$diabetes_prevalence2019) &
                          !is.na(total$total_gdp2019),]

reg <- lm(formula = mean_growth_rate_2020_2022 ~ abs_lat + mean_temp_1991_2016 + 
            mean_precip_1991_2016 + pop_density2019 + median_age2020 + 
            diabetes_prevalence2019, weights = total_gdp2019, data = total_complete)
total_complete$mean_growth_rate_2020_2022_resid <- reg$residuals

ggplot(total_complete, 
       aes(x = democracy_vdem2019, 
           y = mean_growth_rate_2020_2022_resid,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean GDP Growth Rate in 2020-2022") +
  xlab("Democracy Index (V-Dem) in 2019") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), color = "black")+
  coord_cartesian(ylim = c(-4, 8)) +
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
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 50))

ggsave("figure1b_quad_resid.png", width=8, height=6, bg = 'white')

## Nighttime light growth 2001-2013 resid

total_complete <- total[!is.na(total$mean_g_night_light_2001_2013) & 
                          !is.na(total$abs_lat) &
                          !is.na(total$mean_temp_1991_2000) & 
                          !is.na(total$mean_precip_1991_2000) &
                          !is.na(total$pop_density2000) &
                          !is.na(total$median_age2000) &
                          !is.na(total$total_gdp2000),]

reg <- lm(formula = mean_g_night_light_2001_2013 ~ abs_lat + mean_temp_1991_2000 + 
            mean_precip_1991_2000 + pop_density2000 + median_age2000, 
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
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean Night-time Light Intensity Growth Rate in 2001-2013") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14) ) + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), color = "black")+
  coord_cartesian(ylim = c(-4, 8)) +
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

ggsave("figure1c_quad_resid.png", width=8, height=6, bg = 'white')

## resided Covid-related deaths per million

total_complete <- total[!is.na(total$mean_death_per_million_20_22) & 
                          !is.na(total$abs_lat) &
                          !is.na(total$mean_temp_1991_2016) & 
                          !is.na(total$mean_precip_1991_2016) &
                          !is.na(total$pop_density2019) &
                          !is.na(total$median_age2020) &
                          !is.na(total$diabetes_prevalence2019) &
                          !is.na(total$total_gdp2019),]

reg <- lm(formula = mean_death_per_million_20_22 ~ abs_lat + mean_temp_1991_2016 + 
            mean_precip_1991_2016 + pop_density2019 + median_age2020 + 
            diabetes_prevalence2019, weights = total_gdp2019, data = total_complete)
total_complete$mean_death_per_million_20_22_resid <- reg$residuals

ggplot(total_complete, 
       aes(x = democracy_vdem2019, 
           y = mean_death_per_million_20_22_resid,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean Covid-19 Deaths per Million in 2020-2022") +
  xlab("Democracy Index (V-Dem) in 2019") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), color = "black")+
  coord_cartesian(ylim = c(-1000, 500)) +
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

ggsave("figure1d_quad_resid.png", width=8, height=6, bg = 'white')
