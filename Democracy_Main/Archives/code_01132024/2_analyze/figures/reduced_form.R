
library(ggplot2)
library(ggrepel)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)

total <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta")
total <- as.data.frame(total)
setwd("/Users/ayumis/Dropbox/アプリ/Overleaf/Curse_of_Democracy/supporting_files/figures")

X <- c("logem4", 
       "lpd1500s",
       "EurFrac")
X_titles <- c("Log European Settler Mortality IV", 
              "Log Population Density in 1500s IV", 
              "Fraction Speaking European IV")

Y <- c("mean_gdppc_growth_2001_2019", 
       "gdppc_growth2020", 
       "total_deaths_per_million", 
       "mean_gdppc_growth_1981_1990", 
       "mean_gdppc_growth_1991_2000")

Y_titles <- c("Mean GDP Per Capita Growth Rate in 2001-2019", 
              "GDP Per Capita Growth Rate in 2020", 
              "Covid-19-related Deaths Per Million in 2020",
              "Mean GDP Per Capita Growth Rate in 1981-1990", 
              "Mean GDP Per Capita Growth Rate in 1991-2000")

Y_min <- c(0, 
           -15, 
           0, 
           0, 
           0)

Y_max <- c(10, 
           10, 
           1500, 
           10, 
           10)

Y_index <- c("democracy_vdem2000", 
             "democracy_vdem2019", 
             "democracy_vdem2019", 
             "democracy_vdem1980", 
             "democracy_vdem1990")

Y_weighting <- c("total_gdp2000", 
                 "total_gdp2019",
                 "total_gdp2019", 
                 "total_gdp1980", 
                 "total_gdp1990")

for (j in 1:length(Y)){
  for (i in 1:length(X)) {
    print(X[i])
    ggplot(total,
           aes_string(
             x = X[i],
             y = Y[j],
             size = Y_weighting[j],
             weight = Y_weighting[j],
             fill = Y_index[j])) +
      geom_point(alpha = 0.4,
                 shape=21)+
      scale_size(range = c(.1, 60)) +
      scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
      theme_ipsum(axis_title_size = 22) +
      ylab(Y_titles[j]) +
      xlab(X_titles[i]) +
      theme(legend.position = "none") + 
      geom_smooth(method = lm, color = "black") +
      coord_cartesian(ylim = c(Y_min[j], Y_max[j])) +
      geom_label_repel(data = total[total$total_gdp2000 > 300 
                                    | total$countries == "Nigeria",],
                       aes(label=countries), 
                       label.size = NA,  
                       fill = alpha(c("white"),0.5),
                       colour = "black",
                       size = 5, 
                       min.segment.length = 2,
                       direction = "both", 
                       max.overlaps = getOption("ggrepel.max.overlaps", default = 10)) 
    ggsave(paste("rf_", Y[j], "_", X[i], ".png", sep = ""), width = 8, height = 6)
  }
}
