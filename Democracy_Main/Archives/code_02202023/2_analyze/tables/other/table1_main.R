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

total <- read_dta("/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta")
total <- as.data.frame(total)
setwd("/Users/ayumis/Dropbox/アプリ/Overleaf/Curse_of_Democracy/supporting_files/tables")

subset <- total[, c(
                    "mean_growth_rate_2001_2019",
                    "gdp_growth2020", 
                    "total_deaths_per_million", 
                    
                    "democracy_vdem2000",
                    "democracy_vdem2019",
                    
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
                    
                    "diabetes_prevalence2019",
                    
                    "logem4", 
                    
                    "lpd1500s",
                    
                    "legor_uk",
                    
                    "EngFrac",
                    "EurFrac", 
                    "logFrankRom", 
                    
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
              
                    "mean_investment_2001_2019", 
                    "mean_import_value_2001_2019", 
                    "mean_export_value_2001_2019", 
                    "mean_manu_va_growth_2001_2019", 
                    "mean_serv_va_growth_2001_2019")]
# // To make the units correspond to the summary stats table, use the following:
#   // GDP per capita: gdppc[year]
# // Investment share of GDP: investment[year]/100
# // TFP: rtfpna[year]
# // Trade Share of GDP: trade[year]/100
# // Primary Enrollment Rate: primary[year]
# // Secondary Enrollment Rate: secondary[year]
# // Child Mortality Rate Per 1000 Births: mortality[year]

# loginvestment logrtfpna logtrade logtax logprimary logsecondary logmortality
subset$mean_growth_rate_2001_2019 <- as.numeric(unlist(subset$mean_growth_rate_2001_2019))

# subset$mean_investment_2001_2019 <- subset$mean_investment_2001_2019/100
# subset$mean_trade_2001_2019 <- subset$mean_trade_2001_2019/100

output <- stargazer(subset, 
                    title = "Descriptive Statistics",
                    summary.stat = c("n", "mean", "sd", "min", "median","max"),
                    covariate.labels = c(
                      
                      "Mean GDP Growth Rate in 2001-2019",
                      "GDP Growth Rate in 2020",
                      "Covid-19-related Deaths Per Million in 2020", 
                      
                      "Democracy Index (V-Dem, 2000)",
                      "Democracy Index (V-Dem, 2019)",
                      
                      "GDP (Current USD, Billions, 2000)",
                      "GDP (Current USD, Billions, 2019)",
                      
                      "Absolute Latitude", 
                      
                      "Mean Temperature (1991-2000)",
                      "Mean Temperature (1991-2016)", 
                      
                      "Mean Precipitation (1991-2000)",
                      "Mean Precipitation (1991-2016)",
                      
                      "Population Density (2000)", 
                      "Population Density (2019)", 
                      
                      
                      "Median Age (2000)",
                      "Median Age (2019)",
                      
                      "Diabetes Prevalence (2019)",
                      
                      "Log European Settler Mortality", 
                      
                      "Log Population Density in 1500s",
                      
                      "British Legal Origin",
                      
                      "Fraction Speaking English",
                      "Fraction Speaking European", 
                      "Log Frankel-Romer Trade Share", 
                      
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
                      
                      "Mean Investment Share of GDP (%, 2001-2019)", 
                      "Mean Import Value Index (2000=100, 2001-2019)", 
                      "Mean Export Value Index (2000=100, 2001-2019)", 
                      "Mean Manufacturing Value Added (Annual % Growth, 2001-2019)", 
                      "Mean Services Value Added (Annual % Growth, 2001-2019)"
                      
                      ),
                    column.sep.width = "0pt", 
                    font.size= "small", 
                    no.space = TRUE, 
                    header = FALSE,
                    omit.stat = c("rsq","f", "ser" ), 
                    digits = 1)

line = 11
i = 1
while (line < 49){
  print(i)
  line1 <- paste("&", output[line])
  line2 <- printm(unlist(subset[i]))
  print(line1)
  print(line2)
  write(line1, file="table1_main.tex", append = TRUE)
  write(line2, file="table1_main.tex", append = TRUE)
  line = line + 1
  i = i + 1
}