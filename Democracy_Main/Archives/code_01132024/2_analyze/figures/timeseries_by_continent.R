
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

setwd("/Users/ayumis/Dropbox/アプリ/Overleaf/Curse_of_Democracy/supporting_files/figures")

################################################################################

df <- read_csv("/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/democracy/Country_Year_V-Dem_Core_CSV_v11.1/V-Dem-CY-Core-v11.1.csv")
colnames(df)[2] <- "iso3"

df2000 <- df[df$year==2000, c("iso3", "v2x_regime")]
colnames(df2000)[2] <- "regime2000"

a <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta")

geo <- read_excel("~/Dropbox/Democracy/MainAnalysis/input/controls/latitude/geo_cepii.xls") 
# colnames(geo)[4] <- "country_name"

df1 <- merge(df, df2000, by="iso3", all = TRUE)
df1 <- merge(df1, geo, by="iso3", all.x=TRUE)
df1 <- merge(df1, a, by="iso3", all.x = TRUE)
################################################################################
# deliberative component index: v2xdl_delib
# make a wide dataset where we have one observation country 
df2 <- df1[df1$year == 2000 | df1$year == 2019,
           c("iso3",
             "year",
             "v2xdl_delib")]

df_wide <- reshape(df2, 
                   idvar = "iso3", 
                   timevar = "year", 
                   direction = "wide")

df_wide$diff_v2xdl_delib_2000_2019 <- df_wide$v2xdl_delib.2019 - df_wide$v2xdl_delib.2000

# divide the dataset into countries which experienced positive/negative change 
df_wide$d_positive_change_v2xdl_delib <- ifelse(df_wide$diff_v2xdl_delib_2000_2019 > 0, 
                                                1, 
                                                0)

# merge df_wide with a
df3 <- merge(a, df_wide, by="iso3", all = TRUE)

# look at the correlation between democracy and economic growth by whether they experienced positive changes in the deliberative component


################################################################################
df1 <- df1[df1$year >= 1980,
           c("country_name",
             "country_text_id",
             "year",
             "continent",
             "regime2000",
             "v2x_regime",
             #   
             #   # high level democracy indices
             #   "v2x_polyarchy", 
             #   "v2x_libdem", 
             #   "v2x_partipdem",
             #   "v2x_delibdem", 
             #   "v2x_egaldem", 
             #   
             #   # electoral component
             #   "v2x_freexp_altinf", 
             #   "v2x_frassoc_thick",
             #   "v2x_suffr", 
             #   "v2xel_frefair", 
             #   "v2x_elecoff", 
             #   
             #   # liberalism component
             #   "v2xcl_rol", 
             #   "v2x_jucon", 
             #   "v2xlg_legcon", 
             #   
             #   # participatory component
             #   "v2x_cspart", 
             #   "v2xdd_dd", 
             #   "v2xel_locelec", 
             #   "v2xel_regelec", 
             #   
             #   # deliberative component
             #   "v2dlreason", 
             #   "v2dlcommon",
             #   "v2dlcountr", 
             #   "v2dlconslt", 
             #   "v2dlengage", 
             #   
             #   # egalitarian component
             #   "v2xeg_eqprotec",
             #   "v2xeg_eqaccess", 
             #   "v2xeg_eqdr",
             #   
             #   # equal protection index
             #   "v2clacjust", 
             #   "v2clsocgrp", 
             #   "v2clsnlpct", 
             #   
             #   # equal access index
             #   "v2pepwrgen", 
             #   "v2pepwrsoc", 
             #   "v2pepwrses", 
             #   
             #   # equal distribution of resources
             #   "v2dlencmps",
             #   "v2dlunivl", 
             #   "v2peedueq", 
             #   "v2pehealth", 
             #   
             #   # freedom of expression and alternative sources of info index
             #   "v2mecenefm", 
             #   "v2meharjrn", 
             #   "v2mebias",
             #   "v2meslfcen", 
             #   "v2mecrit", 
             #   "v2merange", 
             #   "v2cldiscm", 
             #   "v2cldiscw", 
             #   "v2clacfree",
             #   
             #   # freedom of association
             #   "v2psparban", 
             #   "v2psbars", 
             #   "v2psoppaut", 
             #   "v2elmulpar", 
             #   "v2cseeorgs", 
             #   "v2csreprss"
             # 
             )
]

regime_names <- c(
  `0` = "Closed autocracies in 2000",
  `1` = "Electoral autocracies in 2000",
  `2` = "Electoral democracies in 2000",
  `3` = "Liberal democracies in 2000" )

################################################################################
ts <- df1 %>%
  group_by(year, regime2000) %>% 
  summarise_at(c(
    "v2mecenefm", 
    "v2meharjrn", 
    "v2mebias",
    "v2meslfcen", 
    "v2mecrit", 
    "v2merange", 
    "v2cldiscm", 
    "v2cldiscw", 
    "v2clacfree"), 
    mean, 
    na.rm=TRUE)

ts_long <- gather(ts, 
                  variable, 
                  value, 
                  v2mecenefm:v2clacfree, 
                  factor_key=TRUE)
ts_long <- ts_long[!is.na(ts_long$regime2000),]

p <- ggplot(ts_long, 
            aes(x= year, 
                y = value, 
                color = variable)) + 
  geom_line() + 
  facet_wrap(~regime2000, labeller = as_labeller(regime_names)) +
  scale_color_hue(labels = c(
    "Media censorship effort",
    "Harassment of journalists",
    "Media bias",
    "Media self-censorship", 
    "Print/broadcast media critical",
    "Print/broadcast media perspectives",
    "Freedom of discussion for women",
    "Freedom of discussion for women",
    "Freedom of academic and cultural expression")) 
p 
ggsave("timeseries_freedomexpression.png", width = 8, height = 6)
################################################################################
ts <- df1 %>%
  group_by(year, continent) %>% 
  summarise_at(c(
    "v2mecenefm", 
    "v2meharjrn", 
    "v2mebias",
    "v2meslfcen", 
    "v2mecrit", 
    "v2merange", 
    "v2cldiscm", 
    "v2cldiscw", 
    "v2clacfree"), 
    mean, 
    na.rm=TRUE)

ts_long <- gather(ts, 
                  variable, 
                  value, 
                  v2mecenefm:v2clacfree, 
                  factor_key=TRUE)
ts_long <- ts_long[!is.na(ts_long$continent),]

p <- ggplot(ts_long, 
            aes(x= year, 
                y = value, 
                color = variable)) + 
  geom_line() + 
  facet_wrap(~continent) +
  scale_color_hue(labels = c(
    "Media censorship effort",
    "Harassment of journalists",
    "Media bias",
    "Media self-censorship", 
    "Print/broadcast media critical",
    "Print/broadcast media perspectives",
    "Freedom of discussion for women",
    "Freedom of discussion for women",
    "Freedom of academic and cultural expression")) 
p 
ggsave("timeseries_freedomexpression_bycontinent.png", width = 8, height = 6)

################################################################################
clos_aut2000 <-  df1[df1$regime2000 == 0, ]
elec_aut2000 <-  df1[df1$regime2000 == 1, ]
elec_dem2000 <-  df1[df1$regime2000 == 2, ]
lib_dem2000 <-  df1[df1$regime2000 == 3, ]
################################################################################
# compare  
## democracies which experienced significant decreases in the freedom of expression index
## democracies which experienced significant increases in the freedom of expression index

# change in freedom of expression index between 2000 and 2019



