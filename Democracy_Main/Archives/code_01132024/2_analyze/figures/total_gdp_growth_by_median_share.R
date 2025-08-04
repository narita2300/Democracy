# x: the year
# y: the GDP growth rate averaged across the group
# split by levels of the democracy index in 2000. 

################################################################################
# Load libraries
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)

################################################################################
# Load dataset
total <- read_csv("total.csv")

################################################################################
# x: the year
# y: the GDP growth rate averaged across the group
# split by levels of the democracy index in 2000. 
df <- aggregate(total[, 6:45], list(total$halves), FUN = mean, na.action = NULL, na.rm = TRUE)
df_long <- gather(df, year, gdp_growth, gdp_growth1981:gdp_growth2020)
df_long$year <- as.numeric(substr(df_long$year, 11, 15))

df_long$dem <- ifelse(df_long$Group.1 == 1, 
                      "Below Median", 
                      "Countries with Democracy Index Above Median")

write.csv(df_long, file = "df_long.csv")


ggplot(df_long, 
       aes(x = year, 
           y = gdp_growth, 
           group = dem)) + 
  geom_line(aes(linetype=dem, color = dem)) + 
  theme_ipsum(axis_title_size = 20) +
  scale_linetype_discrete(limits = c("Countries with Democracy Index Above Median",
                                     "Below Median")) +
  scale_color_hue(limits = c("Countries with Democracy Index Above Median",
                             "Below Median")) +
  labs(x = "Year",
       y = "Mean GDP Growth Rate") +
  geom_vline(xintercept = 2000) +
  theme(legend.title = element_blank(), 
        legend.text = element_text(size = 15),
        legend.position = "bottom")

ggsave("total_gdp_growth_by_dem_median.png", width=8, height=6)
################################################################################