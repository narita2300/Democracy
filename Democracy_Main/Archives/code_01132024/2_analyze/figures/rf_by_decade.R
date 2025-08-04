

library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)
library(ggrepel)

total <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta")
total <- as.data.frame(total)
setwd("/Users/ayumis/Dropbox/アプリ/Overleaf/Curse_of_Democracy/supporting_files/figures")

X <- c(
  "logem4", 
  "logem4", 
  "logem4", 
  "logem4",
  "logem4", 
  "logem4",
  "logem4",
  "logem4",
  
  "lpd1500s",
  "lpd1500s",
  "lpd1500s",
  "lpd1500s",
  "lpd1500s",
  "lpd1500s",
  "lpd1500s")

X_titles <- c(
  "Log European Settler Mortality IV",
  "Log European Settler Mortality IV",
  "Log European Settler Mortality IV",
  "Log European Settler Mortality IV",
  "Log European Settler Mortality IV",
  "Log European Settler Mortality IV",
  "Log European Settler Mortality IV",
  "Log European Settler Mortality IV", 
  
  "Log Population Density in 1500s IV",
  "Log Population Density in 1500s IV",
  "Log Population Density in 1500s IV",
  "Log Population Density in 1500s IV",
  "Log Population Density in 1500s IV",
  "Log Population Density in 1500s IV",
  "Log Population Density in 1500s IV")

Y <- c( 
  "mean_growth_rate_1961_2000",
  
  "mean_growth_rate_1981_2000",
  "mean_growth_rate_1961_1970", 
  "mean_growth_rate_1971_1980", 
  "mean_growth_rate_1981_1990", 
  "mean_growth_rate_1991_2000",
  "mean_growth_rate_2001_2010",
  "mean_growth_rate_2011_2019", 
  
  "mean_growth_rate_1961_2000", 
  "mean_growth_rate_1961_1970", 
  "mean_growth_rate_1971_1980", 
  "mean_growth_rate_1981_1990", 
  "mean_growth_rate_1991_2000",
  "mean_growth_rate_2001_2010",
  "mean_growth_rate_2011_2019"
)

Y_titles <- c(
  "Mean GDP Growth Rate in 1961-2000",
  "Mean GDP Growth Rate in 1981-2000",
  "Mean GDP Growth Rate in 1961-1970",
              "Mean GDP Growth Rate in 1971-1980",
              "Mean GDP Growth Rate in 1981-1990",
              "Mean GDP Growth Rate in 1991-2000",
              "Mean GDP Growth Rate in 2001-2010",
              "Mean GDP Growth Rate in 2011-2019",
              
  "Mean GDP Growth Rate in 1961-2000",
              "Mean GDP Growth Rate in 1961-1970",
              "Mean GDP Growth Rate in 1971-1980",
              "Mean GDP Growth Rate in 1981-1990",
              "Mean GDP Growth Rate in 1991-2000",
              "Mean GDP Growth Rate in 2001-2010",
              "Mean GDP Growth Rate in 2011-2019")

Y_min <- c(0,
  0,
           
  0, 
            0,
            0, 
            0,
            0,
            0,
            0,
            0, 
            0,
            0, 
            0,
            0,
            0)

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
           10, 
           10, 
           10, 
           10)

Y_index <- c( "democracy_vdem1960",
  "democracy_vdem1980",
  "democracy_vdem1960", 
              "democracy_vdem1970",
              "democracy_vdem1980", 
              "democracy_vdem1990",
              "democracy_vdem2000",
              "democracy_vdem2010",
  "democracy_vdem1960",
              "democracy_vdem1960", 
              "democracy_vdem1970",
              "democracy_vdem1980", 
              "democracy_vdem1990",
              "democracy_vdem2000",
              "democracy_vdem2010"
)

Y_weighting <- c(
  "total_gdp1960_wb",
  "total_gdp1980",
  "total_gdp1960_wb",
  "total_gdp1970_wb",
  "total_gdp1980",
  "total_gdp1990",
  "total_gdp2000",
  "total_gdp2010",
  "total_gdp1960_wb",
  "total_gdp1960_wb",
  "total_gdp1970_wb",
  "total_gdp1980",
  "total_gdp1990",
  "total_gdp2000",
  "total_gdp2010"
)


for (i in 1:length(X)) {
  print(X[i])
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
    theme_ipsum(axis_title_size = 25) +
    # ggtitle(titles[i]) +
    ylab(Y_titles[i]) +
    xlab(X_titles[i]) +
    theme(legend.position = "none",
          plot.title = element_text(hjust = 0.5), 
          plot.margin=grid::unit(c(0,0,0,0), "mm")) + 
    geom_smooth(method = lm, color = "black") +
    coord_cartesian(ylim = c(Y_min[i], Y_max[i])) +
    geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                  | total$countries == "Nigeria"
                                  ,],
                     aes(label=countries), 
                     label.size = NA,  
                     fill = alpha(c("white"),0.5),
                     colour = "black",
                     size = 5, 
                     min.segment.length = 2,
                     direction = "both", 
                     max.overlaps = getOption("ggrepel.max.overlaps", default = 30))
  ggsave(paste(Y[i], "_", X[i], "_notitle.png", sep = ""), width = 8, height = 6)
}

