################################################################################
# Load paths
source(file.path(dirname(dirname(dirname(dirname(dirname(getwd()))))), "paths.R"))

################################################################################
# Load libraries
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)
library(ggrepel)

################################################################################
# Load dataset
total <- read_dta(file.path(main_path, "Democracy/Democracy_Main/MainAnalysis/output/data/total.dta"))
total <- as.data.frame(total)
setwd(file.path(main_path, "Democracy/Democracy_Main/MainAnalysis/output/figures/appendix"))


X <- c(
  "democracy_vdem2000", 
  "democracy_vdem2000", 
  "democracy_vdem2019", 
  "democracy_vdem1980", 
  "democracy_vdem1990", 
  "democracy_vdem2000", 
  "democracy_vdem2010", 
  "democracy_vdem1980", 
  "democracy_vdem1990", 
  "democracy_vdem2000", 
  "democracy_vdem2010", 
  "democracy_vdem2000", 
  "logem", 
  "lpd1500s", 
  "EurFrac", 
  "democracy_vdem2000",
  "democracy_vdem2000",
  "democracy_vdem2000",
  "democracy_vdem2000",
  "democracy_vdem2000",
  "democracy_vdem2000", 
  "logem", 
  "logem",
  "logem", 
  "logem",
  "logem",
  "logem", 
  "logem",
  "logem", 
  "legor_uk")

X_titles <- c(
  "Democracy Index (V-Dem) in 2000", 
  "Democracy Index (V-Dem) in 2000", 
  "Democracy Index (V-Dem) in 2019", 
  "Democracy Index (V-Dem) in 1980",
  "Democracy Index (V-Dem) in 1990",
  "Democracy Index (V-Dem) in 2000",
  "Democracy Index (V-Dem) in 2010",
  "Democracy Index (V-Dem) in 1980",
  "Democracy Index (V-Dem) in 1990",
  "Democracy Index (V-Dem) in 2000",
  "Democracy Index (V-Dem) in 2010",
  "Democracy Index (V-Dem) in 2000",
  "Log European Settler Mortality IV",
  "Log Population Density in 1500s IV",
  "Fraction Speaking European IV",
  "Democracy Index (V-Dem) in 2000",
  "Democracy Index (V-Dem) in 2000",
  "Democracy Index (V-Dem) in 2000",
  "Democracy Index (V-Dem) in 2000",
  "Democracy Index (V-Dem) in 2000",
  "Democracy Index (V-Dem) in 2000",
  "Log European Settler Mortality IV",
  "Log European Settler Mortality IV",
  "Log European Settler Mortality IV",
  "Log European Settler Mortality IV",
  "Log European Settler Mortality IV",
  "Log European Settler Mortality IV",
  "Log European Settler Mortality IV",
  "Log European Settler Mortality IV", 
  "British Legal Origin IV")

Y <- c("mean_growth_rate_2001_2019", 
       "mean_gdppc_growth_2001_2019", 
       "gdppc_growth2020", 
       "mean_gdppc_growth_1981_1990", 
       "mean_gdppc_growth_1991_2000",
       "mean_gdppc_growth_2001_2010",
       "mean_gdppc_growth_2011_2019",
       "mean_growth_rate_1981_1990", 
       "mean_growth_rate_1991_2000",
       "mean_growth_rate_2001_2010",
       "mean_growth_rate_2011_2019",
       "mean_tfpgrowth_2001_2019", 
       "democracy_vdem2019",
       "democracy_vdem2019",
       "democracy_vdem2019", 
       "mean_manu_va_growth_2001_2019",
       "mean_serv_va_growth_2001_2019", 
       "mean_investment_2001_2019", 
       "mean_tfpgrowth_2001_2019",
       "mean_import_value_2001_2019", 
       "mean_export_value_2001_2019", 
       "mean_gdppc_growth_2001_2019", 
       "gdppc_growth2020", 
       "mean_manu_va_growth_2001_2019",
       "mean_serv_va_growth_2001_2019", 
       "mean_investment_2001_2019", 
       "mean_tfpgrowth_2001_2019",
       "mean_import_value_2001_2019", 
       "mean_export_value_2001_2019", 
       "democracy_vdem2019")

Y_titles <- c("Mean GDP Growth Rate in 2001-2019", 
              "Mean GDP Per Capita Growth Rate in 2001-2019", 
              "GDP Per Capita Growth Rate in 2020", 
              "Mean GDP Per Capita Growth Rate in 1981-1990",
              "Mean GDP Per Capita Growth Rate in 1991-2000",
              "Mean GDP Per Capita Growth Rate in 2001-2010",
              "Mean GDP Per Capita Growth Rate in 2011-2019", 
              "Mean GDP Growth Rate in 1981-1990",
              "Mean GDP Growth Rate in 1991-2000",
              "Mean GDP Growth Rate in 2001-2010",
              "Mean GDP Growth Rate in 2011-2019", 
              "Mean TFP Growth Rate in 2001-2019", 
              "Democracy Index (V-Dem) in 2019",
              "Democracy Index (V-Dem) in 2019",
              "Democracy Index (V-Dem) in 2019", 
              "Mean Value Added (Manufacturing) Growth Rate in 2001-2019", 
              "Mean Value Added (Services) Growth Rate in 2001-2019",
              "Mean Investment Share of GDP in 2001-2019", 
              "Mean TFP Growth Rate in 2001-2019", 
              "Mean Import Value Index in 2001-2019 (2000=100)", 
              "Mean Export Value Index in 2001-2019 (2000=100)",
              "Mean GDP Per Capita Growth Rate in 2001-2019", 
              "GDP Per Capita Growth Rate in 2020", 
              "Mean Value Added (Manufacturing) Growth Rate in 2001-2019", 
              "Mean Value Added (Services) Growth Rate in 2001-2019",
              "Mean Investment Share of GDP in 2001-2019", 
              "Mean TFP Growth Rate in 2001-2019", 
              "Mean Import Value Index in 2001-2019 (2000=100)", 
              "Mean Export Value Index in 2001-2019 (2000=100)", 
              "Democracy Index (V-Dem) in 2019")

