 
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
# total <- read_dta("YOUR-DIRECTORY/replication_data/total.dta")
# ex) total <- read_dta("/Users/ayumis/Desktop/replication_data/output/total.dta")
total <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta")
total <- as.data.frame(total)
setwd("/Users/ayumis/Dropbox/アプリ/Overleaf/Curse_of_Democracy/supporting_files/figures")

total <- total %>% 
  mutate(quantile = ntile(democracy_vdem2000, 4))

total <- total %>% 
  mutate(halves = ntile(democracy_vdem2000, 2))

################################################################################
# x: the year
# y: the GDP growth rate averaged across the group
# split by levels of the democracy index in 2000. 
# df <- aggregate(total[, 5:45], list(total$quantile), FUN = mean, na.action = NULL, na.rm = TRUE)
# df_long <- gather(df, year, gdp_growth, gdp_growth1980:gdp_growth2020)
# df_long$year <- as.numeric(substr(df_long$year, 11, 15))

df <- aggregate(total[, 5:45], list(total$halves), FUN = mean, na.action = NULL, na.rm = TRUE)
df_long <- gather(df, year, gdp_growth, gdp_growth1980:gdp_growth2020)
df_long$year <- as.numeric(substr(df_long$year, 11, 15))
df_long$dem <- ifelse(df_long$Group.1 == 1, 
                      "Below Median", 
                      "Countries with Democracy Index Above Median")

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

ggsave("econ_growth_by_dem_median.png", width=8, height=6)

################################################################################
## GDP growth in 2001-2019

group_names <- list(
  "First Quartile (Mean Democracy Index: -1.3)",
  "Second Quartile (Mean Democracy Index: -0.5)",
  "Third Quartile (Mean Democracy Index: 0.5)",
  "Fourth Quartile (Mean Democracy Index: 1.3)"
)

# df_long[df_long$Group.1 == 1,]$group <- "First Quartile (Mean Democracy Index: -1.3)"
# df_long[df_long$Group.1 == 2,]$group <- "Second Quartile (Mean Democracy Index: -0.5)"
# df_long[df_long$Group.1 == 3,]$group <- "Third Quartile (Mean Democracy Index: 0.5)"
# df_long[df_long$Group.1 == 4,]$group <- "Fourth Quartile (Mean Democracy Index: 1.3"

labeller <- function(variable,value){
  return(group_names[value])
}

ggplot(df_long, 
       aes(x = year, 
           y = gdp_growth)) + 
  ylab("Mean GDP Growth Rate") +
  xlab("Year") +
  geom_line() + 
  theme_ipsum(axis_title_size = 20) + 
  facet_wrap(~ Group.1, labeller = labeller) +
  geom_hline(yintercept = 3.9, linetype = "dashed")

# ggsave("exp1.png", width=8, height=6)

group_names <- list(
  "1st Quartile",
  "2nd Quartile",
  "3rd Quartile",
  "4th Quartile"
)

ggplot(df_long, 
       aes(x = year, 
           y = gdp_growth)) + 
  ylab("Mean GDP Growth Rate") +
  xlab("Year") +
  geom_line() + 
  theme_ipsum(axis_title_size = 20) + 
  facet_grid(Group.1~., labeller = labeller) + 
  geom_hline(yintercept = 3.9, linetype = "dashed") +
  geom_hline(yintercept = 0)


ggplot(df_long, 
       aes(x = year, 
           y = gdp_growth)) + 
  ylab("Mean GDP Growth Rate") +
  xlab("Year") +
  geom_line() + 
  theme_ipsum(axis_title_size = 20) + 
  facet_grid(.~Group.1, labeller = labeller) + 
  geom_hline(yintercept = 3.9, linetype = "dashed") 

################################################################################
mean(total[total$quantile == 1,]$democracy_vdem2000, na.rm=TRUE)
ggplot(df_long[df_long$Group.1==1,], 
       aes(x = year, 
           y = gdp_growth)) + 
  ylab("Mean GDP Growth Rate") +
  xlab("Year") +
  geom_line() + 
  theme_ipsum(axis_title_size = 20) + 
  scale_color_viridis(discrete = TRUE) + 
  coord_cartesian(ylim = c(-2, 10)) + 
  ggtitle("First Quartile (Mean Democracy Index: -1.3)") + 
  theme(plot.title = element_text(hjust = 0.5, size = 20)) +
  geom_hline(yintercept = 3.9, linetype = "dashed")

ggsave("q1.png", width=8, height=6)


mean(total[total$quantile == 2,]$democracy_vdem2000, na.rm=TRUE)
ggplot(df_long[df_long$Group.1==2,], 
       aes(x = year, 
           y = gdp_growth)) + 
  ylab("Mean GDP Growth Rate") +
  xlab("Year") +
  geom_line() + 
  theme_ipsum(axis_title_size = 20) + 
  scale_color_viridis(discrete = TRUE)  + 
  coord_cartesian(ylim = c(-2, 10)) + 
  ggtitle("Second Quartile (Mean Democracy Index: -0.5)") + 
  theme(plot.title = element_text(hjust = 0.5, size = 20))  +
  geom_hline(yintercept = 3.9, linetype = "dashed")
ggsave("q2.png", width=8, height=6)


mean(total[total$quantile == 3,]$democracy_vdem2000, na.rm=TRUE)
ggplot(df_long[df_long$Group.1==3,], 
       aes(x = year, 
           y = gdp_growth)) + 
  ylab("Mean GDP Growth Rate") +
  xlab("Year") +
  geom_line() + 
  theme_ipsum(axis_title_size = 20) + 
  scale_color_viridis(discrete = TRUE)  + 
  coord_cartesian(ylim = c(-2, 10)) + 
  ggtitle("Third Quartile (Mean Democracy Index: 0.5)") + 
  theme(plot.title = element_text(hjust = 0.5, size = 20))  +
  geom_hline(yintercept = 3.9, linetype = "dashed")
ggsave("q3.png", width=8, height=6)


mean(total[total$quantile == 4,]$democracy_vdem2000, na.rm=TRUE)
ggplot(df_long[df_long$Group.1==4,], 
       aes(x = year, 
           y = gdp_growth)) + 
  ylab("Mean GDP Growth Rate") +
  xlab("Year") +
  geom_line() + 
  theme_ipsum(axis_title_size = 20) + 
  scale_color_viridis(discrete = TRUE)  + 
  coord_cartesian(ylim = c(-2, 10)) + 
  ggtitle("Fourth Quartile (Mean Democracy Index: 1.3") + 
  theme(plot.title = element_text(hjust = 0.5, size = 20))  +
  geom_hline(yintercept = 3.9, linetype = "dashed")

ggsave("q4.png", width=8, height=6)



