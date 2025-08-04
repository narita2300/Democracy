
################################################################################
# Load libraries
library(readr)
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)
library(reshape2)
################################################################################

df <- read_csv("Dropbox/Democracy/MainAnalysis/input/democracy/Country_Year_V-Dem_Core_CSV_v11.1/V-Dem-CY-Core-v11.1.csv")
colnames(df)[2] <- "iso3"

df1 <- df[,
         c("country_name",
                           "iso3", 
                           "year", 
                           "v2x_regime", 
                           "v2x_polyarchy", 
                           "v2x_libdem", 
                           "v2x_liberal", 
                           "v2x_freexp_altinf", 
                           "v2x_frassoc_thick",
                           "v2x_suffr", 
                           "v2xel_frefair", 
                           "v2x_elecoff", 
                           "v2xcl_rol", 
                           "v2x_jucon", 
                           "v2xlg_legcon", 
                           "v2lgbicam")]

df2000 <- df[df$year==2000, c("iso3", "v2x_regime")]
colnames(df2000)[2] <- "regime2000"

df1 <- merge(df1, df2000, by="iso3", all = TRUE)

# generate the median among democracies in 2000
# df1$v2x_regime2000[df1$year == 2000] <- df1$v2x_regime
# df1 <- df1 %>% group_by(country_name) %>% mutate(regime2000 = max(v2x_regime))

democracies2000 <- df1[df1$regime2000 >=2, ]
autocracies2000 <- df1[df1$regime2000 <2, ]

################################################################################

df_wide <- dcast(melt(democracies2000, id.vars = c("country_name", "year")), country_name~variable+year)
df_wide[, 4:29] <- sapply(df_wide[, 4:29], as.numeric) # convert columns into numeric

varlist <- list("v2x_polyarchy", 
                "v2x_libdem", 
                "v2x_liberal", 
                "v2x_freexp_altinf", 
                "v2x_frassoc_thick",
                "v2x_suffr", 
                "v2xel_frefair", 
                "v2x_elecoff", 
                "v2xcl_rol", 
                "v2x_jucon", 
                "v2xlg_legcon")

ggplot(df_wide, aes(x=v2x_polyarchy_2000, 
                    y=v2x_polyarchy_2019)) + 
  geom_text(aes(label = country_name))  + 
  geom_abline(intercept = 0, slope = 1, size = 0.5)

ggplot(df_wide, aes(x=v2x_libdem_2000, 
                    y=v2x_libdem_2019)) + 
  geom_text(aes(label = country_name))  + 
  geom_abline(intercept = 0, slope = 1, size = 0.5)

ggplot(df_wide, aes(x=v2x_liberal_2000, 
                    y=v2x_liberal_2019)) + 
  geom_text(aes(label = country_name)) + 
  geom_abline(intercept = 0, slope = 1, size = 0.5)

# show that the median democratic country has experienced a loss in 
# median polyarchy, libdem, by year 



