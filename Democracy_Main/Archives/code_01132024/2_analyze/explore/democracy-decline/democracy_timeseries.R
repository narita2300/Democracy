
################################################################################
# Load libraries
library(readr)
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)
library(reshape2)

setwd("/Users/ayumis/Dropbox/アプリ/Overleaf/Curse_of_Democracy/supporting_files/figures")

################################################################################

df <- read_csv("/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/democracy/Country_Year_V-Dem_Core_CSV_v11.1/V-Dem-CY-Core-v11.1.csv")
df2000 <- df[df$year==2000, c("country_name", "v2x_regime")]
colnames(df2000)[2] <- "regime2000"
df1 <- merge(df, df2000, by="country_name", all = TRUE)

################################################################################
df1 <- df1[df1$year >= 1980,
           c("country_name",
             "country_text_id", 
             "year", 
             "regime2000",
             "v2x_regime", 
             
             # high level democracy indices
             "v2x_polyarchy", 
             "v2x_libdem", 
             "v2x_partipdem",
             "v2x_delibdem", 
             "v2x_egaldem", 
             
             # electoral component
             "v2x_freexp_altinf", 
             "v2x_frassoc_thick",
             "v2x_suffr", 
             "v2xel_frefair", 
             "v2x_elecoff", 
             
             # liberalism component
             "v2xcl_rol", 
             "v2x_jucon", 
             "v2xlg_legcon", 
             
             # participatory component
             "v2x_cspart", 
             "v2xdd_dd", 
             "v2xel_locelec", 
             "v2xel_regelec", 
             
             # deliberative component
             "v2dlreason", 
             "v2dlcommon",
             "v2dlcountr", 
             "v2dlconslt", 
             "v2dlengage", 
             
             # egalitarian component
             "v2xeg_eqprotec",
             "v2xeg_eqaccess", 
             "v2xeg_eqdr",

             # equal protection index
             "v2clacjust", 
             "v2clsocgrp", 
             "v2clsnlpct", 

             # equal access index
             "v2pepwrgen", 
             "v2pepwrsoc", 
             "v2pepwrses", 
             
             # equal distribution of resources
             "v2dlencmps",
             "v2dlunivl", 
             "v2peedueq", 
             "v2pehealth", 
             
             # freedom of expression and alternative sources of info index
             "v2mecenefm", 
             "v2meharjrn", 
             "v2mebias",
             "v2meslfcen", 
             "v2mecrit", 
             "v2merange", 
             "v2cldiscm", 
             "v2cldiscw", 
             "v2clacfree",
             
             # freedom of association
             "v2psparban", 
             "v2psbars", 
             "v2psoppaut", 
             "v2elmulpar", 
             "v2cseeorgs", 
             "v2csreprss"
             )]

regime_names <- c(
  `0` = "Closed autocracies in 2000",
  `1` = "Electoral autocracies in 2000",
  `2` = "Electoral democracies in 2000",
  `3` = "Liberal democracies in 2000" )


# temp <- df1[df1$year==2000,c("country_name", "regime2000")]

# ts <- df1 %>%
#   group_by(year, regime2000) %>% 
#   summarise_at(c("v2x_polyarchy", 
#                  "v2x_libdem", 
#                  "v2x_partipdem",
#                  "v2x_delibdem", 
#                  "v2x_egaldem"), 
#                mean, 
#                na.rm=TRUE)

# df1[,5:16] <- scale(df1[,5:16])
################################################################################
# democracies2000 <- df1[df1$regime2000 >=2, ]
# autocracies2000 <- df1[df1$regime2000 <2, ]
# 
# clos_aut2000 <-  df1[df1$regime2000 == 0, ]
# elec_aut2000 <-  df1[df1$regime2000 == 1, ]
# elec_dem2000 <-  df1[df1$regime2000 == 2, ]
# lib_dem2000 <-  df1[df1$regime2000 == 3, ]
################################################################################
# Look at changes in each of V-Dem's high level democracy indices
ts <- df1 %>%
  group_by(year, regime2000) %>% 
  summarise_at(c("v2x_polyarchy", 
                 "v2x_libdem", 
                 "v2x_partipdem",
                 "v2x_delibdem", 
                 "v2x_egaldem"), 
               mean, 
               na.rm=TRUE)

