library(haven)
library(stargazer)
library(sjmisc)
library(stringr)

# Extract the corresponding countries to the max, min and median of each variable
MinMedMax <- function(Var){
  return(total[c(which.min(Var),
                 which.min(abs(Var - median(Var, na.rm = TRUE))),
                 which.max(Var)), ]$countries)
}

printm <- function(Var){
  paste("& & & & & (", MinMedMax(Var)[1], ") & (", MinMedMax(Var)[2], ") & (", MinMedMax(Var)[3], ") \\\\", sep="")
}

################################################################################
total <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta")
total <- as.data.frame(total)
setwd("/Users/ayumis/Dropbox/アプリ/Overleaf/Curse_of_Democracy/supporting_files/tables")

################################################################################

# outcomes <- total[, c(
#   "mean_gdppc_growth_2001_2019",
#   "gdppc_growth2020", 
#   "total_deaths_per_million")]
# 
# # outcomes$mean_growth_rate_2001_2019 <- as.numeric(unlist(outcomes$mean_growth_rate_2001_2019))
# 
# output <- stargazer(outcomes, 
#                     title = "Descriptive Statistics",
#                     summary.stat = c("n", "mean", "sd", "min", "median","max"),
#                     covariate.labels = c(
#                       "Mean GDP Per Capita Growth Rate in 2001-2019",
#                       "GDP Per Capita Growth Rate in 2020",
#                       "Covid-19-related Deaths Per Million in 2020"),
#                     column.sep.width = "0pt", 
#                     font.size= "small", 
#                     no.space = TRUE, 
#                     header = FALSE,
#                     omit.stat = c("rsq","f", "ser" ), 
#                     digits = 1)
outcomes <- total[, c(
  "mean_growth_rate_2001_2019",
  "gdp_growth2020", 
  "total_deaths_per_million")]

# outcomes$mean_growth_rate_2001_2019 <- as.numeric(unlist(outcomes$mean_growth_rate_2001_2019))

output <- stargazer(outcomes, 
                    title = "Descriptive Statistics",
                    summary.stat = c("n", "mean", "sd", "min", "median","max"),
                    covariate.labels = c(
                      "Mean GDP Growth Rate in 2001-2019",
                      "GDP Growth Rate in 2020",
                      "Covid-19-related Deaths Per Million in 2020"),
                    column.sep.width = "0pt", 
                    font.size= "small", 
                    no.space = TRUE, 
                    header = FALSE,
                    omit.stat = c("rsq","f", "ser" ), 
                    digits = 1)
line = 11
i = 1
while (line < 11 + ncol(outcomes)){
  print(i)
  print(line)
  print(line+ncol(outcomes)-1)
  line1 <- paste("&", output[line])
  line2 <- printm(unlist(outcomes[i]))
  print(line1)
  print(line2)
  
  if (i == 1){
    write(line1, file="1_descriptive_main_outcomes.tex", append = FALSE)
  } else {
    write(line1, file="1_descriptive_main_outcomes.tex", append = TRUE)
  }
  write(line2, file="1_descriptive_main_outcomes.tex", append = TRUE)
  line = line + 1
  i = i + 1
}

################################################################################
treatments <- total[, c(
  "democracy_vdem2000",
  "democracy_vdem2019")]

output <- stargazer(treatments, 
                    title = "Descriptive Statistics",
                    summary.stat = c("n", "mean", "sd", "min", "median","max"),
                    covariate.labels = c(
                      "Democracy Index (V-Dem, 2000)",
                      "Democracy Index (V-Dem, 2019)"),
                    column.sep.width = "0pt", 
                    font.size= "small", 
                    no.space = TRUE, 
                    header = FALSE,
                    omit.stat = c("rsq","f", "ser" ), 
                    digits = 1)
line = 11
i = 1
while (line < 11 + ncol(treatments)){
  print(i)
  print(line)
  print(line+ncol(treatments)-1)
  line1 <- paste("&", output[line])
  line2 <- printm(unlist(treatments[i]))
  print(line1)
  print(line2)
  
  if (i == 1){
    write(line1, file="1_descriptive_main_treatments.tex", append = FALSE)
  } else {
    write(line1, file="1_descriptive_main_treatments.tex", append = TRUE)
  }
  write(line2, file="1_descriptive_main_treatments.tex", append = TRUE)
  line = line + 1
  i = i + 1
}

