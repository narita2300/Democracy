################################################################################
# Load libraries
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)
library(systemfonts)
library(ggthemes)
library(ggrepel)
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
total <- read_dta("/Users/ayumis/Dropbox/democracy/MainAnalysis/output/data/total.dta")
total <- as.data.frame(total)

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

## (a) Mean GDP growth in 2001-2019

theme_set(theme_ipsum(base_family="aoyagireisyo2"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

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
  theme_ipsum(axis_title_size = 20, base_family = "aoyagireisyo2") +
  theme(legend.position = "bottom") +
  ylab("2001-2019年の平均GDP成長率") +
  xlab("民主主義指数") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, 
              color = 'black')+
  coord_cartesian(ylim = c(0, 10), xlim = c(-1.5, 1.75)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Russia"|
                        total$countries=="Brazil"|
                        total$countries=="India"|
                        total$countries=="France"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=japanese_name), 
             label.size = NA,  
             # label.padding=.1, 
             # na.rm=TRUE,
             fill = alpha(c("white"),0.5),
             # fill = "white",
             size = 5) 
ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1a_japanese_aoyagireisyo.png", width=8, height=6)

################################################################################
theme_set(theme_ipsum(base_family="KouzanBrushFontOTF"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

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
  theme_ipsum(axis_title_size = 20, base_family = "KouzanBrushFontOTF") +
  theme(legend.position = "bottom") +
  ylab("2001-2019年の平均GDP成長率") +
  xlab("民主主義指数") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, 
              color = 'black')+
  coord_cartesian(ylim = c(0, 10), xlim = c(-1.5, 1.75)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Russia"|
                        total$countries=="Brazil"|
                        total$countries=="India"|
                        total$countries=="France"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=japanese_name), 
             label.size = NA,  
             # label.padding=.1, 
             # na.rm=TRUE,
             fill = alpha(c("white"),0.5),
             # fill = "white",
             size = 5) 

ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1a_japanese_KouzanBrushFontOTF.png", width=8, height=6)

################################################################################

theme_set(theme_ipsum(base_family="Mukasi Mukasi"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

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
  theme_ipsum(axis_title_size = 20, base_family = "Mukasi Mukasi") +
  theme(legend.position = "bottom") +
  ylab("2001-2019年の平均GDP成長率") +
  xlab("民主主義指数") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, 
              color = 'black')+
  coord_cartesian(ylim = c(0, 10), xlim = c(-1.5, 1.75)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Russia"|
                        total$countries=="Brazil"|
                        total$countries=="India"|
                        total$countries=="France"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=japanese_name), 
             label.size = NA,  
             # label.padding=.1, 
             # na.rm=TRUE,
             fill = alpha(c("white"),0.5),
             # fill = "white",
             size = 5) 

ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1a_japanese_MukasiMukasi.png", width=8, height=6)

################################################################################
theme_set(theme_ipsum(base_family="azuki_font"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

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
  theme_ipsum(axis_title_size = 20, base_family = "azuki_font") +
  theme(legend.position = "bottom") +
  ylab("2001-2019年の平均GDP成長率") +
  xlab("民主主義指数") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, 
              color = 'black')+
  coord_cartesian(ylim = c(0, 10), xlim = c(-1.5, 1.75)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Russia"|
                        total$countries=="Brazil"|
                        total$countries=="India"|
                        total$countries=="France"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=japanese_name), 
             label.size = NA,  
             # label.padding=.1, 
             # na.rm=TRUE,
             fill = alpha(c("white"),0.5),
             # fill = "white",
             size = 5) 

ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1a_japanese_azuki_font.png", width=8, height=6)

################################################################################
theme_set(theme_ipsum(base_family="uzura_font"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

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
  theme_ipsum(axis_title_size = 20, base_family = "uzura_font") +
  theme(legend.position = "bottom") +
  ylab("2001-2019年の平均GDP成長率") +
  xlab("民主主義指数") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, 
              color = 'black')+
  coord_cartesian(ylim = c(0, 10), xlim = c(-1.5, 1.75)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Russia"|
                        total$countries=="Brazil"|
                        total$countries=="India"|
                        total$countries=="France"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=japanese_name), 
             label.size = NA,  
             # label.padding=.1, 
             # na.rm=TRUE,
             fill = alpha(c("white"),0.5),
             # fill = "white",
             size = 5) 
ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1a_japanese_uzura_font.png", width=8, height=6)

