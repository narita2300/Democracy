
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
  "democracy_vdem2000", 
  "democracy_vdem2000", 
  "democracy_vdem2000", 
  "democracy_vdem2000", 
  "democracy_vdem2000", 
  "democracy_vdem2000"
  )

X_titles <- c(
  "Democracy Index (V-Dem) in 2000", 
  "Democracy Index (V-Dem) in 2000", 
  "Democracy Index (V-Dem) in 2000", 
  "Democracy Index (V-Dem) in 2000", 
  "Democracy Index (V-Dem) in 2000", 
  "Democracy Index (V-Dem) in 2000"
  )

Y <- c("mean_manu_va_growth_2001_2019",
       "mean_serv_va_growth_2001_2019", 
       "mean_investment_2001_2019", 
       "mean_tfpgrowth_2001_2019",
       "mean_import_value_2001_2019", 
       "mean_export_value_2001_2019")

Y_titles <- c("Mean Value Added (Manufacturing) Growth Rate in 2001-19", 
              "Mean Value Added (Services) Growth Rate in 2001-19",
              "Mean Investment Share of GDP in 2001-19", 
              "Mean TFP Growth Rate in 2001-19", 
              "Mean Import Value Index in 2001-19 (2000=100)", 
              "Mean Export Value Index in 2001-19 (2000=100)")

Y_min <- c(0,
           0, 
           10, 
           -5, 
           100, 
           100)

Y_max <- c(10,
           10, 
           50, 
           5,
           700, 
           700)

Y_index <- c("democracy_vdem2000",
             "democracy_vdem2000",
             "democracy_vdem2000",
             "democracy_vdem2000",
             "democracy_vdem2000",
             "democracy_vdem2000"
)

Y_weighting <- c("total_gdp2000",
                 "total_gdp2000",
                 "total_gdp2000",
                 "total_gdp2000",
                 "total_gdp2000",
                 "total_gdp2000")


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
    theme_ipsum(axis_title_size = 23) +
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

# m <- lm(mean_tfpgrowth_2001_2019 ~ democracy_vdem2000, total, total_gdp2000)