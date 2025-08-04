################################################################################
# Load libraries
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)

################################################################################
# Load dataset
# total <- read_dta("YOUR-DIRECTORY/replication_data/total.dta")
# ex) total <- read_dta("/Users/ayumis/Desktop/replication_data/output/total.dta")
total <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta")
total <- as.data.frame(total)
setwd("/Users/ayumis/Dropbox/アプリ/Overleaf/Curse_of_Democracy/supporting_files/figures")

################################################################################

## (a) GDP growth in 1981-1990
ggplot(total, 
       aes(x = democracy_vdem1980, 
           y = mean_growth_rate_1981_1990,
           weight = total_gdp1980,
           size = total_gdp1980,
           fill = democracy_vdem1980)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp1980") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean GDP Growth Rate in 1981-1990") +
  xlab("Democracy Index (V-Dem) in 1980") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(-2, 10)) +
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

ggsave("figure1980s.png", width=8, height=6)

## (b) GDP growth in 1991-2000
ggplot(total, 
       aes(x = democracy_vdem1990, 
           y = mean_growth_rate_1991_2000,
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
  ylab("Mean GDP Growth Rate in 1991-2000") +
  xlab("Democracy Index (V-Dem) in 1990") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(-2, 10)) +
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

ggsave("figure1990s.png", width=8, height=6)


## (c) GDP growth in 2001-2010

ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = mean_growth_rate_2001_2010,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2000") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean GDP Growth Rate in 2001-2010") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(-2, 10.5)) +
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

ggsave("figure2000s.png", width=8, height=6)

## (d) GDP growth in 2011-2020
ggplot(total, 
       aes(x = democracy_vdem2010, 
           y = mean_growth_rate_2011_2020,
           weight = total_gdp2010,
           size = total_gdp2010,
           fill = democracy_vdem2010)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2010") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean GDP Growth Rate in 2011-2020") +
  xlab("Democracy Index (V-Dem) in 2010") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(-2, 10.5)) +
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

ggsave("figure2010s.png", width=8, height=6)