################################################################################
theme_set(theme_ipsum(base_family="07YsashisaGothicTegaki"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

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
  theme_ipsum(axis_title_size = 20, base_family = "07YsashisaGothicTegaki") +
  theme(legend.position = "bottom") +
  ylab("2001-2019年の平均GDP成長率") +
  xlab("民主主義指数") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, 
              color = 'black')+
  coord_cartesian(ylim = c(0, 10), xlim = c(-1.5, 1.75)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Russia"|
                        total$countries=="Brazil"|
                        total$countries=="India"|
                        total$countries=="France"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=japanese_name), 
             label.size = NA,  
             # label.padding=.1, 
             # na.rm=TRUE,
             fill = alpha(c("white"),0.5),
             # fill = "white",
             size = 5) 
ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1a_japanese_07YsashisaGothicTegaki.png", width=8, height=6)

################################################################################
theme_set(theme_ipsum(base_family="timemachine-wa"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

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
  theme_ipsum(axis_title_size = 20, base_family = "timemachine-wa") +
  theme(legend.position = "bottom") +
  ylab("2001-2019年の平均GDP成長率") +
  xlab("民主主義指数") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, 
              color = 'black')+
  coord_cartesian(ylim = c(0, 10), xlim = c(-1.5, 1.75)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Russia"|
                        total$countries=="Brazil"|
                        total$countries=="India"|
                        total$countries=="France"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=japanese_name), 
             label.size = NA,
             fill = alpha(c("white"),0.5),
             # fill = "white",
             size = 5) 
ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1a_japanese_timemachine_wa.png", width=8, height=6)

###############################################################################
###############################################################################

## (b) GDP growth in 2020

theme_set(theme_ipsum(base_family="aoyagireisyo2"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = gdp_growth2020,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "aoyagireisyo2") +
  theme(legend.position = "bottom") +
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
                        total$countries=="France"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=japanese_name), 
             label.size = NA,  
             # label.padding=.1, 
             # na.rm=TRUE,
             fill = alpha(c("white"),0.5),
             # fill = "white",
             size = 5) 
ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1b_japanese_aoyagireisyo.png", width=8, height=6)

################################################################################
theme_set(theme_ipsum(base_family="KouzanBrushFontOTF"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = gdp_growth2020,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "KouzanBrushFontOTF") +
  theme(legend.position = "bottom") +
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
                        total$countries=="France"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=japanese_name), 
             label.size = NA,  
             # label.padding=.1, 
             # na.rm=TRUE,
             fill = alpha(c("white"),0.5),
             # fill = "white",
             size = 5) 

ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1b_japanese_KouzanBrushFontOTF.png", width=8, height=6)

################################################################################

theme_set(theme_ipsum(base_family="Mukasi Mukasi"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = gdp_growth2020,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "Mukasi Mukasi") +
  theme(legend.position = "bottom") +
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
                        total$countries=="France"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=japanese_name), 
             label.size = NA,  
             # label.padding=.1, 
             # na.rm=TRUE,
             fill = alpha(c("white"),0.5),
             # fill = "white",
             size = 5) 

ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1b_japanese_MukasiMukasi.png", width=8, height=6)

################################################################################
theme_set(theme_ipsum(base_family="azuki_font"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = gdp_growth2020,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "azuki_font") +
  theme(legend.position = "bottom") +
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
                        total$countries=="France"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=japanese_name), 
             label.size = NA,  
             # label.padding=.1, 
             # na.rm=TRUE,
             fill = alpha(c("white"),0.5),
             # fill = "white",
             size = 5) 

ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1b_japanese_azuki_font.png", width=8, height=6)

################################################################################
theme_set(theme_ipsum(base_family="uzura_font"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = gdp_growth2020,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "uzura_font") +
  theme(legend.position = "bottom") +
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
                        total$countries=="France"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=japanese_name), 
             label.size = NA,  
             # label.padding=.1, 
             # na.rm=TRUE,
             fill = alpha(c("white"),0.5),
             # fill = "white",
             size = 5) 
ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1b_japanese_uzura_font.png", width=8, height=6)

################################################################################
theme_set(theme_ipsum(base_family="07YsashisaGothicTegaki"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = gdp_growth2020,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "07YsashisaGothicTegaki") +
  theme(legend.position = "bottom") +
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
                        total$countries=="France"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=japanese_name), 
             label.size = NA,  
             # label.padding=.1, 
             # na.rm=TRUE,
             fill = alpha(c("white"),0.5),
             # fill = "white",
             size = 5) 
ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1b_japanese_07YsashisaGothicTegaki.png", width=8, height=6)

################################################################################
theme_set(theme_ipsum(base_family="timemachine-wa"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = gdp_growth2020,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "timemachine-wa") +
  theme(legend.position = "bottom") +
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
                        total$countries=="France"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=japanese_name), 
             label.size = NA,
             fill = alpha(c("white"),0.5),
             # fill = "white",
             size = 5) 
ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1b_japanese_timemachine_wa.png", width=8, height=6)
################################################################################
################################################################################

