################################################################################
# Load libraries
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)
library(ggrepel)

################################################################################
# Load paths
source("../../../../paths.R")

################################################################################
# Load dataset
total <- read_dta(file.path(path_data, "total.dta"))
total <- as.data.frame(total)
output_dir <- file.path(path_output_figures, "extensions/old")
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}
setwd(output_dir)

################################################################################

## (a) Tax Burden 2023
ggplot(total, 
       aes(x = democracy_vdem2020, 
           y = tax_burden2023,
           weight = total_gdp2022,
           size = total_gdp2022,
           fill = democracy_vdem2020)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2022") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Tax Burden 2023") +
  xlab("Democracy Index (V-Dem) in 2020") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(0, 60)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Turkey"|
                        total$countries=="Russia"|
                        total$countries=="India"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"|
                        total$countries=="South Korea"|
                        total$countries=="France"|
                        total$countries=="Saudi Arabia"|
                        total$countries=="Mexico"|
                        total$countries=="Ghana"|
                        total$countries=="Indoensia"|
                        total$countries=="South Africa"|
                        total$countries=="Paraguay"|
                        total$countries=="Poland"|
                        total$countries=="Indonesia"|
                        total$countries=="Thailand"|
                        total$countries=="Greece"|
                        total$countries=="Venezuela"),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("figure_tax_burden2023.png", width=8, height=6)

## (b) Avg Corporate Tax Rate 2023
ggplot(total, 
       aes(x = democracy_vdem2020, 
           y = corporate_tax_rate2023,
           weight = total_gdp2022,
           size = total_gdp2022,
           fill = democracy_vdem2020)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2022") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Avg Corporate Tax Rate 2023") +
  xlab("Democracy Index (V-Dem) in 2020") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(0, 60)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Turkey"|
                        total$countries=="Russia"|
                        total$countries=="India"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"|
                        total$countries=="South Korea"|
                        total$countries=="France"|
                        total$countries=="Saudi Arabia"|
                        total$countries=="Mexico"|
                        total$countries=="Ghana"|
                        total$countries=="Indoensia"|
                        total$countries=="South Africa"|
                        total$countries=="Paraguay"|
                        total$countries=="Poland"|
                        total$countries=="Indonesia"|
                        total$countries=="Thailand"|
                        total$countries=="Greece"|
                        total$countries=="Venezuela"),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("figure_corporate_tax_rate2023.png", width=8, height=6)

## (c) Avg Income Tax Rate 2023
ggplot(total, 
       aes(x = democracy_vdem2020, 
           y = income_tax_rate2023,
           weight = total_gdp2022,
           size = total_gdp2022,
           fill = democracy_vdem2020)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2022") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Avg Income Tax Rate 2023") +
  xlab("Democracy Index (V-Dem) in 2020") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(0, 60)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Turkey"|
                        total$countries=="Russia"|
                        total$countries=="India"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"|
                        total$countries=="South Korea"|
                        total$countries=="France"|
                        total$countries=="Saudi Arabia"|
                        total$countries=="Mexico"|
                        total$countries=="Ghana"|
                        total$countries=="Indoensia"|
                        total$countries=="South Africa"|
                        total$countries=="Paraguay"|
                        total$countries=="Poland"|
                        total$countries=="Indonesia"|
                        total$countries=="Thailand"|
                        total$countries=="Greece"|
                        total$countries=="Venezuela"),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("figure_income_tax_rate2023.png", width=8, height=6)

## (d) Avg Sales Taxes 2023
ggplot(total, 
       aes(x = democracy_vdem2020, 
           y = sales_taxes2023,
           weight = total_gdp2022,
           size = total_gdp2022,
           fill = democracy_vdem2020)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2022") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("Avg Sales Taxes 20233") +
  xlab("Democracy Index (V-Dem) in 2020") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, color = "black")+
  coord_cartesian(ylim = c(0, 60)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Turkey"|
                        total$countries=="Russia"|
                        total$countries=="India"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"|
                        total$countries=="South Korea"|
                        total$countries=="France"|
                        total$countries=="Saudi Arabia"|
                        total$countries=="Mexico"|
                        total$countries=="Ghana"|
                        total$countries=="Indoensia"|
                        total$countries=="South Africa"|
                        total$countries=="Paraguay"|
                        total$countries=="Poland"|
                        total$countries=="Indonesia"|
                        total$countries=="Thailand"|
                        total$countries=="Greece"|
                        total$countries=="Venezuela"),
             aes(label=countries), 
             label.size = NA,  
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("figure_sales_taxes2023.png", width=8, height=6)