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

################################################################################
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

Y <- c("ftti",
       "seatw_illib",
       "seatw_popul", 
       "v2smpolhate", 
       "v2smpolsoc")


# convert the wide dataset into long format
for (i in 1:length(Y)) {
    
    print(i)
    start_col <- which(colnames(total)==paste0(Y[i], 2000))
    print(start_col)
    end_col <- which(colnames(total)==paste0(Y[i], 2019))
    print(end_col)
    df <- total[, c(3, start_col:end_col)]
    assign(paste0("d", i), pivot_longer(df, 
                         cols = starts_with(Y[i]),
                         names_to = "year",
                         names_prefix = Y[i]))
    colnames
}
# merge all the year-country observations by year and country 
colnames(d1)[3] <- "ftti"
colnames(d2)[3] <- "seatw_illib"
colnames(d3)[3] <- "seatw_popul"
colnames(d4)[3] <- "v2smpolhate"
colnames(d5)[3] <- "v2smpolsoc"

d <- merge(d1, d2, by = c("NAMES_STD", "year"))
d <- merge(d, d3, by = c("NAMES_STD", "year"))
d <- merge(d, d4, by = c("NAMES_STD", "year"))
d <- merge(d, d5, by = c("NAMES_STD", "year"))

ts <- d %>%
  group_by(year) %>% 
  summarise_at(c(
    "ftti",
    "seatw_illib",
    "seatw_popul", 
    "v2smpolhate", 
    "v2smpolsoc"), 
    mean, 
    na.rm=TRUE)


# Make all variables start at 0
ts$ftti <- ts$ftti + 0.201
ts$v2smpolhate <- ts$v2smpolhate + 0.164
ts$v2smpolsoc <- ts$v2smpolsoc + 0.170
ts$seatw_illib <- ts$seatw_illib + 0.149
ts$seatw_popul <- ts$seatw_popul + 0.08

ts_long <- pivot_longer(ts, 
                       cols = ftti:v2smpolsoc, 
                       names_to = "var",
                       values_to = "value")
ts_long$year <- as.numeric(ts_long$year)

ts_long$var <- ifelse(ts_long$var == "ftti", "Protectionism", ts_long$var)
ts_long$var <- ifelse(ts_long$var == "seatw_illib", "Illiberalism", ts_long$var)
ts_long$var <- ifelse(ts_long$var == "seatw_popul", "Populism", ts_long$var)
ts_long$var <- ifelse(ts_long$var == "v2smpolhate", "Hate speech", ts_long$var)
ts_long$var <- ifelse(ts_long$var == "v2smpolsoc", "Polarization", ts_long$var)

ggplot(ts_long, 
       aes(x = year, 
           y = value, 
           group = var)) + 
  geom_line(aes(linetype=var, color = var)) +
  theme_ipsum(axis_title_size = 20) + 
  theme(legend.title = element_blank()) + 
  labs(y = element_blank(),
       x = element_blank())

ggsave("timeseries_democracy_decline.png", width = 8, height = 6)

