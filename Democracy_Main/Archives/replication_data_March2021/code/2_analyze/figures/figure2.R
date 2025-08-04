
library(ggplot2)
library(viridis)
library(hrbrthemes)

total <- read_dta("/Users/ayumis/Desktop/replication_data/total.dta")
total <- as.data.frame(total)
setwd("/Users/ayumis/Desktop/replication_data/output/figure2")

# Figure 2
# (a) 1st stage relationship between democracy (freedom house) and log European settler mortality IV
ggplot(total, 
       aes(x = logem, 
           y = democracy_fh,
           weight = population,
           size = population,
           fill = democracy_fh)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 40), 
             name = "population") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 22) +
  theme(legend.position="bottom") +
  ylab("Democracy Index (Freedom House)") +
  xlab("Log European Settler Mortality IV") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm)+
  geom_label(data = total %>% 
               filter(countries =="United States"|
                        countries =="Japan"|
                        countries=="China"|
                        countries=="Russia"|
                        countries=="Brazil"|
                        countries=="India"|
                        countries=="Germany"|
                        countries=="Egypt"|
                        countries=="Nigeria"
               ),
             aes(label=countries), 
             fill = "white",
             size = 7)
ggsave("fh_logem_noControls_popWeighted_1stStage.png", width=8, height=6)

# (b) 1st stage relationship between democracy (freedom house) and fraction speaking European IV
ggplot(total, 
       aes(x = EurFrac, 
           y = democracy_fh,
           weight = population,
           size = population,
           fill = democracy_fh)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 40), 
             name = "population") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 22) +
  theme(legend.position="bottom") +
  ylab("Democracy Index (Freedom House)") +
  xlab("Fraction Speaking European IV") +
  theme(legend.position = "none") + 
  coord_cartesian(xlim = c(-0.05, 1.05)) +
  geom_smooth(method = lm)+
  geom_label(data = total %>% 
               filter(countries =="United States"|
                        countries =="Japan"|
                        countries=="China"|
                        countries=="Russia"|
                        countries=="Brazil"|
                        countries=="India"|
                        countries=="Germany"|
                        countries=="Egypt"|
                        countries=="Nigeria"
               ),
             aes(label=countries), 
             fill = "white",
             size = 7)

ggsave("fh_EurFrac_noControls_popWeighted_1stStage.png", width=8, height=6)

# (c): Reduced-form relationship between GDP Growth Rates in 2020 and log European settler mortality
ggplot(total, 
       aes(x = logem, 
           y = gdp_growth,
           weight = population,
           size = population,
           fill = democracy_fh)) + 
  geom_point(alpha = 0.4, shape=21, color="black") +
  scale_size(range = c(.1, 30), 
             name = "population") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20) +
  theme(legend.position="bottom") +
  ylab("GDP Growth Rate in 2020") +
  xlab("Log European Settler Mortality IV") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm)+
  coord_cartesian(ylim = c(-15, 10)) +
  geom_label(data = total %>% 
               filter(countries =="United States"|
                        countries =="Japan"|
                        countries=="China"|
                        countries=="Russia"|
                        countries=="Brazil"|
                        countries=="India"|
                        countries=="Germany"|
                        countries=="Egypt"|
                        countries=="Nigeria"
               ),
             aes(label=countries), 
             fill = "white",
             size = 6)

ggsave("gdp_logem_noControls_popWeighted_ols.png", width=8, height=6)

# (d): Reduced-form relationship between Covid-19-related deaths per million and log European settler mortality IV 
ggplot(total, 
       aes(x = logem, 
           y = total_deaths_per_million,
           weight = population,
           size = population,
           fill = democracy_fh)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 30), 
             name = "population") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 22) +
  theme(legend.position="bottom") +
  ylab("Covid-19-related Deaths Per Million") +
  xlab("Log European Settler Mortality IV") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm)+
  coord_cartesian(ylim = c(0, 1200)) +
  geom_label(data = total %>% 
               filter(countries =="United States"|
                        countries =="Japan"|
                        countries=="China"|
                        countries=="Russia"|
                        countries=="Brazil"|
                        countries=="India"|
                        countries=="Germany"|
                        countries=="Egypt"|
                        countries=="Nigeria"
               ),
             aes(label=countries), 
             fill = "white",
             size = 7)

ggsave("deaths_logem_noControls_popWeighted_ols.png", width=8, height=6)


