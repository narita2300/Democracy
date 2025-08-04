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

total$mean_dem_vdem_change_2001_2019 = 10*total$mean_dem_vdem_change_2001_2019
total$mean_dem_vdem_change_2001_2013 = 10*total$mean_dem_vdem_change_2001_2013

# Figure 2
# (a) 1st stage relationship between democracy change (V-Dem) and log European settler mortality IV
ggplot(total, 
       aes(x = logem, 
           y = mean_dem_vdem_change_2001_2019,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = mean_dem_vdem_change_2001_2019)) + 
  geom_point(alpha = 0.5, shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 22) +
  theme(legend.position="bottom") +
  ylab("Mean Democracy Annual Change in 2001-2019") +
  xlab("Log European Settler Mortality IV") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14))+ 
  coord_cartesian(ylim = c(-0.2, 0.2))+
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
                              total$countries=="France"|
                              total$countries=="Vietnam"|
                              total$countries=="Indonesia"|
                              total$countries=="Malaysia"|
                              total$countries=="South Africa"
                     ),
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   size = 4) 

ggsave("figure2a_change.png", width=8, height=6)

# (b) 1st stage relationship between democracy change (V-Dem) and Log Population Density in 1500s IV
ggplot(total, 
       aes(x = lpd1500s, 
           y = mean_dem_vdem_change_2001_2019,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = mean_dem_vdem_change_2001_2019)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 22) +
  theme(legend.position="bottom",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) +
  ylab("Mean Democracy Annual Change in 2001-2019") +
  xlab("Log Population Density in 1500s IV") +
  theme(legend.position = "none") + 
  coord_cartesian(ylim = c(-0.2, 0.2)) +
  geom_smooth(method = lm, color = "black")+
  geom_label_repel(data = total %>% 
                     filter(total$countries =="United States"|
                              total$countries =="Japan"|
                              total$countries=="China"|
                              total$countries=="Turkey"|
                              total$countries=="India"|
                              total$countries=="Egypt"|
                              total$countries=="Ghana"|
                              total$countries=="Brazil"|
                              total$countries=="France"|
                              total$countries=="Germany"|
                              total$countries=="Vietnam"|
                              total$countries=="Indonesia"|
                              total$countries=="Tanzania"|
                              total$countries=="Australia"|
                              total$countries=="South Africa"|
                              total$countries=="Paraguay"|
                              total$countries=="Ethiopia"|
                              total$countries=="Singapore"|
                              total$countries=="Bangladesh"|
                              total$countries=="Burundi"|
                              total$countries=="Venezuela"),
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   size = 4) 

ggsave("figure2b_change.png", width=8, height=6)

# (c) 1st stage relationship between democracy change (V-Dem) and fraction speaking European IV
ggplot(total, 
       aes(x = EurFrac, 
           y = mean_dem_vdem_change_2001_2019,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = mean_dem_vdem_change_2001_2019)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 22) +
  theme(legend.position="bottom") +
  ylab("Mean Democracy Annual Change in 2001-2019") +
  xlab("Fraction Speaking European IV") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) + 
  coord_cartesian(xlim = c(-0.05, 1.05),
                  ylim = c(-0.2, 0.2)) +
  geom_smooth(method = lm, color = "black")+
  geom_label_repel(data = total %>% 
                     filter(total$countries =="United States"|
                              total$countries =="Japan"|
                              total$countries=="China"|
                              total$countries=="Turkey"|
                              total$countries=="India"|
                              total$countries=="Egypt"|
                              total$countries=="Ghana"|
                              total$countries=="Brazil"|
                              total$countries=="France"|
                              total$countries=="Vietnam"),
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   size = 4) 

ggsave("figure2c_change.png", width=8, height=6)

# Reduced-form relationship between GDP Growth Rates in 2001-2019 and log European settler mortality
ggplot(total, 
       aes(x = logem, 
           y = mean_growth_rate_2001_2019,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = mean_dem_vdem_change_2001_2019)) + 
  geom_point(alpha = 0.4, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2000") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) +
  ylab("Mean GDP Growth Rate in 2001-2019") +
  xlab("Log European Settler Mortality IV") +
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

ggsave("figure2d_change.png", width=8, height=6)

# Reduced-form relationship between nighttime light growth rates in 2001-2013 and log European settler mortality
ggplot(total, 
       aes(x = logem, 
           y = mean_g_night_light_2001_2013,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = mean_dem_vdem_change_2001_2013)) + 
  geom_point(alpha = 0.4, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2000") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) +
  ylab("Mean Night-time Light Intensity Growth Rate in 2001-2013") +
  xlab("Log European Settler Mortality IV") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm,color = "black")+
  coord_cartesian(ylim = c(-2, 10)) +
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
                   size = 4) 


ggsave("figure2g_change.png", width=8, height=6, bg = 'white')