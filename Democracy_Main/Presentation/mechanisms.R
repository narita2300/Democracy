################################################################################
# Load libraries
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)

################################################################################
# Load dataset
total <- read_dta("/Users/leonardofancello/Desktop/Yale/Democracy/MainAnalysisRep/output/data/total.dta")
total <- as.data.frame(total)

################################################################################
# Create plots in specified order

## 1. FTTI (with transformation)
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = -1 * new_ftti_2001_2019,  # Apply transformation locally
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean FTTI in 2001-2019 (transformed)") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black") +
  geom_label(data = total %>%
               filter(countries %in% c("United States", "Japan", "China", "Turkey", 
                                       "Russia", "India", "France", "Egypt", "Nigeria",
                                       "Iran", "Vietnam", "Mexico", "Saudi Arabia")),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("/Users/leonardofancello/Desktop/Yale/Democracy/MainAnalysisRep/Presentation New/mechanism_fig/ftti.png", 
       width=8, height=6)

## 2. Seat Weighted Population
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = new_seatw_popul_2001_2019,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean Seat Weighted Population in 2001-2019") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black") +
  geom_label(data = total %>%
               filter(countries %in% c("United States", "Japan", "China", "Turkey", 
                                       "Russia", "India", "France", "Egypt", "Nigeria",
                                       "Iran", "Vietnam", "Mexico", "Saudi Arabia")),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("/Users/leonardofancello/Desktop/Yale/Democracy/MainAnalysisRep/Presentation New/mechanism_fig/seatw_popul.png", 
       width=8, height=6)

## 3. Political Hate (with transformation)
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = -1 * new_v2smpolhate_2001_2019,  # Apply transformation locally
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean Political Hate in 2001-2019 (transformed)") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black") +
  geom_label(data = total %>%
               filter(countries %in% c("United States", "Japan", "China", "Turkey", 
                                       "Russia", "India", "France", "Egypt", "Nigeria",
                                       "Iran", "Vietnam", "Mexico", "Saudi Arabia")),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("/Users/leonardofancello/Desktop/Yale/Democracy/MainAnalysisRep/Presentation New/mechanism_fig/v2smpolhate.png", 
       width=8, height=6)

## 4. Political Social (with transformation)
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = -1 * new_v2smpolsoc_2001_2019,  # Apply transformation locally
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean Political Social in 2001-2019 (transformed)") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black") +
  geom_label(data = total %>%
               filter(countries %in% c("United States", "Japan", "China", "Turkey", 
                                       "Russia", "India", "France", "Egypt", "Nigeria",
                                       "Iran", "Vietnam", "Mexico", "Saudi Arabia")),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("/Users/leonardofancello/Desktop/Yale/Democracy/MainAnalysisRep/Presentation New/mechanism_fig/v2smpolsoc.png", 
       width=8, height=6)

## 5. Capital Growth (using original variable name)
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = mean_capital_g_2001_2019,  # Using original variable name
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean Capital Growth in 2001-2019") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black") +
  geom_label(data = total %>%
               filter(countries %in% c("United States", "Japan", "China", "Turkey", 
                                       "Russia", "India", "Germany", "Egypt", "Nigeria",
                                       "Vietnam", "Mexico", "Saudi Arabia")),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("/Users/leonardofancello/Desktop/Yale/Democracy/MainAnalysisRep/Presentation New/mechanism_fig/capital_g.png", 
       width=8, height=6)

## 6. R&D Expenditure (using original variable name)
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = rd_expenditure1,  # Using original variable name
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean R&D Expenditure in 2001-2019") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black") +
  geom_label(data = total %>%
               filter(countries %in% c("United States", "Japan", "China", "Turkey", 
                                       "Russia", "India", "Germany", "South Korea",
                                       "France", "United Kingdom", "Canada")),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("/Users/leonardofancello/Desktop/Yale/Democracy/MainAnalysisRep/Presentation New/mechanism_fig/rd_expenditure1.png", 
       width=8, height=6)

## 7. Labor (using original variable name)
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = mean_labor_2001_2019,  # Using original variable name
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean Labor in 2001-2019") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black") +
  geom_label(data = total %>%
               filter(countries %in% c("United States", "Japan", "China", "Turkey", 
                                       "Russia", "India", "Germany", "Egypt", "Nigeria",
                                       "Vietnam", "Mexico", "Indonesia", "Philippines")),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("/Users/leonardofancello/Desktop/Yale/Democracy/MainAnalysisRep/Presentation New/mechanism_fig/labor.png", 
       width=8, height=6)

## 8. TFP Growth (using original variable name)
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = mean_tfpgrowth_2001_2019,  # Using original variable name
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean TFP Growth in 2001-2019") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black") +
  geom_label(data = total %>%
               filter(countries %in% c("United States", "Japan", "China", "Turkey", 
                                       "Russia", "India", "Germany", "Egypt", "Nigeria",
                                       "Vietnam", "Mexico", "South Korea", "Poland")),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("/Users/leonardofancello/Desktop/Yale/Democracy/MainAnalysisRep/Presentation New/mechanism_fig/tfpgrowth.png", 
       width=8, height=6)

## 9. Imports (using original variable name)
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = mean_imp_2001_2019,  # Using original variable name
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean Imports in 2001-2019") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black") +
  geom_label(data = total %>%
               filter(countries %in% c("United States", "Japan", "China", "Turkey", 
                                       "Russia", "India", "Germany", "Egypt", "Nigeria",
                                       "Vietnam", "Mexico", "Thailand", "Poland")),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("/Users/leonardofancello/Desktop/Yale/Democracy/MainAnalysisRep/Presentation New/mechanism_fig/imp.png", 
       width=8, height=6)

## 10. Exports (using original variable name)
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = mean_exp_2001_2019,  # Using original variable name
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean Exports in 2001-2019") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black") +
  geom_label(data = total %>%
               filter(countries %in% c("United States", "Japan", "China", "Turkey", 
                                       "Russia", "India", "Germany", "Egypt", "Nigeria",
                                       "Vietnam", "Mexico", "Thailand", "Poland", "Malaysia")),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("/Users/leonardofancello/Desktop/Yale/Democracy/MainAnalysisRep/Presentation New/mechanism_fig/exp.png", 
       width=8, height=6)

## 11. Primary School (using original variable name)
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = primary_school1,  # Using original variable name
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean Primary School Enrollment in 2001-2019") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black") +
  geom_label(data = total %>%
               filter(countries %in% c("United States", "Japan", "China", "Turkey", 
                                       "Russia", "India", "Egypt", "Nigeria", "Pakistan",
                                       "Indonesia", "Mexico", "Ethiopia", "Bangladesh")),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("/Users/leonardofancello/Desktop/Yale/Democracy/MainAnalysisRep/Presentation New/mechanism_fig/primary_school1.png", 
       width=8, height=6)

## 12. Secondary School (using original variable name)
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = secondary_school1,  # Using original variable name
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean Secondary School Enrollment in 2001-2019") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black") +
  geom_label(data = total %>%
               filter(countries %in% c("United States", "Japan", "China", "Turkey", 
                                       "Russia", "India", "Egypt", "Nigeria", "Pakistan",
                                       "Indonesia", "Mexico", "Ethiopia", "Bangladesh")),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("/Users/leonardofancello/Desktop/Yale/Democracy/MainAnalysisRep/Presentation New/mechanism_fig/secondary_school1.png", 
       width=8, height=6)

## 13. Population Growth
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = new_pop_growth_2001_2019,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean Population Growth in 2001-2019") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black") +
  geom_label(data = total %>%
               filter(countries %in% c("United States", "Japan", "China", "Turkey", 
                                       "Russia", "India", "Egypt", "Nigeria", "Pakistan",
                                       "Indonesia", "Mexico", "Ethiopia", "Bangladesh")),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("/Users/leonardofancello/Desktop/Yale/Democracy/MainAnalysisRep/Presentation New/mechanism_fig/pop_growth.png", 
       width=8, height=6)

## 14. Median Age (using original variable name)
ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = median_age_2001_2019,  # Using original variable name
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Mean Median Age in 2001-2019") +
  xlab("Democracy Index (V-Dem) in 2000") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black") +
  geom_label(data = total %>%
               filter(countries %in% c("United States", "Japan", "China", "Turkey", 
                                       "Russia", "India", "Egypt", "Nigeria", "Germany",
                                       "Italy", "South Korea", "Canada", "Brazil")),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("/Users/leonardofancello/Desktop/Yale/Democracy/MainAnalysisRep/Presentation New/mechanism_fig/median_age.png", 
       width=8, height=6)