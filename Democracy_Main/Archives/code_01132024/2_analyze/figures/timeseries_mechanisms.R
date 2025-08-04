
# x: the year
# y: the GDP growth rate averaged across the group
# split by levels of the democracy index in 2000. 

################################################################################
# Load libraries
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)

################################################################################
# Load dataset
# total <- read_dta("YOUR-DIRECTORY/replication_data/total.dta")
# ex) total <- read_dta("/Users/ayumis/Desktop/replication_data/output/total.dta")
total <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta")
total <- as.data.frame(total)
setwd("/Users/ayumis/Dropbox/アプリ/Overleaf/Curse_of_Democracy/supporting_files/figures")

total <- total %>% 
  mutate(halves = ntile(democracy_vdem2000, 2))
# total$change_ftti_2001_2019 <- total$change_ftti_2001_2019*(-1)
# total$change_v2smpolhate_2001_2019 <- total$change_v2smpolhate_2001_2019*(-1)
# total$change_v2smpolsoc_2001_2019 <- total$change_v2smpolsoc_2001_2019*(-1)
list <- c("ftti")
years <- c(1975, 1980, 1985, 1990, 1995)
for(j in 1:length(list)){
  for (i in 1:length(years)) {
    total[, c(paste0(list[j], years[i]))]  <- total[, c(paste0(list[j], years[i]))]*(-1)
  }
}

list <- c("ftti", 
          "v2smpolhate",
          "v2smpolsoc")
for(j in 1:length(list)){
  for (i in 2000:2019) {
    total[, c(paste0(list[j], i))]  <- total[, c(paste0(list[j], i))]*(-1)
  }
}

for(i in 1980:2019) {
  total[, c(paste0("trade_value", i))] <- (total[,c(paste0("import_value", i))] + total[,c(paste0("export_value", i))])*(0.5)
}

################################################################################
# x: the year
# y: the potential mechanism
# split by levels of the democracy index in 2000. 

Y <- c("investment", 
       "export_value", 
       "import_value", 
       "trade_value",
       "ftti", 
       "seatw_illib",
       "seatw_popul")

Y_titles <- c("Investment (% of GDP)",
              "Export Value Index (2000=100)", 
              "Import Value Index (2000=100)", 
              "Trade Value Index (2000=100)", 
              "Protectionist Trade Policies", 
              "Illiberal Rhetoric by Political Parties",
              "Populist Rhetoric by Political Parties")

for (i in 1:length(Y)) {
  start_col <- which(colnames(total)==paste0(Y[i], 1980))
  end_col <- which(colnames(total)==paste0(Y[i], 2019))
  df <- aggregate(total[, start_col:end_col], 
                  list(total$halves), 
                  FUN = mean, 
                  na.action = NULL, na.rm = TRUE)
  df_long <- pivot_longer(df, 
                          cols = starts_with(Y[i]),
                          names_to = "year",
                          names_prefix = Y[i])
  df_long$year <- as.numeric(df_long$year)
  df_long$dem <- ifelse(df_long$Group.1 == 1, 
                        "Below Median", 
                        "Countries with Democracy Index Above Median")
  
  ggplot(df_long, 
         aes(x = year, 
             y = value, 
             group = dem)) + 
    geom_line(aes(linetype=dem, color = dem)) +
    theme_ipsum(axis_title_size = 20) +
    scale_linetype_discrete(limits = c("Countries with Democracy Index Above Median",
                                       "Below Median")) +
    scale_color_hue(limits = c("Countries with Democracy Index Above Median",
                               "Below Median")) +
    labs(x = "Year",
         y = Y_titles[i]) +
    geom_vline(xintercept = 2000) +
    theme(legend.title = element_blank(), 
          legend.text = element_text(size = 15),
          legend.position = "bottom")
  
  ggsave(paste0(Y[i], "_by_dem_median.png"), width=8, height=6)
}

Y <- c(
       "v2smpolhate",
       "v2smpolsoc")

Y_titles <- c(
              "Hate Speech by Political Parties",
              "Political Polarization of Society")

for (i in 1:length(Y)) {
  start_col <- which(colnames(total)==paste0(Y[i], 2000))
  end_col <- which(colnames(total)==paste0(Y[i], 2019))
  df <- aggregate(total[, start_col:end_col], 
                  list(total$halves), 
                  FUN = mean, 
                  na.action = NULL, na.rm = TRUE)
  df_long <- pivot_longer(df, 
                          cols = starts_with(Y[i]),
                          names_to = "year",
                          names_prefix = Y[i])
  df_long$year <- as.numeric(df_long$year)
  df_long$dem <- ifelse(df_long$Group.1 == 1, 
                        "Below Median", 
                        "Countries with Democracy Index Above Median")
  
  ggplot(df_long, 
         aes(x = year, 
             y = value, 
             group = dem)) + 
    geom_line(aes(linetype=dem, color = dem)) +
    theme_ipsum(axis_title_size = 20) +
    scale_linetype_discrete(limits = c("Countries with Democracy Index Above Median",
                                       "Below Median")) +
    scale_color_hue(limits = c("Countries with Democracy Index Above Median",
                               "Below Median")) +
    labs(x = "Year",
         y = Y_titles[i]) +
    geom_vline(xintercept = 2000) +
    theme(legend.title = element_blank(), 
          legend.text = element_text(size = 15),
          legend.position = "bottom")
  
  ggsave(paste0(Y[i], "_by_dem_median.png"), width=8, height=6)
}

