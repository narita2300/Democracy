################################################################################
# Load paths
source(file.path(dirname(dirname(dirname(dirname(dirname(getwd()))))), "paths.R"))

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
total <- read_dta(file.path(main_path, "Democracy/MainAnalysis/output/data/total.dta"))
total <- as.data.frame(total)
setwd(file.path(main_path, "Democracy/MainAnalysis/output/figures/appendix"))

################################################################################

Ys <- c("mean_growth_rate_2001_2019","mean_g_night_light_2001_2013",
        "mean_growth_rate_2020_2022")
COLS <- 12
# Loop over the number of outcomes to initialize output vectors
for (i in 1:length(Ys)) {
  name <- paste("BETA", i, sep = "")
  assign(name, rep(0, COLS))
  name <- paste("SD", i, sep = "")
  assign(name, rep(0, COLS))
  name <- paste("P", i, sep = "")
  assign(name, rep(0, COLS))
}

# Helper function for TSHT 
tryTSHT <- function(Y,D,Z,X=NULL) {
  result <- tryCatch(
    {
      if (is.null(X)) {
        TSHT.model <- TSHT(Y=Y,D=D,Z=Z,intercept=FALSE,voting="MP",robust=TRUE)
      } else {
        TSHT.model <- TSHT(Y=Y,D=D,Z=Z,X=X,intercept=FALSE,voting="MP",robust=TRUE)
      }
      return(TSHT.model)
    },
    warning = function(w) {
      message("Warning caught: ", conditionMessage(w))
      return(NULL)
    }
  )
  return(result)
}

# Helper function for SearchingSampling 
trySearchingSampling <- function(Y,D,Z,X=NULL) {
  result <- tryCatch(
    {
      if (is.null(X)) {
        Searching.model <- SearchingSampling(Y=Y,D=D,Z=Z,intercept=FALSE,robust=TRUE,M=100)
      } else {
        Searching.model <- SearchingSampling(Y=Y,D=D,Z=Z,X=X,intercept=FALSE,robust=TRUE,M=100)
      }
      return(Searching.model)
    },
    warning = function(w) {
      message("Warning caught: ", conditionMessage(w))
      return(NULL)
    }
  )
  return(result)
}

# Function to compute row of results given outcome, democracy index, and controls
computeRow <- function(y,d,x_a,x_b,df) {
  IVs <- list(c("EngFrac","EurFrac"),
              c("bananas","coffee","copper","maize","millet","rice","rubber","silver","sugarcane","wheat"),
              c("logem","lpd1500s","legor_uk","EngFrac","EurFrac","bananas","coffee","copper","maize","millet","rice","rubber","silver","sugarcane","wheat"))
  
  BETA = rep(0, COLS)
  SD = rep(0, COLS)
  P = rep(0, COLS)
  
  ind <- 0
  for (i in 1:length(IVs)) {
    z = unlist(IVs[i])
    
    df_sub = df[c(y,d,z,x_b)]
    df_sub <- df_sub[complete.cases(df_sub), ]
    
    Y <- as.matrix(df_sub[,y])
    D <- as.matrix(df_sub[,d])
    Z <- as.matrix(df_sub[,z])
    X_a <- as.matrix(df_sub[,x_a])
    X_b <- as.matrix(df_sub[,x_b])
    
    # Two-Stage Hard Thresholding: Guo et al. (J.R.Stat 2018)
    ind <- ind + 1
    TSHT.model <- tryTSHT(Y=Y,D=D,Z=Z,X=X_a)
    if (is.null(TSHT.model)) {
      BETA[ind] <- NA
      SD[ind] <- NA
      P[ind] <- NA
    } else {
      # summary(TSHT.model)
      BETA[ind] <- TSHT.model$betaHat
      SD[ind] <- TSHT.model$beta.sdHat
      P[ind] <- 2*(1 - pt(abs(TSHT.model$betaHat/TSHT.model$beta.sdHat), dim(df_sub)[1]))
    }
    
    ind <- ind + 1
    TSHT.model <- tryTSHT(Y=Y,D=D,Z=Z,X=X_b)
    if (is.null(TSHT.model)) {
      BETA[ind] <- NA
      SD[ind] <- NA
      P[ind] <- NA
    } else {
      # summary(TSHT.model)
      BETA[ind] <- TSHT.model$betaHat
      SD[ind] <- TSHT.model$beta.sdHat
      P[ind] <- 2*(1 - pt(abs(TSHT.model$betaHat/TSHT.model$beta.sdHat), dim(df_sub)[1]))
    }
  }
  
  for (i in 1:length(IVs)) {
    z = unlist(IVs[i])
    
    df_sub = df[c(y,d,z,x_b)]
    df_sub <- df_sub[complete.cases(df_sub), ]
    
    Y <- as.matrix(df_sub[,y])
    D <- as.matrix(df_sub[,d])
    Z <- as.matrix(df_sub[,z])
    X_a <- as.matrix(df_sub[,x_a])
    X_b <- as.matrix(df_sub[,x_b])
    
    # Searching-Sampling: Guo et al. (J.R.Stat 2023)
    ind <- ind + 1
    Searching.model <- trySearchingSampling(Y=Y,D=D,Z=Z,X=X_a)
    if (is.null(Searching.model)) {
      BETA[ind] <- NA
      SD[ind] <- NA
      P[ind] <- NA
    } else {
      # summary(Searching.model)
      BETA[ind] <- mean(Searching.model$ci)
      SD[ind] <- (Searching.model$ci[2] - mean(Searching.model$ci))/qnorm(0.975)
      P[ind] <- 2*(1 - pt(abs(mean(Searching.model$ci)/((Searching.model$ci[2] - mean(Searching.model$ci))/qnorm(0.975))), dim(df_sub)[1]))
    }
    
    ind <- ind + 1
    Searching.model <- trySearchingSampling(Y=Y,D=D,Z=Z,X=X_b)
    if (is.null(Searching.model)) {
      BETA[ind] <- NA
      SD[ind] <- NA
      P[ind] <- NA
    } else {
      # summary(Searching.model)
      BETA[ind] <- mean(Searching.model$ci)
      SD[ind] <- (Searching.model$ci[2] - mean(Searching.model$ci))/qnorm(0.975)
      P[ind] <- 2*(1 - pt(abs(mean(Searching.model$ci)/((Searching.model$ci[2] - mean(Searching.model$ci))/qnorm(0.975))), dim(df_sub)[1]))
    }
  }
  
  out <- list(BETA,SD,P)
  return(out)
}