ts_long <- gather(ts, 
                  variable, 
                  value, 
                  v2x_polyarchy:v2x_egaldem, 
                  factor_key=TRUE)
ts_long <- ts_long[!is.na(ts_long$regime2000),]

p <- ggplot(ts_long, 
            aes(x= year, 
                y = value, 
                color = variable)) + 
  geom_line() + 
  facet_wrap(~regime2000, labeller = as_labeller(regime_names)) +
  scale_color_hue(labels = c("Electoral democracy index", 
                             "Liberal democracy index", 
                             "Participatory democracy index",
                             "Deliberative democracy index", 
                             "Egalitarian democracy index")) 
p
ggsave("timeseries_democracy.png", width = 8, height = 6)

################################################################################
# Look at changes in the electoral component
ts <- df1 %>%
  group_by(year, regime2000) %>% 
  summarise_at(c("v2x_freexp_altinf", 
                 "v2x_frassoc_thick",
                 "v2x_suffr", 
                 "v2xel_frefair", 
                 "v2x_elecoff"), 
               mean, 
               na.rm=TRUE)

ts_long <- gather(ts, 
                  variable, 
                  value, 
                  v2x_freexp_altinf:v2x_elecoff, 
                  factor_key=TRUE)
ts_long <- ts_long[!is.na(ts_long$regime2000),]

p <- ggplot(ts_long, 
            aes(x= year, 
                y = value, 
                color = variable)) + 
  geom_line() + 
  facet_wrap(~regime2000, labeller = as_labeller(regime_names)) +
  scale_color_hue(labels = c("Freedom of expression", 
                             "Freedom of association", 
                             "Share of population with suffrage",
                             "Clean elections index", 
                             "Elected officials index ")) 
p 
ggsave("timeseries_election.png", width = 8, height = 6)

################################################################################
# Look at changes in the liberalism component
ts <- df1 %>%
  group_by(year, regime2000) %>% 
  summarise_at(c("v2xcl_rol", 
                 "v2x_jucon", 
                 "v2xlg_legcon"), 
               mean, 
               na.rm=TRUE)

ts_long <- gather(ts, 
                  variable, 
                  value, 
                  v2xcl_rol:v2xlg_legcon, 
                  factor_key=TRUE)
ts_long <- ts_long[!is.na(ts_long$regime2000),]

p <- ggplot(ts_long, 
            aes(x= year, 
                y = value, 
                color = variable)) + 
  geom_line() + 
  facet_wrap(~regime2000, labeller = as_labeller(regime_names)) +
  scale_color_hue(labels = c("Equality before the law and individual liberty", 
                             "Judicial constraints on the executive", 
                             "Legislative constraints on the executive")) 
p 
ggsave("timeseries_liberalism.png", width = 8, height = 6)

################################################################################
# Look at changes in the participatory component
ts <- df1 %>%
  group_by(year, regime2000) %>% 
  summarise_at(c("v2x_cspart", 
                  "v2xdd_dd", 
                  "v2xel_locelec", 
                  "v2xel_regelec"), 
               mean, 
               na.rm=TRUE)

ts_long <- gather(ts, 
                  variable, 
                  value, 
                  v2x_cspart:v2xel_regelec, 
                  factor_key=TRUE)
ts_long <- ts_long[!is.na(ts_long$regime2000),]

p <- ggplot(ts_long, 
            aes(x= year, 
                y = value, 
                color = variable)) + 
  geom_line() + 
  facet_wrap(~regime2000, labeller = as_labeller(regime_names)) +
  scale_color_hue(labels = c("Civil society participation", 
                             "Direct popular vote", 
                             "Local government", 
                             "Regional government")) 
