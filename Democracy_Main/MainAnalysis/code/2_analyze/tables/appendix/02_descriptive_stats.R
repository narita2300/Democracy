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
library(haven)
library(stargazer)

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
# Load dataset
total <- read_dta(file.path(main_path, "Democracy/MainAnalysis/output/data/total.dta"))
total <- as.data.frame(total)
setwd(file.path(main_path, "Democracy/MainAnalysis/output/figures/appendix"))

################################################################################
outcomes <- total[, c(
  "mean_growth_rate_1981_1990",
  "mean_growth_rate_1991_2000",
  "mean_growth_rate_2001_2010",
  "mean_growth_rate_2011_2019",
  "mean_gdppc_growth_2001_2019",
  "mean_gdppc_growth_2020_2022",
  "excess_mortality_rate_100k",
  "life_ladder_2010_2019",
  "life_ladder_2020_2022",
  "mean_top1_inc_shr_2001_2019",
  "mean_top1_inc_shr_2020_2022",
  "avg_co2_emissions_2001_2019",
  "avg_co2_emissions_2020_2022",
  "avg_energy_2001_2019",
  "avg_energy_2020_2022")]

output <- stargazer(outcomes,
                    title = "Descriptive Statistics",
                    summary.stat = c("n", "mean", "sd", "min", "median","max"),
                    covariate.labels = c(
                      "Mean GDP Growth Rate in 1981-1990",
                      "Mean GDP Growth Rate in 1991-2000",
                      "Mean GDP Growth Rate in 2001-2010",
                      "Mean GDP Growth Rate in 2011-2019",
                      "Mean GDP Per Capita Growth Rate in 2001-2019",
                      "Mean GDP Per Capita Growth Rate in 2020-2022",
                      "Mean Excess Deaths per 100k People 2020-2022",
                      "Life Satisfaction Growth Rate 2010-2019",
                      "Life Satisfaction Growth Rate 2020-2022",
                      "Top 1\\% Income Share Growth Rate in 2001-2019",
                      "Top 1\\% Income Share Growth Rate in 2020-2022",
                      "CO2 Emissions Growth Rate in 2001-2019",
                      "CO2 Emissions Growth Rate in 2020-2022",
                      "Energy Consumption Growth Rate in 2001-2019",
                      "Energy Consumption Growth Rate in 2020-2022"),
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
    write(line1, file="1_descriptive_appendix_outcomes.tex", append = FALSE)
  } else {
    write(line1, file="1_descriptive_appendix_outcomes.tex", append = TRUE)
  }
  write(line2, file="1_descriptive_appendix_outcomes.tex", append = TRUE)
  line = line + 1
  i = i + 1
}

################################################################################
treatments <- total[, c(
  "democracy_vdem1980",
  "democracy_vdem1990",
  "democracy_vdem2000",
  "democracy_vdem2010",
  "democracy_csp2000",
  "democracy_csp2018",
  "democracy_fh2003",
  "democracy_fh2020",
  "democracy_eiu2006",
  "democracy_eiu2020")]

output <- stargazer(treatments,
                    title = "Descriptive Statistics",
                    summary.stat = c("n", "mean", "sd", "min", "median","max"),
                    covariate.labels = c(
                      
                      "Democracy Index (V-Dem, 1980)",
                      "Democracy Index (V-Dem, 1990)",
                      "Democracy Index (V-Dem, 2000)",
                      "Democracy Index (V-Dem, 2010)",

                      "Democracy Index (Polity, 2000)",
                      "Democracy Index (Polity, 2018)",
                      
                      "Democracy Index (Freedom House, 2003)",
                      "Democracy Index (Freedom House, 2019)",
                      
                      "Democracy Index (Economist Intelligence Unit, 2006)",
                      "Democracy Index (Economist Intelligence Unit, 2019)"),
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
    write(line1, file="1_descriptive_appendix_treatments.tex", append = FALSE)
  } else {
    write(line1, file="1_descriptive_appendix_treatments.tex", append = TRUE)
  }
  write(line2, file="1_descriptive_appendix_treatments.tex", append = TRUE)
  line = line + 1
  i = i + 1
}

################################################################################
controls <- total[, c(
  
  "total_gdp1980",
  "total_gdp1990",
  "total_gdp2000",
  "total_gdp2010",

  "gdppc1980",
  "gdppc1990",
  "gdppc2000",
  "gdppc2010",
  "gdppc2019",
  
  "population2000",
  "population2020",
  
  "mean_temp_1971_1980",
  "mean_temp_1981_1990",
  "mean_temp_1991_2000",
  "mean_temp_2001_2010",
  
  "mean_precip_1971_1980",
  "mean_precip_1981_1990",
  "mean_precip_1991_2000",
  "mean_precip_2001_2010",
  
  "pop_density1980",
  "pop_density1990",
  "pop_density2000",
  "pop_density2010",
  
  "median_age1980",
  "median_age1990",
  "median_age2000",
  "median_age2010")]

