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
# total <- read_dta("Desktop/replication_data/total.dta")
# total <- as.data.frame(total)
# total$population <- total$population/1000
# total$total_gdp <- total$total_gdp/1000000000

total <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/total.dta")
total <- as.data.frame(total)
setwd("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/tables")

subset <- total[, c("gdp_growth2020", 
                    "mean_growth_rate_2001_2019",
                    "total_deaths_per_million", 
                    "total_cases_per_million",
                    "excess_deaths_per_million",
                    "democracy_vdem2019",
                    "democracy_vdem2000",
                    "democracy_csp2018", 
                    "democracy_csp2000",
                    "democracy_fh2020",
                    "democracy_fh2003",
                    "democracy_eiu2020",
                    "democracy_eiu2006",
                    "total_gdp2019", 
                    "total_gdp2000",
                    "population2020", 
                    "population2000",
                    "abs_lat", 
                    "mean_temp_1991_2016",
                    "mean_temp_1991_2000",
                    "mean_precip_1991_2016",
                    "mean_precip_1991_2000",
                    "pop_density2000",
                    "pop_density2020",
                    "median_age2000",
                    "median_age2020",
                    "diabetes_prevalence2019",
                    "logem", 
                    "EngFrac",
                    "EurFrac", 
                    "logFrankRom", 
                    "civil_law", 
                    "bananas", 
                    "coffee", 
                    "copper", 
                    "maize",
                    "millet", 
                    "rice", 
                    "rubber", 
                    "silver", 
                    "sugarcane", 
                    "wheat", 
                    "lpd1500s",
                    "containmenthealth10",
                    "coverage10", 
                    "days_betw_10th_case_and_policy")]

subset$mean_growth_rate_2001_2019 <- as.numeric(unlist(subset$mean_growth_rate_2001_2019))

output <- stargazer(subset, 
          title = "Descriptive Statistics",
          summary.stat = c("n", "mean", "sd", "min", "median","max"),
          covariate.labels = c(
            "GDP Growth Rate in 2020",
            "Mean GDP Growth Rate in 2001-2019",
            "Covid-19-related Deaths Per Million in 2020", 
            "Covid-19 Cases Per Million in 2020", 
            "Excess Deaths Per Million in 2020",
            "Democracy Index (V-Dem, 2019)",
            "Democracy Index (V-Dem, 2000)",
            "Democracy Index (Polity, 2018)",
            "Democracy Index (Polity, 2000)",
            "Democracy Index (Freedom House, 2019)", 
            "Democracy Index (Freedom House, 2003)", 
            "Democracy Index (Economist Intelligence Unit, 2019)", 
            "Democracy Index (Economist Intelligence Unit, 2006)", 
            "GDP (Current USD, Billions, 2019)",
            "GDP (Current USD, Billions, 2000)",
            "Population (Millions, 2019)",
            "Population (Millions, 2000)",
            "Absolute Latitude", 
            "Mean Temperature (1991-2016)", 
            "Mean Temperature (1991-2000)",
            "Mean Precipitation (1991-2016)",
            "Mean Precipitation (1991-2000)",
            "Population Density (2000)", 
            "Population Density (2019)", 
            "Median Age (2000)",
            "Median Age (2019)",
            "Diabetes Prevalence (2019)", 
            "Log European Settler Mortality", 
            "Fraction Speaking English",
            "Fraction Speaking European", 
            "Log Frankel-Romer Trade Share", 
            "Civil Law Legal Origin",
            "Bananas",
            "Coffee",
            "Copper",
            "Maize",
            "Millet", 
            "Rice",
            "Silver",
            "Sugarcane", 
            "Rubber", 
            "Wheat", 
            "Log Population Density in 1500s",
            "Containment Health Index at 10th Covid-19 Case",
            "Coverage of Containment Policy at 10th Covid-19 Case", 
            "Days between 10th Covid-19 Case and Any Containment Measure"),
          column.sep.width = "0pt", 
          font.size= "small", 
          no.space = TRUE, 
          header = FALSE,
          omit.stat = c("rsq","f", "ser" ), 
          digits = 1)

line = 11
i = 1
while (line < 55){
  print(i)
  line1 <- paste("&", output[line])
  line2 <- printm(unlist(subset[i]))
  print(line1)
  print(line2)
  write(line1, file="table1.tex", append = TRUE)
  write(line2, file="table1.tex", append = TRUE)
  line = line + 1
  i = i + 1
}