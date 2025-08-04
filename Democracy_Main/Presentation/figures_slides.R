library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)
library(ggrepel)

total <- read_dta("C:/Documents/RA/Democracy/MainAnalysis/output/data/total.dta")
total <- as.data.frame(total)
setwd("C:/Documents/RA/Democracy/Presentation/figures")

X <- c(
  "democracy_vdem2000", 
  "democracy_vdem2010", 
  "democracy_vdem1990", 
  "democracy_vdem1980"
)

X_titles <- c(
  "Democracy Index (V-Dem) in 2000", 
  "Democracy Index (V-Dem) in 2010", 
  "Democracy Index (V-Dem) in 1990", 
  "Democracy Index (V-Dem) in 1980"
)

Y <- c("mean_growth_rate_2001_2010", 
       "mean_growth_rate_2011_2019", 
       "mean_growth_rate_1991_2000",
       "mean_growth_rate_1981_1990")

Y_titles <- c("Mean GDP Growth Rate in 2001-2010", 
              "Mean GDP Growth Rate in 2011-2019", 
              "Mean GDP Growth Rate in 1991-2000", 
              "Mean GDP Growth Rate in 1981-1990")

Y_min <- c(0, 0, 0, 0)

Y_max <- c(10, 10, 10, 10)

Y_index <- c("democracy_vdem2000", 
             "democracy_vdem2010",
             "democracy_vdem1990",
             "democracy_vdem1980"
)

Y_weighting <- c("total_gdp2000",
                 "total_gdp2010",
                 "total_gdp1990",
                 "total_gdp1980")

decades <- c("2000s", "2010s", "1990s", "1980s")  # Decades annotations

for (i in 1:length(X)) {
  print(paste(X[i], Y[i], sep = ","))
  ggplot(total,
         aes_string(
           x = X[i],
           y = Y[i],
           size = Y_weighting[i],
           weight = Y_weighting[i],
           fill = Y_index[i])) +
    geom_point(alpha = 0.4, shape = 21) +
    scale_size(range = c(.1, 60)) +
    scale_fill_viridis(discrete = FALSE, guide = FALSE, option = "A") +
    ylab(Y_titles[i]) +
    xlab(X_titles[i]) +   
    theme_ipsum(axis_title_size = 20) +
    theme(legend.position = "none",
          axis.title.x = element_text(size = 18),  # Increased axis title size
          axis.title.y = element_text(size = 18),  # Increased axis title size
          axis.text.x = element_text(size = 14),   # Increased axis text size
          axis.text.y = element_text(size = 14)) + # Increased axis text size
    geom_smooth(method = lm, color = "black") +
    coord_cartesian(ylim = c(-2, 10)) +
    geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100) | total$countries == "Nigeria", ],
                     aes(label = countries), 
                     label.size = NA,  
                     fill = alpha(c("white"), 0.5),
                     colour = "black",
                     size = 4, 
                     min.segment.length = 2,
                     direction = "both", 
                     max.overlaps = getOption("ggrepel.max.overlaps", default = 30)) +
    annotate("text", x = Inf, y = Inf, label = decades[i], color = "red", size = 15, hjust = 1.1, vjust = 1.5, angle = 0)  # Adjusted annotation size
  ggsave(paste(Y[i], "_", X[i], "_notitle_presentation.png", sep = ""), width = 8, height = 6, bg = "white")
}


############################################ Figure 1d Presentation
ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = mean_death_per_million_20_22,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean Covid-19 Deaths per Million in 2020-2022") +
  xlab("Democracy Index (V-Dem) in 2019") +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16)) + 
  geom_smooth(method = lm, 
              color = "black") +
  coord_cartesian(ylim = c(0, 1500)) +
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

ggsave("figure1d_presentation.png", width=8, height=6, bg = 'white')

#####################################
X <- c(
  "logem", 
  "lpd1500s", 
  "EurFrac", 
  "legor_uk",
  "logem",
  "logem",
  "logem")

X_titles <- c(
  "Log European Settler Mortality IV",
  "Log Population Density in 1500s IV",
  "Fraction Speaking European IV",
  "British Legal Origin IV",
  "Log European Settler Mortality IV",
  "Log European Settler Mortality IV",
  "Log European Settler Mortality IV")

Y <- c(
  "democracy_vdem2019",
  "democracy_vdem2019",
  "democracy_vdem2019",
  
  "democracy_vdem2019",
  "mean_growth_rate_2001_2019",
  "mean_growth_rate_2020_2022",
  "mean_death_per_million_20_22"
  )

Y_titles <- c(
  "Democracy Index (V-Dem) in 2019",
  "Democracy Index (V-Dem) in 2019",
  "Democracy Index (V-Dem) in 2019", 
  "Democracy Index (V-Dem) in 2019",
  "Mean GDP Growth Rate in 2001-2019", 
  "Mean GDP Growth Rate in 2020-2022", 
  "Mean Covid-19 Deaths per Million in 2020-2022"
  
  )

Y_min <- c(
  -3, 
  -3,
  -3, 
  
  -3,
  0,
  0,
  0)

Y_max <- c(3 ,3 ,3 ,3, 10,10,1500)  

Y_index <- c(
  "democracy_vdem2019",
  
  "democracy_vdem2019",
  
  "democracy_vdem2019",
  
  "democracy_vdem2019",
  "democracy_vdem2000",
  "democracy_vdem2019",
  "democracy_vdem2019"
)


Y_weighting <- c("total_gdp2019",
                 "total_gdp2019",
                 "total_gdp2019",
                 "total_gdp2019",
                 "total_gdp2000",
                 "total_gdp2019",
                 "total_gdp2019"
                 )

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
          axis.title.x = element_text(size = 16),
          axis.title.y = element_text(size = 16) ) + 
    geom_smooth(method = lm, color = "black")+
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
                     max.overlaps = getOption("ggrepel.max.overlaps", default = 30)) + ylim(Y_min[i], Y_max[i]) 
  ggsave(paste(Y[i], "_", X[i], "_notitle.png", sep = ""), width = 8, height = 6, bg = "white")
}



