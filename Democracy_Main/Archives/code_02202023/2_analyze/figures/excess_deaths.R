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
total <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/total.dta")
total <- as.data.frame(total)

################################################################################
# Figure 1: OLS Regression on COVID-related outcomes
## (a) GDP growth in 2020
ggplot(total, 
       aes(x = democracy_csp2018, 
           y = excess_deaths_per_million,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_csp2018)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 40), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Excess Deaths Per Million in 2020") +
  xlab("Democracy Index (Center for Systemic Peace)") +
  theme(legend.position = "none") + 
  coord_cartesian(ylim = c(-1000, 2500)) +
  geom_smooth(method = lm)+
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Turkey"|
                        total$countries=="Russia"|
                        total$countries=="India"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=countries), 
             label.size = NA,  
             # label.padding=.1, 
             # na.rm=TRUE,
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/figures/excess_deaths.png", width=8, height=6)ggsave("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/figures/excess_deaths.png", width=8, height=6)
