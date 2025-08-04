
################################################################################
# Load libraries
library(readr)
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)
library(reshape2)
library(readxl)
library(ggpubr)
library(lmtest)
library(sandwich)

setwd("/Users/ayumis/Dropbox/アプリ/Overleaf/Curse_of_Democracy/supporting_files/figures")

################################################################################

df <- read_csv("/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/democracy/Country_Year_V-Dem_Core_CSV_v11.1/V-Dem-CY-Core-v11.1.csv")
colnames(df)[2] <- "iso3"

df2000 <- df[df$year==2000, c("iso3", "v2x_regime")]
colnames(df2000)[2] <- "regime2000"

a <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta")

geo <- read_excel("~/Dropbox/Democracy/MainAnalysis/input/controls/latitude/geo_cepii.xls") 

df1 <- merge(df, df2000, by="iso3", all = TRUE)
df1 <- merge(df1, geo, by="iso3", all.x=TRUE)
df1 <- merge(df1, a, by="iso3", all.x = TRUE)
################################################################################
# deliberative component index: v2x_freexp_altinf
# measures the extent to which the deliberative principle of democracy is achieved 

# make a wide dataset where we have one observation country 
df2 <- df1[df1$year == 2000 | df1$year == 2019,
           c("iso3",
             "year",
             "v2x_freexp_altinf")]

df_wide <- reshape(df2, 
                   idvar = "iso3", 
                   timevar = "year", 
                   direction = "wide")

df_wide$diff_v2x_freexp_altinf_2000_2019 <- df_wide$v2x_freexp_altinf.2019 - df_wide$v2x_freexp_altinf.2000

labels <- c(
  `0` = "Negative change in freedom of expression index",
  `1` = "Positive change in freedom of expression index")
# divide the dataset into countries which experienced positive/negative change 
df_wide$d_positive_change_v2x_freexp_altinf <- ifelse(df_wide$diff_v2x_freexp_altinf_2000_2019 >= 0, 
                                                1, 
                                                0)
# merge df_wide with a
df3 <- merge(a, df_wide, by="iso3", all = TRUE)
df3 <- merge(df3, df2000, by="iso3", all.x = TRUE)

democracies2000 <- df3[df3$regime2000 >=2, ]
autocracies2000 <- df3[df3$regime2000 <2, ]

################################################################################

# plot 
p_all <- ggplot(df3[!is.na(df3$d_positive_change_v2x_freexp_altinf),], 
                aes(x= democracy_vdem2000, 
                    y = mean_growth_rate_2001_2019, 
                    weight = total_gdp2000)) + 
  # geom_point() + 
  facet_wrap(~d_positive_change_v2x_freexp_altinf, 
  ) + 
  geom_smooth(method="lm") + 
  geom_text(aes(label = country_name))
p_all

################################################################################ weighted 

# countries which observed positive change in freedom of expression index: more negative association between democracy and economic growth 
m <- lm(mean_growth_rate_2001_2019 ~ democracy_vdem2000, 
        weights = total_gdp2000, 
        data = democracies2000[democracies2000$d_positive_change_v2x_freexp_altinf > 0, ])
summary(m)
coeftest(m, vcov  = vcovHC(m, type="HC1"))
# countries which observed negative change in freedom of expression index: less negative association between democracy and economic growth 
m <- lm(mean_growth_rate_2001_2019 ~ democracy_vdem2000, 
        weights = total_gdp2000, 
        data = democracies2000[democracies2000$d_positive_change_v2x_freexp_altinf == 0, ])
summary(m)
coeftest(m, vcov  = vcovHC(m, type="HC1"))

# The negative association between democracy and economic growth is stronger among countries that experienced negative change in the deliberative component
p_dem2000 <- ggplot(df3[!is.na(df3$d_positive_change_v2x_freexp_altinf) & (df3$regime2000 >= 2),], 
                    aes(x= democracy_vdem2000, 
                        y = mean_growth_rate_2001_2019, 
                        weight = total_gdp2000)) + 
  facet_wrap(~d_positive_change_v2x_freexp_altinf, 
             labeller = as_labeller(labels)) + 
  geom_smooth(method="lm", 
              aes(x= democracy_vdem2000, 
                  y = mean_growth_rate_2001_2019, 
                  weight = total_gdp2000)) + 
  geom_text(aes(label = country_name)) +
  labs(x = "Democracy Index in 2000", 
       y = "Mean GDP Growth in 2001-2019") 
p_dem2000
ggsave("heterogeneous_effects_by_v2x_freexp_altinf_weighted.png", width = 8, height = 6)


################################################################################ unweighted 
# countries which observed positive change in deliberative component index: more negative association between democracy and economic growth 
m1 <- lm(mean_growth_rate_2001_2019 ~ democracy_vdem2000, 
         data = democracies2000[democracies2000$d_positive_change_v2x_freexp_altinf > 0, ])
summary(m1)
# countries which observed negative change in deliberative component index: less negative association between democracy and economic growth 
m2 <- lm(mean_growth_rate_2001_2019 ~ democracy_vdem2000, 
         data = democracies2000[democracies2000$d_positive_change_v2x_freexp_altinf == 0, ])
summary(m2)

p_dem2000 <- ggplot(df3[!is.na(df3$d_positive_change_v2x_freexp_altinf) & (df3$regime2000 >= 2),], 
                    aes(x= democracy_vdem2000, 
                        y = mean_growth_rate_2001_2019)) + 
  facet_wrap(~d_positive_change_v2x_freexp_altinf, 
             labeller = as_labeller(labels)) + 
  geom_smooth(method="lm") + 
  geom_text(aes(label = country_name)) +
  labs(x = "Democracy Index in 2000", 
       y = "Mean GDP Growth in 2001-2019") + 
  stat_cor(label.x = 0, 
           label.y = 0) +
  stat_regline_equation(label.x = 0, 
                        label.y = -.5)
p_dem2000

ggsave("heterogeneous_effects_by_v2x_freexp_altinf_unweighted.png", width = 8, height = 6)