################################################################################
controls <- total[, c(
  "total_gdp2000",
  "total_gdp2019", 
  
  "abs_lat", 
  
  "mean_temp_1991_2000",
  "mean_temp_1991_2016",
  
  "mean_precip_1991_2000",
  "mean_precip_1991_2016",
  
  "pop_density2000",
  "pop_density2019",
  
  "median_age2000",
  "median_age2020",
  
  "diabetes_prevalence2019")]

output <- stargazer(controls, 
                    title = "Descriptive Statistics",
                    summary.stat = c("n", "mean", "sd", "min", "median","max"),
                    covariate.labels = c(
                      
                      "GDP (Current USD, Billions, 2000)",
                      "GDP (Current USD, Billions, 2019)",
                      
                      "Absolute Latitude", 
                      
                      "Mean Temperature (\\degree c, 1991-2000)",
                      "Mean Temperature (\\degree c, 1991-2016)", 
                      
                      "Mean Precipitation (mm per Month, 1991-2000)",
                      "Mean Precipitation (mm per Month, 1991-2016)",
                      
                      "Population Density (No. of People per km$^2$, 2000)", 
                      "Population Density (No. of People per km$^2$, 2019)", 
                      
                      "Median Age (2000)",
                      "Median Age (2019)",
                      
                      "Diabetes Prevalence (\\%, 2019)"),
                    column.sep.width = "0pt", 
                    font.size= "small", 
                    no.space = TRUE, 
                    header = FALSE,
                    omit.stat = c("rsq","f", "ser" ), 
                    digits = 1)
line = 11
i = 1
while (line < 11 + ncol(controls)){
  print(i)
  print(line)
  print(11+ncol(controls))
  line1 <- paste("&", output[line])
  line2 <- printm(unlist(controls[i]))
  print(line1)
  print(line2)
  
  if (i == 1){
    write(line1, file="1_descriptive_main_controls.tex", append = FALSE)
  } else {
    write(line1, file="1_descriptive_main_controls.tex", append = TRUE)
  }
  write(line2, file="1_descriptive_main_controls.tex", append = TRUE)
  line = line + 1
  i = i + 1
}

################################################################################
IVs <- total[, c(
  "logem4", 
  
  "lpd1500s",
  
  "legor_uk",
  
  "EngFrac",
  "EurFrac", 
  # "logFrankRom", 
  
  "bananas", 
  "coffee", 
  "copper", 
  "maize",
  "millet", 
  "rice", 
  "rubber", 
  "silver", 
  "sugarcane", 
  "wheat")]

output <- stargazer(IVs, 
                    title = "Descriptive Statistics",
                    summary.stat = c("n", "mean", "sd", "min", "median","max"),
                    covariate.labels = c(
                      
                      
                      "Log European Settler Mortality (Annual No. of Deaths per Thousand)", 
                      
                      "Log Population Density in 1500s (No. of Inhabitants per km$^2$)",
                      
                      "British Legal Origin",
                      
                      "Fraction Speaking English",
                      "Fraction Speaking European", 
                      # "Log Frankel-Romer Trade Share", 
                      
                      "Bananas",
                      "Coffee",
                      "Copper",
                      "Maize",
                      "Millet", 
                      "Rice",
                      "Rubber", 
                      "Silver",
                      "Sugarcane", 
                      "Wheat"),
                    column.sep.width = "0pt", 
                    font.size= "small", 
                    no.space = TRUE, 
                    header = FALSE,
                    omit.stat = c("rsq","f", "ser" ), 
                    digits = 1)
line = 11
i = 1
while (line < 11 + ncol(IVs)){
  print(i)
  print(line)
  print(11+ncol(IVs))
  line1 <- paste("&", output[line])
  line2 <- printm(unlist(IVs[i]))
  print(line1)
  print(line2)
  
  if (i == 1){
    write(line1, file="1_descriptive_main_IVs.tex", append = FALSE)
  } else {
    write(line1, file="1_descriptive_main_IVs.tex", append = TRUE)
  }
  write(line2, file="1_descriptive_main_IVs.tex", append = TRUE)
  line = line + 1
  i = i + 1
}

################################################################################