p 
ggsave("timeseries_participation.png", width = 8, height = 6)

################################################################################
# Look at changes in the deliberative component
ts <- df1 %>%
  group_by(year, regime2000) %>% 
  summarise_at(c("v2dlreason", 
                 "v2dlcommon",
                 "v2dlcountr", 
                 "v2dlconslt", 
                 "v2dlengage"), 
               mean, 
               na.rm=TRUE)

ts_long <- gather(ts, 
                  variable, 
                  value, 
                  v2dlreason:v2dlengage, 
                  factor_key=TRUE)
ts_long <- ts_long[!is.na(ts_long$regime2000),]

p <- ggplot(ts_long, 
            aes(x= year, 
                y = value, 
                color = variable)) + 
  geom_line() + 
  facet_wrap(~regime2000, labeller = as_labeller(regime_names)) +
  scale_color_hue(labels = c("Reasoned justification", 
                             "Common good justification", 
                             "Respect for counterarguments", 
                             "Range of consultation", 
                             "Engaged society")) 
p 
ggsave("timeseries_deliberative.png", width = 8, height = 6)

################################################################################
# Look at changes in the egalitarian component
ts <- df1 %>%
  group_by(year, regime2000) %>% 
  summarise_at(c("v2xeg_eqprotec",
                 "v2xeg_eqaccess", 
                 "v2xeg_eqdr"), 
               mean, 
               na.rm=TRUE)

ts_long <- gather(ts, 
                  variable, 
                  value, 
                  v2xeg_eqprotec:v2xeg_eqdr, 
                  factor_key=TRUE)
ts_long <- ts_long[!is.na(ts_long$regime2000),]

p <- ggplot(ts_long, 
            aes(x= year, 
                y = value, 
                color = variable)) + 
  geom_line() + 
  facet_wrap(~regime2000, labeller = as_labeller(regime_names)) +
  scale_color_hue(labels = c("Equal protection", 
                             "Equal access", 
                             "Equal distribution of resources")) 
p 
ggsave("timeseries_egalitarian.png", width = 8, height = 6)

################################################################################
# Look at changes in the egalitarian component
df1$v2clsnlpct <- df1$v2clsnlpct/100

ts <- df1 %>%
  group_by(year, regime2000) %>% 
  summarise_at(c(# equal protection index
    "v2clacjust", 
    "v2clsocgrp", 
    "v2clsnlpct", 
    
    # equal access index
    "v2pepwrgen", 
    "v2pepwrsoc", 
    "v2pepwrses", 
    
    # equal distribution of resources
    "v2dlencmps",
    "v2dlunivl", 
    "v2peedueq", 
    "v2pehealth"), 
               mean, 
               na.rm=TRUE)

ts_long <- gather(ts, 
                  variable, 
                  value, 
                  v2clacjust:v2pehealth, 
                  factor_key=TRUE)
ts_long <- ts_long[!is.na(ts_long$regime2000),]

p <- ggplot(ts_long, 
            aes(x= year, 
                y = value, 
                color = variable)) + 
  geom_line() + 
  facet_wrap(~regime2000, labeller = as_labeller(regime_names)) +
  scale_color_hue(labels = c("Social class equality in civil liberties", 
                             "Social group equality in civil liberties", 
                             "Percent of population with weaker civil liberties", 
                             "Power distribution by socioeconomic position", 
                             "Power distribution by social group", 
                             "Power distribution by gender", 
                             "Public goods", 
                             "Universalistic welfare policies", 
                             "Education equality",
                             "Health equality")) 
p 
ggsave("timeseries_egalitarian_detail.png", width = 8, height = 6)

################################################################################
# Look at changes in the equal protection component
df1$v2clsnlpct <- df1$v2clsnlpct/100