################################################################################
################################################################################
## (c) Covid-related deaths per million
ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = total_deaths_per_million,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21) +
  scale_size(range = c(.1, 60), 
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
             label.size = NA,
             fill = alpha(c("white"),0.5),
             size = 5)
# color="red", 
ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1c_japanese_HiraKakuProN-W3.png", width=8, height=6)

################################################################################
theme_set(theme_ipsum(base_family="aoyagireisyo2"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = total_deaths_per_million,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "aoyagireisyo2") +
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
             label.size = NA,
             fill = alpha(c("white"),0.5),
             size = 5)
# color="red", 
ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1c_japanese_aoyagireisyo2.png", width=8, height=6)

################################################################################
theme_set(theme_ipsum(base_family="KouzanBrushFontOTF"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = total_deaths_per_million,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "KouzanBrushFontOTF") +
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
             label.size = NA,
             fill = alpha(c("white"),0.5),
             size = 5)
# color="red", 
ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1c_japanese_KouzanBrushFontOTF.png", width=8, height=6)

################################################################################
theme_set(theme_ipsum(base_family="Mukasi Mukasi"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = total_deaths_per_million,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "Mukasi Mukasi") +
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
             label.size = NA,
             fill = alpha(c("white"),0.5),
             size = 5)
# color="red", 
ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1c_japanese_mukasimukasi.png", width=8, height=6)

################################################################################
theme_set(theme_ipsum(base_family="azuki_font"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = total_deaths_per_million,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "azuki_font") +
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
             label.size = NA,
             fill = alpha(c("white"),0.5),
             size = 5)
# color="red", 
ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1c_japanese_azuki_font.png", width=8, height=6)

################################################################################
theme_set(theme_ipsum(base_family="uzura_font"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = total_deaths_per_million,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "uzura_font") +
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
             label.size = NA,
             fill = alpha(c("white"),0.5),
             size = 5)
# color="red", 
ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1c_japanese_uzura_font.png", width=8, height=6)

################################################################################
theme_set(theme_ipsum(base_family="07YsashisaGothicTegaki"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = total_deaths_per_million,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "07YsashisaGothicTegaki") +
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
             label.size = NA,
             fill = alpha(c("white"),0.5),
             size = 5)
# color="red", 
ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1c_japanese_07YsashisaGothicTegaki.png", width=8, height=6)

################################################################################
theme_set(theme_ipsum(base_family="timemachine-wa"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

ggplot(total, 
       aes(x = democracy_vdem2019, 
           y = total_deaths_per_million,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21) +
  scale_size(range = c(.1, 60), 
             name = "total_gdp2019") +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "timemachine-wa") +
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
             label.size = NA,
             fill = alpha(c("white"),0.5),
             size = 5)
# color="red", 
ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/figure1c_japanese_timemachine_wa.png", width=8, height=6)

################################################################################
theme_set(theme_ipsum(base_family="timemachine-wa"))
update_geom_defaults("text", list(family = theme_get()$text$family))
update_geom_defaults("label", list(family = theme_get()$text$family))

ggplot(total, 
       aes(x = total_deaths_per_million, 
           y = gdp_growth2020,
           weight = total_gdp2019,
           size = total_gdp2019,
           fill = democracy_vdem2019)) + 
  geom_point(alpha = 0.5, shape=21, color="black") +
  scale_size(range = c(.1, 60)) +
  scale_fill_viridis(discrete=FALSE, guide=FALSE, option="A") +
  theme_ipsum(axis_title_size = 20, base_family = "timemachine-wa") +
  theme(legend.position = "bottom") +
  ylab("2020年のGDP成長率") +
  xlab("100万人あたりのコロナ死者数") +
  theme(legend.position = "none") + 
  geom_smooth(method = lm, 
              color = 'black')+
  coord_cartesian(ylim = c(-5, 5), xlim = c(-50, 1250)) +
  geom_label(data = total %>% 
               filter(total$countries =="United States"|
                        total$countries =="Japan"|
                        total$countries=="China"|
                        total$countries=="Russia"|
                        total$countries=="Brazil"|
                        total$countries=="India"|
                        total$countries=="France"|
                        total$countries=="Egypt"|
                        total$countries=="Nigeria"),
             aes(label=japanese_name), 
             label.size = NA,
             fill = alpha(c("white"),0.5),
             # fill = "white",
             size = 5) 
ggsave("/Users/ayumis/Dropbox/Democracy/Miscellaneous/deaths_growth2020_japanese_timemachine_wa.png", width=8, height=6)

######################################