mechanisms <- total[, c(
  "mean_agr_va_growth_2001_2019",
  "mean_manu_va_growth_2001_2019", 
  "mean_serv_va_growth_2001_2019", 
  "mean_capital_growth_2001_2019", 
  "mean_labor_growth_2001_2019",
  "mean_tfpgrowth_2001_2019",
  "mean_import_value_2001_2019", 
  "mean_export_value_2001_2019")]

output <- stargazer(mechanisms, 
                    title = "Descriptive Statistics",
                    summary.stat = c("n", "mean", "sd", "min", "median","max"),
                    covariate.labels = c(
                    "Mean Agriculture Value Added in 2001-2019 (Annual \\% Growth)", 
                    "Mean Manufacturing Value Added in 2001-2019 (Annual \\% Growth)", 
                    "Mean Services Value Added in 2001-2019 (Annual \\% Growth)",
                    "Mean Capital Formation in 2001-2019 (Annual \\% Growth)", 
                    "Mean Total Labor Force in 2001-2019 (Annual \\% Growth)", 
                    "Mean TFP in 2001-2019 (Annual \\% Growth)",
                    "Mean Import Value Index in 2001-2019 (2000=100)", 
                    "Mean Export Value Index in 2001-2019 (2000=100)"),
                    column.sep.width = "0pt", 
                    font.size= "small", 
                    no.space = TRUE, 
                    header = FALSE,
                    omit.stat = c("rsq","f", "ser" ), 
                    digits = 1)

line = 11
i = 1
while (line < 11 + ncol(mechanisms)){
  print(i)
  print(line)
  print(11+ncol(mechanisms))
  line1 <- paste("&", output[line])
  line2 <- printm(unlist(mechanisms[i]))
  print(line1)
  print(line2)
  
  if (i == 1){
    write(line1, file="1_descriptive_main_mechanisms.tex", append = FALSE)
  } else {
    write(line1, file="1_descriptive_main_mechanisms.tex", append = TRUE)
  }
  write(line2, file="1_descriptive_main_mechanisms.tex", append = TRUE)
  line = line + 1
  i = i + 1
}

################################################################################
mechanisms2 <- total[, c(
  "change_ftti_2001_2019",
  "change_seatw_illib_2001_2019",
  "change_seatw_popul_2001_2019", 
  "change_v2smpolhate_2001_2019", 
  "change_v2smpolsoc_2001_2019")]

mechanisms2$change_ftti_2001_2019 <- -1*mechanisms2$change_ftti_2001_2019
mechanisms2$change_v2smpolhate_2001_2019 <- -1*mechanisms2$change_v2smpolhate_2001_2019
mechanisms2$change_v2smpolsoc_2001_2019 <- -1*mechanisms2$change_v2smpolsoc_2001_2019

output <- stargazer(mechanisms2, 
                    title = "Descriptive Statistics",
                    summary.stat = c("n", "mean", "sd", "min", "median","max"),
                    covariate.labels = c(
                      "Change in Protectionist Trade Policies in 2001-19", 
                      "Change in Illiberal Rhetoric by Political Parties in 2001-19",
                      "Change in Populist Rhetoric by Political Parties in 2001-19", 
                      "Change in Hate Speech by Political Parties in 2001-19",
                      "Change in Political Polarization of Society in 2001-19"),
                    column.sep.width = "0pt", 
                    font.size= "small", 
                    no.space = TRUE, 
                    header = FALSE,
                    omit.stat = c("rsq","f", "ser" ), 
                    digits = 2)

line = 11
i = 1
while (line < 11 + ncol(mechanisms2)){
  print(i)
  # print(line)
  print(11+ncol(mechanisms2))
  
  line1 <- paste("&", output[line])
  line2 <- printm(unlist(mechanisms2[i]))

  if (str_contains(line1,"$-$0.00")){
      print("YEs")
      line1 <- str_replace(line1, "\\$\\-\\$0\\.00", "0.00")
  }
  
  print(line1)
  print(line2)
  
  if (i == 1){
    write(line1, file="1_descriptive_main_mechanisms2.tex", append = FALSE)
  } else {
    write(line1, file="1_descriptive_main_mechanisms2.tex", append = TRUE)
  }
  write(line2, file="1_descriptive_main_mechanisms2.tex", append = TRUE)
  line = line + 1
  i = i + 1
}
