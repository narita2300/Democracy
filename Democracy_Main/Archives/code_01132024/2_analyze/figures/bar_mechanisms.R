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

################################################################################
# Y <- c("investment", 
#        "export_value", 
#        "import_value", 
#        "ftti")
# Y<- lapply(Y,function(x) paste0("change_", x, "_2001_2019"))
# Y_titles <- c("Investment (% of GDP)",
#               "Export Value Index (2000=100)", 
#               "Import Value Index (2000=100)", 
#               "Freedom to Trade Internationally Index")

################################################################################
# make a bar chart comparing the two groups: 
# generate variable with the change in investment over 2001-19
total$change_investment_2001_2019 <- total$investment2019 - total$investment2001
df <- subset(total, select = c("change_investment_2001_2019",
                               "halves"))
df1 <- aggregate(df, 
                 list(df$halves), 
                 FUN = mean, 
                 na.action = NULL, na.rm = TRUE)
df1$dem <- ifelse(df1$Group.1 == 1, 
                  "Below Median", 
                  "Above Median")
df1$dem <- factor(df1$dem, levels = c("Above Median", 
                                      "Below Median"))

ggplot(df1, aes(x=dem, y = change_investment_2001_2019, 
                fill = dem)) + 
  geom_bar(stat="identity") + 
  labs(x = "Democracy Index (V-Dem, 2000)",
       y = "\u0394 Investment (% of GDP)") +
theme_ipsum(axis_title_size = 20,
            axis_text_size = 20) +
  theme(text=element_text(size=20),
        legend.title = element_blank(), 
        legend.text = element_text(size = 20),
        legend.position = "none", 
        axis.title.x = element_text(hjust = 0.5, vjust = 0.6), 
        axis.text.x = element_text(vjust = 5)) + 
  geom_text(aes(label=sprintf("%0.1f", change_investment_2001_2019)),
            position=position_dodge(width=0.9), 
            vjust =-0.25,
            size = 6)

ggsave("change_investment_2001_2019_bar.png", width=8, height=6)

################################################################################
# make a bar chart comparing the two groups: 
# generate variable with the change in exports over 2001-19
total$change_export_value_2001_2019 <- total$export_value2019 - total$export_value2001

df <- subset(total, select = c("change_export_value_2001_2019",
                               "halves"))
df1 <- aggregate(df, 
                 list(df$halves), 
                 FUN = mean, 
                 na.action = NULL, na.rm = TRUE)
df1$dem <- ifelse(df1$Group.1 == 1, 
                  "Below Median", 
                  "Above Median")
df1$dem <- factor(df1$dem, levels = c("Above Median", 
                                      "Below Median"))

ggplot(df1, aes(x=dem, y = change_export_value_2001_2019, 
                fill = dem)) + 
  geom_bar(stat="identity") + 
  labs(x = "Democracy Index (V-Dem, 2000)",
       y = "\u0394 Export Value Index (2000=100)") +
  theme_ipsum(axis_title_size = 20, 
            axis_text_size = 20) +
  theme(text=element_text(size=20),
        legend.title = element_blank(), 
        legend.text = element_text(size = 20),
        legend.position = "none", 
        axis.title.x = element_text(hjust = 0.5, vjust = 0.6), 
        axis.text.x = element_text(vjust = 5)) + 
  geom_text(aes(label=sprintf("%0.0f", change_export_value_2001_2019)),
            position=position_dodge(width=0.9), 
            vjust =-0.25,
            size = 6)

ggsave("change_export_value_2001_2019_bar.png", width=8, height=6)

################################################################################
# make a bar chart comparing the two groups: 
# generate variable with the change in imports over 2001-19
total$change_import_value_2001_2019 <- total$import_value2019 - total$import_value2001
df <- subset(total, select = c("change_import_value_2001_2019",
                               "halves"))
df1 <- aggregate(df, 
                 list(df$halves), 
                 FUN = mean, 
                 na.action = NULL, na.rm = TRUE)
df1$dem <- ifelse(df1$Group.1 == 1, 
                  "Below Median", 
                  "Above Median")
df1$dem <- factor(df1$dem, levels = c("Above Median", 
                                      "Below Median"))

ggplot(df1, aes(x=dem, y = change_import_value_2001_2019, 
                fill = dem)) + 
  geom_bar(stat="identity",
           position="dodge") + 
  labs(x = "Democracy Index (V-Dem, 2000)",
       y = "\u0394 Import Value Index (2000=100)") +
  theme_ipsum(axis_title_size = 20, 
              axis_text_size = 20) +
  theme(text=element_text(size=20),
        legend.title = element_blank(), 
        legend.text = element_text(size = 20),
        legend.position = "none", 
        axis.title.x = element_text(hjust = 0.5, vjust = 0.6), 
        axis.text.x = element_text(vjust = 5)) + 
  geom_text(aes(label=sprintf("%0.0f", change_import_value_2001_2019)),
            position=position_dodge(width=0.9), 
            vjust =-0.25,
            size = 6)

ggsave("change_import_value_2001_2019_bar.png", width=8, height=6)

################################################################################
# make a bar chart comparing the two groups: 
# generate variable with the change in trade (imports+exports) over 2001-19
total$change_trade_value_2001_2019 <- ((total$export_value2019 + total$import_value2019) - (total$export_value2001 + total$import_value2001))/2

df <- subset(total, select = c("change_trade_value_2001_2019",
                               "halves"))
df1 <- aggregate(df, 
                 list(df$halves), 
                 FUN = mean, 
                 na.action = NULL, na.rm = TRUE)
df1$dem <- ifelse(df1$Group.1 == 1, 
                  "Below Median", 
                  "Above Median")
df1$dem <- factor(df1$dem, levels = c("Above Median", 
                                      "Below Median"))

ggplot(df1, aes(x=dem, y = change_trade_value_2001_2019, 
                fill = dem)) + 
  geom_bar(stat="identity",
           position="dodge") + 
  labs(x = "Democracy Index (V-Dem, 2000)",
       y = "\u0394 Trade Value Index (2000=100)") +
  theme_ipsum(axis_title_size = 20, 
              axis_text_size = 20) +
  theme(text=element_text(size=20),
        legend.title = element_blank(), 
        legend.text = element_text(size = 20),
        legend.position = "none", 
        axis.title.x = element_text(hjust = 0.5, vjust = 0.6), 
        axis.text.x = element_text(vjust = 5)) + 
  geom_text(aes(label=sprintf("%0.0f", change_trade_value_2001_2019)),
            position=position_dodge(width=0.9), 
            vjust =-0.25,
            size = 6)

ggsave("change_trade_value_2001_2019_bar.png", width=8, height=6)