output <- stargazer(controls,
                    title = "Descriptive Statistics",
                    summary.stat = c("n", "mean", "sd", "min", "median","max"),
                    covariate.labels = c(
                      
                      "GDP (Current USD, Billions, 1980)",
                      "GDP (Current USD, Billions, 1990)",
                      "GDP (Current USD, Billions, 2000)",
                      "GDP (Current USD, Billions, 2010)",
                      
                      "GDP Per Capita (Current USD, 1980)",
                      "GDP Per Capita (Current USD, 1990)",
                      "GDP Per Capita (Current USD, 2000)",
                      "GDP Per Capita (Current USD, 2010)",
                      "GDP Per Capita (Current USD, 2019)",
                      
                      
                      "Population (Millions, 2000)",
                      "Population (Millions, 2019)",
                      
                      "Mean Temperature (\\degree c, 1971-1980)",
                      "Mean Temperature (\\degree c, 1981-1990)",
                      "Mean Temperature (\\degree c, 1991-2000)",
                      "Mean Temperature (\\degree c, 2001-2010)",
                      
                      "Mean Precipitation (mm per Month, 1971-1980)",
                      "Mean Precipitation (mm per Month, 1981-1990)",
                      "Mean Precipitation (mm per Month, 1991-2000)",
                      "Mean Precipitation (mm per Month, 2001-2010)",
                      
                      "Population Density (No. of People per km$^2$, 1980)",
                      "Population Density (No. of People per km$^2$, 1990)",
                      "Population Density (No. of People Per km$^2$, 2000)",
                      "Population Density (No. of People Per km$^2$, 2010)",
                      
                      "Median Age (1980)",
                      "Median Age (1990)",
                      "Median Age (2000)",
                      "Median Age (2010)"),
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
    write(line1, file="1_descriptive_appendix_controls.tex", append = FALSE)
  } else {
    write(line1, file="1_descriptive_appendix_controls.tex", append = TRUE)
  }
  write(line2, file="1_descriptive_appendix_controls.tex", append = TRUE)
  line = line + 1
  i = i + 1
}

################################################################################

mechanisms <- total[, c(
   "mean_va_agr_2001_2019",
   "mean_va_man_2001_2019",
   "mean_va_ser_2001_2019",
   "avg_taxshare_2001_2019",
   "rd_research1",
   "new_business1",
   "mean_fdi_2001_2019",
   "china_import1",
   "china_export1",
   "mean_conflict_2001_2019",
   "mortality_rate1"
)]

output <- stargazer(mechanisms,
                    title = "Descriptive Statistics",
                    summary.stat = c("n", "mean", "sd", "min", "median","max"),
                    covariate.labels = c(
                      "Value Added Agriculture (Mean Annual \\% Growth)",
                      "Value Added Manufacturing (Mean Annual \\% Growth)",
                      "Value Added Services (Mean Annual \\% Growth)",
                      "Tax Revenue Share (Mean Annual \\% Growth)",
                      "R\\&D Researchers (Mean Annual \\% Growth)",
                      "No. of New Business Registrations (Mean Annual \\% Growth)",
                      "Foreign Direct Investments (Mean Annual \\% Growth)",
                      "Value of Imports from China (Mean Annual \\% Growth)",
                      "Value of Exports to China (Mean Annual \\% Growth)",
                      "Conflict Index (Mean Annual \\% Growth)",
                      "Child Mortality Rate (Mean Annual \\% Growth)"
                      ),
                    
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
    write(line1, file="1_descriptive_appendix_mechanisms.tex", append = FALSE)
  } else {
    write(line1, file="1_descriptive_appendix_mechanisms.tex", append = TRUE)
  }
  write(line2, file="1_descriptive_appendix_mechanisms.tex", append = TRUE)
  line = line + 1
  i = i + 1
}

################################################################################

policy <- total[, c(
  "containmenthealth10",
  "coverage10",
  "days_betw_10th_case_and_policy")]

output <- stargazer(policy,
                    title = "Descriptive Statistics",
                    summary.stat = c("n", "mean", "sd", "min", "median","max"),
                    covariate.labels = c(
                      "Containment Health Index at 10th Covid-19 Case",
                      "Coverage of Containment Policy at 10th Covid-19 Case",
                      "Days Between 10th Covid-19 Case Until Any Containment Measure"),
                    column.sep.width = "0pt",
                    font.size= "small",
                    no.space = TRUE,
                    header = FALSE,
                    omit.stat = c("rsq","f", "ser" ),
                    digits = 1)

line = 11
i = 1
while (line < 11 + ncol(policy)){
  print(i)
  print(line)
  print(11+ncol(policy))
  line1 <- paste("&", output[line])
  line2 <- printm(unlist(policy[i]))
  print(line1)
  print(line2)
  
  if (i == 1){
    write(line1, file="1_descriptive_appendix_policy.tex", append = FALSE)
  } else {
    write(line1, file="1_descriptive_appendix_policy.tex", append = TRUE)
  }
  write(line2, file="1_descriptive_appendix_policy.tex", append = TRUE)
  line = line + 1
  i = i + 1
}

