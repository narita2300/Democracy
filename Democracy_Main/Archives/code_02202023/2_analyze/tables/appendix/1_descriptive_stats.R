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
total <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta")
total <- as.data.frame(total)
setwd("/Users/ayumis/Dropbox/アプリ/Overleaf/Curse_of_Democracy/supporting_files/tables/appendix")

################################################################################

outcomes <- total[, c(
  "mean_growth_rate_1981_1990",
  "mean_growth_rate_1991_2000",
  "mean_growth_rate_2001_2010",
  "mean_growth_rate_2011_2020",
  
  "excess_deaths_per_million")]

output <- stargazer(outcomes, 
                    title = "Descriptive Statistics",
                    summary.stat = c("n", "mean", "sd", "min", "median","max"),
                    covariate.labels = c(
                      "Mean GDP Growth Rate in 1981-1990",
                      "Mean GDP Growth Rate in 1991-2000",
                      "Mean GDP Growth Rate in 2001-2010",
                      "Mean GDP Growth Rate in 2011-2020",
                      "Excess Deaths Per Million in 2020"),
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
  # "mean_rtfpna_2001_2019",
  # "mean_trade_2001_2019",
  "mean_tax_2001_2019",
  "mean_primary_2001_2019",
  "mean_secondary_2001_2019",
  "mean_mortality_2001_2019")]

output <- stargazer(mechanisms, 
                    title = "Descriptive Statistics",
                    summary.stat = c("n", "mean", "sd", "min", "median","max"),
                    covariate.labels = c(
                      # "Mean TFP (2001-2019)",
                      # "Mean Trade Share of GDP (2001-2019)",
                      "Mean Tax Revenue Share of GDP (2001-2019)",
                      "Mean Primary School Enrollment Rate (net \\%, 2001-2019)",
                      "Mean Secondary School Enrollment Rate (net \\%, 2001-2019)",
                      "Mean Child Mortality Rate Per 1000 (2001-2019)"),
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
