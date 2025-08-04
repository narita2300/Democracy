library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)

total <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta")
total <- as.data.frame(total)
setwd("/Users/ayumis/Dropbox/アプリ/Overleaf/Curse_of_Democracy/supporting_files/figures")

################################################# IV: population density 
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
  theme(legend.position="bottom") +
  ylab("Mean GDP Growth Rate in 2001-2019") +
  xlab("Log Population Density in 1500s IV") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm,color = "black")+
  coord_cartesian(ylim = c(0, 10)) +
  geom_label(data = total %>% 
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
             size = 5) 

ggsave("rf_econ21st_pd.png", width=8, height=6)




ggplot(total, 
       aes(x = lpd1500s, 
           y = gdp_growth2020,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.4, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("GDP Growth Rate in 2020") +
  xlab("Log Population Density in 1500s IV") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(-15, 10)) +
  geom_label(data = total %>% 
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
             size = 5) 
ggsave("rf_econ2020_pd.png", width=8, height=6)


# (e): Reduced-form relationship between Covid-19-related deaths per million and log European settler mortality IV 
ggplot(total, 
       aes(x = lpd1500s, 
           y = total_deaths_per_million,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, 
             shape=21, 
             color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 22) +
  theme(legend.position="bottom") +
  ylab("Covid-19-related Deaths Per Million in 2020") +
  xlab("Log Population Density in 1500s IV") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(0, 1200)) +
  geom_label(data = total %>% 
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
                        total$countries=="South Africa"|
                        total$countries=="Costa Rica"|
                        total$countries=="Canada"|
                        total$countries=="Peru"|
                        total$countries=="Australia"),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5)

ggsave("rf_deaths_pd.png", width=8, height=6)

################################################# IV: EurFrac 
ggplot(total, 
       aes(x = EurFrac, 
           y = mean_growth_rate_2001_2019,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.4, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2000") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean GDP Growth Rate in 2001-2019") +
  xlab("Fraction Speaking European IV") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm,color = "black")+
  coord_cartesian(ylim = c(0, 10)) +
  geom_label(data = total %>% 
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
             size = 5) 
ggsave("rf_econ21st_eurfrac.png", width=8, height=6)

ggplot(total, 
       aes(x = EurFrac, 
           y = gdp_growth2020,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.4, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("GDP Growth Rate in 2020") +
  xlab("Fraction Speaking European IV") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(-15, 10)) +
  geom_label(data = total %>% 
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
             size = 5) 
ggsave("rf_econ2020_eurfrac.png", width=8, height=6)


# (e): Reduced-form relationship between Covid-19-related deaths per million and log European settler mortality IV 
ggplot(total, 
       aes(x = EurFrac, 
           y = total_deaths_per_million,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, 
             shape=21, 
             color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 22) +
  theme(legend.position="bottom") +
  ylab("Covid-19-related Deaths Per Million in 2020") +
  xlab("Fraction Speaking European IV") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(0, 1200)) +
  geom_label(data = total %>% 
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
                        total$countries=="South Africa"|
                        total$countries=="Costa Rica"|
                        total$countries=="Canada"|
                        total$countries=="Peru"|
                        total$countries=="Australia"),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5)

ggsave("rf_deaths_eurfrac.png", width=8, height=6)

