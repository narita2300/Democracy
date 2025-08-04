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
total <- read_dta("/Users/ayumis/Desktop/replication_data/output/total.dta")
total <- as.data.frame(total)

################################################################################
# Figure 1: OLS Regression on COVID-related outcomes
## (a) GDP growth in 2020
ggplot(total, 
       aes(x = democracy_fh, 
           y = gdp_growth,
           weight = total_gdp,
           size = total_gdp,
           fill = democracy_fh)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 40), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("GDP Growth Rate in 2020") +
  xlab("Democracy Index (Freedom House)") +
  theme(legend.position = "none") + 
  coord_cartesian(ylim = c(-15, 5)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Russia"|
                        total$countries=="Brazil"|
                        total$countries=="India"|
                        total$countries=="Germany"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=countries), 
             fill = "white",
             size = 7)

ggsave("/Users/ayumis/Desktop/replication_data/output/figures/figure1a_noline.png", width=8, height=6)

## (b) Covid-related deaths per million
ggplot(total, 
       aes(x = democracy_fh, 
           y = total_deaths_per_million,
           weight = total_gdp,
           size = total_gdp,
           fill = democracy_fh)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 40), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Covid-19-related Deaths Per Million") +
  xlab("Democracy Index (Freedom House)") +
  theme(legend.position = "none") + 
  coord_cartesian(ylim = c(0, 1200)) +
  geom_label(data = total %>% 
               filter(countries =="United States"|
                        countries =="Japan"|
                        countries=="China"|
                        countries=="Russia"|
                        countries=="Brazil"|
                        countries=="India"|
                        countries=="Germany"|
                        countries=="Egypt"|
                        countries=="Nigeria"
               ),
             aes(label=countries), 
             fill = "white",
             size = 7)

ggsave("/Users/ayumis/Desktop/replication_data/output/figures/figure1b_noline.png", width=8, height=6)