Y_min <- c(0, 
           0, 
           -15, 
           0,
           0,
           0,
           0, 
           0,
           0,
           0,
           0,
           -5, 
           -3, 
           -3,
           -3, 
           0,
           0, 
           10, 
           -5, 
           100, 
           100, 
           0, 
           -15, 
           0,
           0, 
           10, 
           -5, 
           100, 
           100, 
           -3)

Y_max <- c(10, 
           
           10, 
           10,
           10,
           10,
           10,
           10, 
           10,
           10,
           10,
           10, 
           5, 
           2,
           2,
           2, 
           10,
           10, 
           50, 
           5,
           700, 
           700, 
           10, 
           10, 
           10,
           10, 
           50, 
           5,
           700, 
           700, 
           2)

Y_index <- c("democracy_vdem2000", 
             "democracy_vdem2000", 
             "democracy_vdem2019",
             "democracy_vdem1980", 
             "democracy_vdem1990",
             "democracy_vdem2000",
             "democracy_vdem2010", 
             "democracy_vdem1980", 
             "democracy_vdem1990",
             "democracy_vdem2000",
             "democracy_vdem2010", 
             "democracy_vdem2000", 
             "democracy_vdem2019",
             "democracy_vdem2019",
             "democracy_vdem2019", 
             "democracy_vdem2000",
             "democracy_vdem2000",
             "democracy_vdem2000",
             "democracy_vdem2000",
             "democracy_vdem2000",
             "democracy_vdem2000",
             "democracy_vdem2000", 
             "democracy_vdem2019", 
             "democracy_vdem2019",
             "democracy_vdem2000",
             "democracy_vdem2000",
             "democracy_vdem2000",
             "democracy_vdem2000",
             "democracy_vdem2000",
             "democracy_vdem2000", 
             "democracy_vdem2019"
)

Y_weighting <- c("total_gdp2000", 
                 "total_gdp2000", 
                 "total_gdp2019",
                 "total_gdp1980",
                 "total_gdp1990",
                 "total_gdp2000",
                 "total_gdp2010",
                 "total_gdp1980",
                 "total_gdp1990",
                 "total_gdp2000",
                 "total_gdp2010",
                 "total_gdp2000",
                 "total_gdp2019",
                 "total_gdp2019",
                 "total_gdp2019", 
                 "total_gdp2000",
                 "total_gdp2000",
                 "total_gdp2000",
                 "total_gdp2000",
                 "total_gdp2000",
                 "total_gdp2000",
                 "total_gdp2000", 
                 "total_gdp2019",
                 "total_gdp2019",
                 "total_gdp2000",
                 "total_gdp2000",
                 "total_gdp2000",
                 "total_gdp2000",
                 "total_gdp2000",
                 "total_gdp2000",
                 "total_gdp2019")

for (i in 1:length(X)) {
  print(paste(X[i], Y[i], sep = ","))
  ggplot(total,
         aes_string(
           x = X[i],
           y = Y[i],
           size = Y_weighting[i],
           weight = Y_weighting[i],
           fill = Y_index[i])) +
    geom_point(alpha = 0.4,
               shape=21)+
    scale_size(range = c(.1, 60)) +
    scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
    ylab(Y_titles[i]) +
    xlab(X_titles[i]) +   theme_ipsum(axis_title_size = 20) +
    theme(legend.position = "none",
          axis.title.x = element_text(size = 14),
          axis.title.y = element_text(size = 14) ) + 
    geom_smooth(method = lm, color = "black")+
    coord_cartesian(ylim = c(-2, 10)) +
    geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                  | total$countries == "Nigeria"
                                  ,],
                     aes(label=countries), 
                     label.size = NA,  
                     fill = alpha(c("white"),0.5),
                     colour = "black",
                     size = 4, 
                     min.segment.length = 2,
                     direction = "both", 
                     max.overlaps = getOption("ggrepel.max.overlaps", default = 30))
  ggsave(paste(Y[i], "_", X[i], "_notitle.png", sep = ""), width = 8, height = 6, bg = "white")
}

# Mean Growth Rate Nighttime Light in 1993-2000
ggplot(total, 
       aes(x = democracy_vdem1990, 
           y = mean_g_night_light_1993_2000,
           weight = total_gdp1990,
           size = total_gdp1990,
           fill = democracy_vdem1990)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean Night-time Light Intensity Growth Rate in 1993-2000") +
  xlab("Democracy Index (V-Dem) in 1990") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14) ) + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(-2, 10)) +
  geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                | total$countries == "Nigeria"
                                ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 4, 
                   min.segment.length = 2,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))

ggsave("figure_mean_g_night_light_1993_2000.png", width=8, height=6)


# Mean Growth Rate Nighttime Light in 2001-2013
ggplot(total,
       aes(x = democracy_vdem2000, 
           y =  mean_g_night_light_2001_2013,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Mean Night-time Light Intensity Growth Rate in 2001-2013") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14) ) + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(-2, 10)) +
  geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                | total$countries == "Nigeria"
                                ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 4, 
                   min.segment.length = 2,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))


ggsave("figure_mean_g_night_light_2001_2013.png", width=8, height=6)

