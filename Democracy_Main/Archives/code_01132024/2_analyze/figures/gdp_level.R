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
# total <- read_dta("YOUR-DIRECTORY/replication_data/total.dta")
# ex) total <- read_dta("/Users/ayumis/Desktop/replication_data/output/total.dta")
total <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta")
total <- as.data.frame(total)
setwd("/Users/ayumis/Dropbox/アプリ/Overleaf/Curse_of_Democracy/supporting_files/figures")

################################################################################
## GDP per capita in 2000, GDP-weighted
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = gdppc2000,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  coord_cartesian(ylim = c(0, 40000)) +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("GDP Per Capita in 2000 (USD, current prices)") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
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

ggsave("democracy_vdem2000_gdppc2000_gdpweighted.png", width=8, height=6)

################################################################################
## GDP per capita in 2000, not-weighted
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = gdppc2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  coord_cartesian(ylim = c(0, 40000)) +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("GDP Per Capita in 2000 (USD, current prices)") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                | total$countries == "Nigeria"
                                ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 5, 
                   min.segment.length = 0,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))

ggsave("democracy_vdem2000_gdppc2000_unweighted.png", width=8, height=6)

################################################################################
## Total GDP in 2000, weighted 
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = total_gdp2000,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  coord_cartesian(ylim = c(0, 10000)) +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Total GDP in 2000 (billion USD, current prices)") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
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

ggsave("democracy_vdem2000_total_gdp2000_gdpweighted.png", width=8, height=6)

################################################################################
## Total GDP in 2000, not-weighted 
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  coord_cartesian(ylim = c(0, 2000)) +
  ylab("Total GDP in 2000 (billion USD, current prices)") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                | total$countries == "Nigeria"
                                ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 5, 
                   min.segment.length = 0,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))

ggsave("democracy_vdem2000_total_gdp2000_unweighted.png", width=8, height=6)

################################################################################
ggplot(total, 
       aes(x = logem4, 
           y = democracy_vdem2000,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Democracy Index (V-Dem) in 2000") +
  xlab("Log European Settler Mortality") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                | total$countries == "Nigeria"
                                ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 5, 
                   min.segment.length = 0,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))

ggsave("logem4_democracy_vdem2000_gdpweighted.png", width=8, height=6)
################################################################################
ggplot(total, 
       aes(x = logem4, 
           y = democracy_vdem2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Democracy Index (V-Dem) in 2000") +
  xlab("Log European Settler Mortality") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                | total$countries == "Nigeria"
                                ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 5, 
                   min.segment.length = 0,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))
ggsave("logem4_democracy_vdem2000_unweighted.png", width=8, height=6)

################################################################################
ggplot(total, 
       aes(x = logem4, 
           y = gdppc2000,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  coord_cartesian(ylim = c(0, 40000)) +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("GDP Per Capita in 2000 (USD, current prices)") +
  xlab("Log European Settler Mortality") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                | total$countries == "Nigeria"
                                ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 5, 
                   min.segment.length = 0,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))
ggsave("logem4_gdppc2000_gdpweighted.png", width=8, height=6)

################################################################################
ggplot(total, 
       aes(x = logem4, 
           y = gdppc2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  coord_cartesian(ylim = c(0, 40000)) +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("GDP Per Capita in 2000 (USD, current prices)") +
  xlab("Log European Settler Mortality") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                | total$countries == "Nigeria"
                                ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 5, 
                   min.segment.length = 0,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))
ggsave("logem4_gdppc2000_unweighted.png", width=8, height=6)

################################################################################
ggplot(total, 
       aes(x = logem4, 
           y = total_gdp2000,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  coord_cartesian(ylim = c(0, 10000)) +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Total GDP in 2000 (billion USD, current prices)") +
  xlab("Log European Settler Mortality") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                | total$countries == "Nigeria"
                                ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 5, 
                   min.segment.length = 0,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))
ggsave("logem4_total_gdp2000_gdpweighted.png", width=8, height=6)

################################################################################
ggplot(total, 
       aes(x = logem4, 
           y = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, 
             shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  coord_cartesian(ylim = c(0, 10000)) +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  ylab("Total GDP in 2000 (billion USD, current prices)") +
  xlab("Log European Settler Mortality") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  geom_label_repel(data = total[(total$total_gdp2000 > 1000 | total$population2000 > 100)
                                | total$countries == "Nigeria"
                                ,],
                   aes(label=countries), 
                   label.size = NA,  
                   fill = alpha(c("white"),0.5),
                   colour = "black",
                   size = 5, 
                   min.segment.length = 0,
                   direction = "both", 
                   max.overlaps = getOption("ggrepel.max.overlaps", default = 30))
ggsave("logem4_total_gdp2000_unweighted.png", width=8, height=6)
