
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(haven)
library(ggrepel)

total <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta")
total <- as.data.frame(total)
setwd("/Users/ayumis/Dropbox/アプリ/Overleaf/Curse_of_Democracy/supporting_files/figures")

total <- total %>% 
  mutate(halves = ntile(democracy_vdem2000, 2))

total$change_ftti_2001_2019 <- total$change_ftti_2001_2019*(-1)
total$change_v2smpolhate_2001_2019 <- total$change_v2smpolhate_2001_2019*(-1)
total$change_v2smpolsoc_2001_2019 <- total$change_v2smpolsoc_2001_2019*(-1)

################################################################################
Y <- c("change_ftti_2001_2019",
       "change_seatw_illib_2001_2019",
       "change_seatw_popul_2001_2019", 
       "change_v2smpolhate_2001_2019",
       "change_v2smpolsoc_2001_2019")

Y_titles <- c("\u0394 Protectionist Trade Policies", 
              "\u0394 Illiberal Rhetoric by Political Parties",
              "\u0394 Populist Rhetoric by Political Parties",
              "\u0394 Hate Speech by Political Parties", 
              "\u0394 Political Polarization of Society")

################################################################################
# make a bar chart comparing the two groups: 
# generate variable with the change in exports over 2001-19
# total$change_ftti_2001_2019 <- total$ftti2019 - total$ftti2001

# df <- subset(total, select = c("change_ftti_2001_2019",
#                                "halves"))
# df1 <- aggregate(df, 
#                  list(df$halves), 
#                  FUN = mean, 
#                  na.action = NULL, na.rm = TRUE)
# df2 <- pivot_wider(df1[,c("halves", 
#                           "change_ftti_2001_2019")], 
#                    names_from=halves, 
#                    names_prefix="change_ftti_2001_2019_group",
#                    values_from=change_ftti_2001_2019)
# df2$diff <- df2$change_ftti_2001_2019_group2 - df2$change_ftti_2001_2019_group1
# df2$var <- "\u0394 Protectionist Trade Policies (2001-19)"

for (i in 1:length(Y)) {
  df <- subset(total, select = c(Y[i],
                                 "halves"))
  df1 <- aggregate(df, 
                   list(df$halves), 
                   FUN = mean, 
                   na.action = NULL, na.rm = TRUE)
  df2 <- pivot_wider(df1[,c("halves", 
                            Y[i])], 
                     names_from=halves, 
                     names_prefix=paste0(Y[i], "_group"),
                     values_from=Y[i])
  diff <- (df2[,c(paste0(Y[i], "_group2"))] - df2[,c(paste0(Y[i], "_group1"))])[1,1]
  var <- Y_titles[i]
  assign(paste0("row", i), c(diff, var))
}

listHolder = list(row1, row2, row3, row4, row5)
m <- do.call(rbind, listHolder)
d <- as.data.frame(m)
colnames(d)[1] <- "diff"
colnames(d)[2] <- "var"
d$diff <- as.numeric(d$diff)

d$var<- factor(d$var, levels = c("\u0394 Political Polarization of Society",
                                 "\u0394 Hate Speech by Political Parties",
                                 "\u0394 Populist Rhetoric by Political Parties",
                                 "\u0394 Illiberal Rhetoric by Political Parties",
                                 "\u0394 Protectionist Trade Policies"))

ggplot(d, aes(x=diff, y=var, label=var)) + 
  geom_point(stat='identity', size=20, color="red") +
  xlim(-0.25, 0.5) +
  labs(x = "Difference in Means (Above - Below)") + 
  theme_ipsum(axis_title_size = 20,
              axis_text_size = 20) +
  theme(text=element_text(size=20),
        legend.title = element_blank(), 
        legend.text = element_text(size = 20),
        legend.position = "none", 
        axis.title.y = element_blank(), 
        axis.title.x = element_text(hjust = 0.5, vjust = 0)) +
  geom_vline(xintercept = 0) +
  geom_text(aes(label=sprintf("%0.2f", diff)),
            position=position_dodge(width=0.9), 
            size = 6, 
            color ="white")

ggsave("change_mechanisms_diffbymedian.png", width=8, height=6)