################################################################################

# Construct gdp weighted dataframes
total2000 <- data.frame(total)
total2000$intercept <- 1
cols <- c("intercept","mean_growth_rate_2001_2019","mean_g_night_light_2001_2013","democracy_vdem2000",
          "abs_lat","mean_temp_1991_2000","mean_precip_1991_2000","pop_density2000","median_age2000",
          "logem","lpd1500s","legor_uk","EngFrac","EurFrac","bananas","coffee","copper","maize","millet","rice","rubber","silver","sugarcane","wheat")
for (c in cols) {
  total2000[c] <- total2000[c] * sqrt(total2000["total_gdp2000"])
}

total2019 <- data.frame(total)
total2019$intercept <- 1
cols <- c("intercept","mean_growth_rate_2020_2022","democracy_vdem2019",
          "abs_lat","mean_temp_1991_2016","mean_precip_1991_2016","pop_density2019","median_age2020","diabetes_prevalence2019",
          "logem","lpd1500s","legor_uk","EngFrac","EurFrac","bananas","coffee","copper","maize","millet","rice","rubber","silver","sugarcane","wheat")
for (c in cols) {
  total2019[c] <- total2019[c] * sqrt(total2019["total_gdp2019"])
}

# Outcome: mean_growth_rate_2001_2019
y = c("mean_growth_rate_2001_2019")
d = c("democracy_vdem2000")
x_a = c("intercept")
x_b = c("intercept","abs_lat","mean_temp_1991_2000","mean_precip_1991_2000","pop_density2000","median_age2000")
out = computeRow(y,d,x_a,x_b,total2000)
BETA1 = unlist(out[1])
SD1 = unlist(out[2])
P1 = unlist(out[3])

# Outcome: mean_g_night_light_2001_2013
y = c("mean_g_night_light_2001_2013")
d = c("democracy_vdem2000")
x_a = c("intercept")
x_b = c("intercept","abs_lat","mean_temp_1991_2000","mean_precip_1991_2000","pop_density2000","median_age2000")
out = computeRow(y,d,x_a,x_b,total2000)
BETA2 = unlist(out[1])
SD2 = unlist(out[2])
P2 = unlist(out[3])

# Outcome: mean_growth_rate_2020_2022
y = c("mean_growth_rate_2020_2022")
d = c("democracy_vdem2019")
x_a = c("intercept")
x_b = c("intercept","abs_lat","mean_temp_1991_2016","mean_precip_1991_2016","pop_density2019","median_age2020","diabetes_prevalence2019")
out = computeRow(y,d,x_a,x_b,total2019)
BETA3 = unlist(out[1])
SD3 = unlist(out[2])
P3 = unlist(out[3])

# Save results
out <- data.frame(BETA1,SD1,P1,BETA2,SD2,P2,BETA3,SD3,P3)

out$BETA1 <- paste0("&",sprintf('%.1f',out$BETA1))
out$SD1 <- paste0("&",paste0("(",sprintf('%.1f',out$SD1),")"))
out$P1 <- paste0("&",sprintf('%.2f',out$P1))
out$BETA2 <- paste0("&",sprintf('%.1f',out$BETA2)) 
out$SD2 <- paste0("&",paste0("(",sprintf('%.1f',out$SD2),")"))
out$P2 <- paste0("&",sprintf('%.2f',out$P2))
out$BETA3 <- paste0("&",sprintf('%.1f',out$BETA3)) 
out$SD3 <- paste0("&",paste0("(",sprintf('%.1f',out$SD3),")"))
out$P3 <- paste0("&",sprintf('%.2f',out$P3))

out$BETA1 <- replace(out$BETA1, out$BETA1=="&NA", "&.")
out$SD1 <- replace(out$SD1, out$SD1=="&(NA)", "&.")
out$P1 <- replace(out$P1, out$P1=="&NA", "&.")
out$BETA2 <- replace(out$BETA2, out$BETA2=="&NA", "&.")
out$SD2 <- replace(out$SD2, out$SD2=="&(NA)", "&.")
out$P2 <- replace(out$P2, out$P2=="&NA", "&.")
out$BETA3 <- replace(out$BETA3, out$BETA3=="&NA", "&.")
out$SD3 <- replace(out$SD3, out$SD3=="&(NA)", "&.")
out$P3 <- replace(out$P3, out$P3=="&NA", "&.")

write_delim(as.data.frame(t(out)), col_names = FALSE, "table2_panelC_invalid_iv.txt")
