################################################################################
# Load libraries
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)
library(systemfonts)
remotes::install_github("Gedevan-Aleksizde/fontregisterer", repos = NULL, type = "source")
require(fontregisterer)

if(Sys.info()["sysname"] == "Windows"){
  if(as.integer(str_extract(Sys.info()["release"], "^[0-9]+")) >=8){
    family_sans <- "Yu Gothic"
    family_serif <- "Yu Mincho"
  } else {
    family_sans <- "MS Gothic"
    family_serif <- "MS Mincho"
  }
} else if(Sys.info()["sysname"] == "Linux") {
  family_sans <- "Noto Sans CJK JP"
  family_serif <- "Noto Serif CJK JP"
} else if(Sys.info()["sysname"] == "Darwin"){
  family_serif <- "Hiragino Mincho ProN"
  family_sans <- "Hiragino Sans"
} else {
  # インストールすればとりあえず動く
  family_sans <- "Noto Sans CJK JP"
  family_serif <- "Noto Serif CJK JP"
}
################################################################################
# Load dataset
# total <- read_dta("YOUR-DIRECTORY/replication_data/total.dta")
# ex) total <- read_dta("/Users/ayumis/Desktop/replication_data/output/total.dta")
total <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta")
total <- as.data.frame(total)
# setwd("/Users/ayumis/Dropbox/アプリ/Overleaf/Curse_of_Democracy/supporting_files/figures")

################################################################################

# Add columns of Japanese names of the main countries
total$japanese_name[total$countries =="United States"] <- "アメリカ"
total$japanese_name[total$countries =="Japan"] <- "日本"
total$japanese_name[total$countries =="China"] <- "中国"
total$japanese_name[total$countries =="Russia"] <- "ロシア"
total$japanese_name[total$countries =="Brazil"] <- "ブラジル"
total$japanese_name[total$countries =="India"] <- "インド"
total$japanese_name[total$countries =="Germany"] <- "ドイツ"
total$japanese_name[total$countries =="Egypt"] <- "エジプト"
total$japanese_name[total$countries =="Nigeria"] <- "ナイジェリア"
total$japanese_name[total$countries =="France"] <- "フランス"
################################################################################
# Figure 1: OLS Regression on COVID-related outcomes
## (a) GDP growth in 2020

# theme_set(theme_ipsum(base_family="HiraKakuProN-W3"))
# update_geom_defaults("text", list(family = theme_get()$text$family))
# update_geom_defaults("label", list(family = theme_get()$text$family))

theme_set(theme_ipsum(base_family="HiraKakuProN-W3"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))


ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = gdp_growth2020,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 40), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "HiraKakuProN-W3") +
  theme(legend.position="bottom") +
  ylab("2020年のGDP成長率") +
  xlab("民主主義指数") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, 
              color = 'black')+
  coord_cartesian(ylim = c(-15, 5)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Russia"|
                        total$countries=="Brazil"|
                        total$countries=="India"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=japanese_name), 
             label.size = NA,  
             # label.padding=.1, 
             # na.rm=TRUE,
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1b_japanese.png", width=8, height=6)

## (b)-1 GDP growth in 2001-2019

ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = mean_growth_rate_2001_2019,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2000") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "HiraKakuProN-W3") +
  theme(legend.position="bottom") +
  ylab("2001-2019年のGDP平均成長率") +
  xlab("民主主義指数") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, 
              color = 'black')+
  coord_cartesian(ylim = c(0, 10), xlim = c(-1.5, 2)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Russia"|
                        total$countries=="France"|
                        total$countries=="Brazil"|
                        total$countries=="India"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=japanese_name), 
             label.size = NA,  
             # label.padding=.1, 
             # na.rm=TRUE,
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1a1_japanese.png", width=8, height=6)

## (b)-1 GDP growth in 2001-2019

ggplot(total, 
       aes(x = democracy_vdem2000, 
           y = mean_growth_rate_2001_2019,
           weight = total_gdp2000,
           size = total_gdp2000,
           fill = democracy_vdem2000)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2000") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "HiraKakuProN-W3") +
  theme(legend.position="bottom") +
  ylab("2001-2019年のGDP平均成長率") +
  xlab("民主主義指数") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, 
              color = 'black')+
  coord_cartesian(ylim = c(0, 10)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Russia"|
                        total$countries=="France"|
                        total$countries=="Brazil"|
                        total$countries=="India"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=japanese_name), 
             label.size = NA,  
             # label.padding=.1, 
             # na.rm=TRUE,
             fill = alpha(c("white"),0.5),
             size = 5) 

ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1a2_japanese.png", width=8, height=6)


## (c) Covid-related deaths per million
ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = total_deaths_per_million,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21) +
  scale_size(range = c(.1, 40), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "HiraKakuProN-W3") +
  theme(legend.position="bottom", plot.title =element_text(
    size=20, face="bold.italic")) +
  ylab("100万人あたりのコロナ死者数") +
  xlab("民主主義指数") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, 
              color = 'black')+
  coord_cartesian(ylim = c(0, 1200)) +
  geom_label(data = total %>% 
               filter(countries =="United States"|
                        countries =="Japan"|
                        countries=="China"|
                        countries=="Russia"|
                        countries=="Brazil"|
                        countries=="India"|
                        total$countries=="France"|
                        countries=="Egypt"|
                        countries=="Nigeria"),
             aes(label=japanese_name), 
             fill = "white",
             size = 5)
# color="red", 
ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1c_japanese.png", width=8, height=6)
