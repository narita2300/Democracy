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

## (a) Effective Retirement Age Women in 1980
ggplot(total, 
       aes(x = democracy_vdem1980, 
           y = effective_ret_age_women_1980,
           weight = total_gdp1980,
           size = total_gdp1980,
           fill = democracy_vdem1980)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp1980") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("% Change Effective Retirement Age Women in 1970-1980") +
  xlab("Democracy Index (V-Dem) in 1980") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(-5, 5)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Turkey"|
                        total$countries=="Russia"|
                        total$countries=="India"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"|
                        total$countries=="South Korea"|
                        total$countries=="France"|
                        total$countries=="Saudi Arabia"|
                        total$countries=="Mexico"|
                        total$countries=="Ghana"|
                        total$countries=="Indoensia"|
                        total$countries=="South Africa"|
                        total$countries=="Paraguay"|
                        total$countries=="Poland"|
                        total$countries=="Indonesia"|
                        total$countries=="Thailand"|
                        total$countries=="Greece"|
                        total$countries=="Venezuela"),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("figure_effective_ret_age_women_1980.png", width=8, height=6)

## (b) Effective Retirement Age Women in 1990
ggplot(total, 
       aes(x = democracy_vdem1990, 
           y = effective_ret_age_women_1990,
           weight = total_gdp1990,
           size = total_gdp1990,
           fill = democracy_vdem1990)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp1990") +
  scale_fill_viridis(discrete=FALSE, 
                     guide=FALSE, 
                     option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("% Change Effective Retirement Age Women in 1980-1990") +
  xlab("Democracy Index (V-Dem) in 1990") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(-5, 5)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Turkey"|
                        total$countries=="Russia"|
                        total$countries=="India"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"|
                        total$countries=="South Korea"|
                        total$countries=="France"|
                        total$countries=="Mexico"|
                        total$countries=="Ghana"|
                        total$countries=="Qatar"|
                        total$countries=="Paraguay"|
                        total$countries=="Thailand"|
                        total$countries=="Venezuela"|
                        total$countries=="Iran"|
                        total$countries=="Jamaica"),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("figure_effective_ret_age_women_1990.png", width=8, height=6)


## (c) Effective Retirement Age Women in 2000

ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = effective_ret_age_women_2000,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2000") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("% Change Effective Retirement Age Women in 1990-2000") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(-5, 5)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Turkey"|
                        total$countries=="Russia"|
                        total$countries=="India"|
                        total$countries=="Nigeria"|
                        total$countries=="South Korea"|
                        total$countries=="France"|
                        total$countries=="Mexico"|
                        total$countries=="Ghana"|
                        total$countries=="Qatar"|
                        total$countries=="Thailand"|
                        total$countries=="Venezuela"|
                        total$countries=="Iran"|
                        total$countries=="Jamaica"|
                        total$countries=="Tunisia"|
                        total$countries=="Saudi Arabia"|
                        total$countries=="Indonesia"),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("figure_effective_ret_age_women_2000.png", width=8, height=6)

## (d) Effective Retirement Age Women in 2010
ggplot(total, 
       aes(x = democracy_vdem2010, 
           y = effective_ret_age_women_2010,
           weight = total_gdp2010,
           size = total_gdp2010,
           fill = democracy_vdem2010)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2010") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("% Change Effective Retirement Age Women in 2000-2010") +
  xlab("Democracy Index (V-Dem) in 2010") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(-5, 5)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Turkey"|
                        total$countries=="Russia"|
                        total$countries=="India"|
                        total$countries=="Egypt"|
                        total$countries=="United Kingdom"|
                        total$countries=="Saudi Arabia"|
                        total$countries=="Thailand"|
                        total$countries=="Mexico"|
                        total$countries=="Ghana"|
                        total$countries=="Iran"|
                        total$countries=="Ethiopia"|
                        total$countries=="Italy"|
                        total$countries=="Indonesia"),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("figure_effective_ret_age_women_2010.png", width=8, height=6)

## (e) Effective Retirement Age Women in 2020
ggplot(total, 
       aes(x = democracy_vdem2020, 
           y = effective_ret_age_women_2020,
           weight = total_gdp2020,
           size = total_gdp2020,
           fill = democracy_vdem2020)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2020") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("% Change Effective Retirement Age Women in 2010-2020") +
  xlab("Democracy Index (V-Dem) in 2020") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(-5, 5)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Turkey"|
                        total$countries=="Russia"|
                        total$countries=="India"|
                        total$countries=="Egypt"|
                        total$countries=="United Kingdom"|
                        total$countries=="Saudi Arabia"|
                        total$countries=="Thailand"|
                        total$countries=="Mexico"|
                        total$countries=="Ghana"|
                        total$countries=="Iran"|
                        total$countries=="Ethiopia"|
                        total$countries=="Italy"|
                        total$countries=="Indonesia"),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("figure_effective_ret_age_women_2020.png", width=8, height=6)