ts <- df1 %>%
  group_by(year, regime2000) %>% 
  summarise_at(c(# equal protection index
    "v2clacjust", 
    "v2clsocgrp", 
    "v2clsnlpct"), 
    mean, 
    na.rm=TRUE)

ts_long <- gather(ts, 
                  variable, 
                  value, 
                  v2clacjust:v2clsnlpct, 
                  factor_key=TRUE)
ts_long <- ts_long[!is.na(ts_long$regime2000),]

p <- ggplot(ts_long, 
            aes(x= year, 
                y = value, 
                color = variable)) + 
  geom_line() + 
  facet_wrap(~regime2000, labeller = as_labeller(regime_names)) +
  scale_color_hue(labels = c("Social class equality in civil liberties", 
                             "Social group equality in civil liberties", 
                             "Share of population with weaker civil liberties")) 
p 
ggsave("timeseries_equalprotection.png", width = 8, height = 6)

################################################################################
# Look at changes in the equal access component
ts <- df1 %>%
  group_by(year, regime2000) %>% 
  summarise_at(c(
    # equal access index
    "v2pepwrgen", 
    "v2pepwrsoc", 
    "v2pepwrses"), 
    mean, 
    na.rm=TRUE)

ts_long <- gather(ts, 
                  variable, 
                  value, 
                  v2pepwrgen:v2pepwrses, 
                  factor_key=TRUE)
ts_long <- ts_long[!is.na(ts_long$regime2000),]

p <- ggplot(ts_long, 
            aes(x= year, 
                y = value, 
                color = variable)) + 
  geom_line() + 
  facet_wrap(~regime2000, labeller = as_labeller(regime_names)) +
  scale_color_hue(labels = c(
                             "Equal power distribution by socioeconomic position", 
                             "Equal power distribution by social group", 
                             "Power distribution by gender"
                             )) 
p 
ggsave("timeseries_equalaccess.png", width = 8, height = 6)

################################################################################
ts <- df1 %>%
  group_by(year, regime2000) %>% 
  summarise_at(c(
    # equal distribution of resources
    "v2dlencmps",
    "v2dlunivl", 
    "v2peedueq", 
    "v2pehealth"), 
    mean, 
    na.rm=TRUE)

ts_long <- gather(ts, 
                  variable, 
                  value, 
                  v2dlencmps:v2pehealth, 
                  factor_key=TRUE)
ts_long <- ts_long[!is.na(ts_long$regime2000),]

p <- ggplot(ts_long, 
            aes(x= year, 
                y = value, 
                color = variable)) + 
  geom_line() + 
  facet_wrap(~regime2000, labeller = as_labeller(regime_names)) +
  scale_color_hue(labels = c(
                             "Public goods", 
                             "Universalistic welfare policies", 
                             "Education equality",
                             "Health equality")) 
p 
ggsave("timeseries_equaldistribution.png", width = 8, height = 6)

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
  group_by(year, regime2000) %>% 
  summarise_at(c(
    "v2psparban", 
    "v2psbars", 
    "v2psoppaut", 
    "v2elmulpar", 
    "v2cseeorgs", 
    "v2csreprss"), 
    mean, 
    na.rm=TRUE)
ts_long <- gather(ts, 
                  variable, 
                  value, 
                  v2psparban:v2csreprss, 
                  factor_key=TRUE)
ts_long <- ts_long[!is.na(ts_long$regime2000),]

p <- ggplot(ts_long, 
            aes(x= year, 
                y = value, 
                color = variable)) + 
  geom_line() + 
  facet_wrap(~regime2000, labeller = as_labeller(regime_names)) +
  scale_color_hue(labels = c(
    "Party ban",
    "Barriers to parties",
    "Opposition party autonomy",
    "Elections multiparty",
    "CSO entry and exit", 
    "CSO repression")) 
p 
ggsave("timeseries_freedomassociation.png", width = 8, height = 6)


