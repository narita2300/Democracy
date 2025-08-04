
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)

total <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta")
total <- as.data.frame(total)
setwd("/Users/ayumis/Dropbox/アプリ/Overleaf/Curse_of_Democracy/supporting_files/figures")

X <- c(
  "democracy_vdem2000", 
  "democracy_vdem2019", 
  "democracy_vdem2019")
X_titles <- c(
  "Democracy Index (V-Dem) in 2000", 
  "Democracy Index (V-Dem) in 2019", 
  "Democracy Index (V-Dem) in 2019")

Y <- c("mean_growth_rate_2001_2019", 
       "gdp_growth2020", 
       "total_deaths_per_million")

Y_titles <- c("Mean GDP Growth Rate in 2001-2019", 
              "GDP Growth Rate in 2020", 
              "Covid-19-related Deaths Per Million in 2020")

Y_min <- c(0, 
           -15, 
           0)

Y_max <- c(10, 
           10, 
           1500)

Y_index <- c("democracy_vdem2000", 
             "democracy_vdem2019", 
             "democracy_vdem2019")

Y_weighting <- c("total_gdp2000", 
                 "total_gdp2019",
                 "total_gdp2019")


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
      theme_ipsum(axis_title_size = 22) +
      ylab(Y_titles[i]) +
      xlab(X_titles[i]) +
      theme(legend.position = "none") + 
      geom_smooth(method = lm, color = "black") +
      coord_cartesian(ylim = c(Y_min[i], Y_max[i])) +
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
    ggsave(paste(Y[i], "_", X[i], ".png", sep = ""), width = 8, height = 6)
}

