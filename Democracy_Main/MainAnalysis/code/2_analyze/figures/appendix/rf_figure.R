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


# Figure 2
# (a): Reduced-form relationship between GDP Growth Rates in 2001 -2019 and log European settler mortality
ggplot(total, 
       aes(x = lpd1500s, 
           y = mean_growth_rate_2001_2019,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.4, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2000") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) +
  ylab("Mean GDP Growth Rate in 2001-2019") +
  xlab("Log Population Density in 1500s IV") +
  theme(legend.position = "none") + 
  coord_cartesian(ylim = c(-2, 10)) +
  geom_smooth(method = lm,color = "black")+
  geom_label_repel(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Turkey"|
                        total$countries=="Russia"|
                        total$countries=="India"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"|
                        total$countries=="Ghana"|
                        total$countries=="Brazil"|
                        total$countries=="France"|
                        total$countries=="Vietnam"|
                        total$countries=="Rwanda"|
                        total$countries=="Mali"|
                        total$countries=="Tunisia"|
                        total$countries=="Liberia"|
                        total$countries=="Bangladesh"|
                        total$countries=="South Korea"
               ),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 4, max.overlaps = 50) 

ggsave("figure2Aa.png", width=8, height=6)


# (b): Reduced-form relationship between GDP Growth Rates in 2020-2022 and log European settler mortality
ggplot(total, 
       aes(x = lpd1500s, 
           y = mean_growth_rate_2020_2022,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.4, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) +
  ylab("Mean GDP Growth Rate in 2020-2022") +
  xlab("Log Population Density in 1500s IV") +
  theme(legend.position = "none") +
  coord_cartesian(ylim = c(-2, 10)) +
  geom_smooth(method = lm, color = "black")+
  geom_label_repel(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Turkey"|
                        total$countries=="Russia"|
                        total$countries=="India"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"|
                        total$countries=="Ghana"|
                        total$countries=="Brazil"|
                        total$countries=="France"),
             aes(label=countries), 
             label.size = NA,  
             # label.padding=.1, 
             # na.rm=TRUE,
             fill = alpha(c("white"),0.5),
             size = 4) 

ggsave("figure2Ab.png", width=8, height=6, bg = 'white')

# (c): Reduced-form relationship between nightlight in 2001 -2019 and log European settler mortality
ggplot(total, 
       aes(x = lpd1500s, 
           y = mean_g_night_light_2001_2013,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.4, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2000") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) +
  ylab("Mean Nighttime Light Intensity Growth Rate in 2001-2013") +
  xlab("Log Population Density in 1500s IV") +
  theme(legend.position = "none") + 
  coord_cartesian(ylim = c(-2, 10)) +
  geom_smooth(method = lm,color = "black")+
  geom_label_repel(data = total %>% 
                     filter(total$countries =="United States"|
                              total$countries =="Japan"|
                              total$countries=="China"|
                              total$countries=="Turkey"|
                              total$countries=="Russia"|
                              total$countries=="India"|
                              total$countries=="Egypt"|
                              total$countries=="Nigeria"|
                              total$countries=="Ghana"|
                              total$countries=="Brazil"|
                              total$countries=="France"|
                              total$countries=="Vietnam"|
                              total$countries=="Rwanda"|
                              total$countries=="Mali"|
                              total$countries=="Tunisia"|
                              total$countries=="Liberia"|
                              total$countries=="Bangladesh"|
                              total$countries=="South Korea"
                     ),
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   size = 4, max.overlaps = 50) 

ggsave("figure2Ac.png", width=8, height=6)


# (d): Reduced-form relationship between GDP Growth Rates in 2001 -2019 and log European settler mortality
ggplot(total, 
       aes(x = legor_uk, 
           y = mean_growth_rate_2001_2019,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.4, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2000") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) +
  ylab("Mean GDP Growth Rate in 2001-2019") +
  xlab("British Legal Origin IV") +
  theme(legend.position = "none") + 
  coord_cartesian(ylim = c(-2, 10)) +
  geom_smooth(method = lm,color = "black")+
  geom_label_repel(data = total %>% 
                     filter(total$countries =="United States"|
                              total$countries =="Japan"|
                              total$countries=="China"|
                              total$countries=="Turkey"|
                              total$countries=="Russia"|
                              total$countries=="India"|
                              total$countries=="Egypt"|
                              total$countries=="Nigeria"|
                              total$countries=="Ghana"|
                              total$countries=="Brazil"|
                              total$countries=="France"|
                              total$countries=="Vietnam"|
                              total$countries=="Rwanda"|
                              total$countries=="Mali"|
                              total$countries=="Tunisia"|
                              total$countries=="Liberia"|
                              total$countries=="Bangladesh"|
                              total$countries=="South Korea"
                     ),
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   size = 4, max.overlaps = 50) 

ggsave("figure2Ad.png", width=8, height=6)


# (e): Reduced-form relationship between GDP Growth Rates in 2020-2022 and log European settler mortality
ggplot(total, 
       aes(x = legor_uk, 
           y = mean_growth_rate_2020_2022,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.4, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) +
  ylab("Mean GDP Growth Rate in 2020-2022") +
  xlab("British Legal Origin IV") +
  theme(legend.position = "none") +
  coord_cartesian(ylim = c(-2, 10)) +
  geom_smooth(method = lm, color = "black")+
  geom_label_repel(data = total %>% 
                     filter(total$countries =="United States"|
                              total$countries =="Japan"|
                              total$countries=="China"|
                              total$countries=="Turkey"|
                              total$countries=="Russia"|
                              total$countries=="India"|
                              total$countries=="Egypt"|
                              total$countries=="Nigeria"|
                              total$countries=="Ghana"|
                              total$countries=="Brazil"|
                              total$countries=="France"),
                   aes(label=countries), 
                   label.size = NA,  
                   # label.padding=.1, 
                   # na.rm=TRUE,
                   fill = alpha(c("white"),0.5),
                   size = 4) 

ggsave("figure2Ae.png", width=8, height=6, bg = 'white')

# (f): Reduced-form relationship between nightlight in 2001 -2019 and log European settler mortality
ggplot(total, 
       aes(x = legor_uk, 
           y = mean_g_night_light_2001_2013,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.4, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2000") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) +
  ylab("Mean Nighttime Light Intensity Growth Rate in 2001-2013") +
  xlab("British Legal Origin IV") +
  theme(legend.position = "none") + 
  coord_cartesian(ylim = c(-2, 10)) +
  geom_smooth(method = lm,color = "black")+
  geom_label_repel(data = total %>% 
                     filter(total$countries =="United States"|
                              total$countries =="Japan"|
                              total$countries=="China"|
                              total$countries=="Turkey"|
                              total$countries=="Russia"|
                              total$countries=="India"|
                              total$countries=="Egypt"|
                              total$countries=="Nigeria"|
                              total$countries=="Ghana"|
                              total$countries=="Brazil"|
                              total$countries=="France"|
                              total$countries=="Vietnam"|
                              total$countries=="Rwanda"|
                              total$countries=="Mali"|
                              total$countries=="Tunisia"|
                              total$countries=="Liberia"|
                              total$countries=="Bangladesh"|
                              total$countries=="South Korea"
                     ),
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   size = 4, max.overlaps = 50) 

ggsave("figure2Af.png", width=8, height=6)
