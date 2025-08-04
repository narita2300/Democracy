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

subset <- total[, c("mean_growth_rate_1981_1990",
                    "mean_growth_rate_1991_2000",
                    "mean_growth_rate_2001_2010",
                    "mean_growth_rate_2011_2020",
                    
                    "excess_deaths_per_million",
                    
                    "democracy_csp2018", 
                    "democracy_csp2000",
                    "democracy_fh2020",
                    "democracy_fh2003",
                    "democracy_eiu2020",
                    "democracy_eiu2006",
                    
                    "population2020",
                    "population2000",
                    
                    "total_gdp1980",
                    "total_gdp1990",
                    "total_gdp2000", 
                    "total_gdp2010",
                    
                    "gdppc1980",
                    "gdppc1990",
                    "gdppc2000",
                    "gdppc2010",
                    
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
                    "median_age2010", 
                    
                    "mean_rtfpna_2001_2019",
                    "mean_trade_2001_2019",
                    "mean_tax_2001_2019",
                    "mean_primary_2001_2019",
                    "mean_secondary_2001_2019",
                    "mean_mortality_2001_2019")]

subset$mean_growth_rate_2001_2019 <- as.numeric(unlist(subset$mean_growth_rate_2001_2019))

output <- stargazer(subset, 
                    title = "Descriptive Statistics",
                    summary.stat = c("n", "mean", "sd", "min", "median","max"),
                    covariate.labels = c(
                      "Mean GDP Growth Rate in 1981-1990",
                      "Mean GDP Growth Rate in 1991-2000",
                      "Mean GDP Growth Rate in 2001-2010",
                      "Mean GDP Growth Rate in 2011-2020",
                      
                      "Excess Deaths Per Million in 2020",
                      
                      "Democracy Index (Polity, 2018)",
                      "Democracy Index (Polity, 2000)",
                      "Democracy Index (Freedom House, 2019)", 
                      "Democracy Index (Freedom House, 2003)", 
                      "Democracy Index (Economist Intelligence Unit, 2019)", 
                      "Democracy Index (Economist Intelligence Unit, 2006)", 
                      
                      "Population (Millions, 2019)",
                      "Population (Millions, 2000)",
                      
                      "GDP (Current USD, Billions, 1980)",
                      "GDP (Current USD, Billions, 1990)",
                      "GDP (Current USD, Billions, 2000)",
                      "GDP (Current USD, Billions, 2010)",
                      
                      "GDP Per Capita (Current USD, 1980)",
                      "GDP Per Capita (Current USD, 1990)",
                      "GDP Per Capita (Current USD, 2000)",
                      "GDP Per Capita (Current USD, 2010)",
                      
                      "Mean Temperature (1971-1980)",
                      "Mean Temperature (1981-1990)", 
                      "Mean Temperature (1991-2000)", 
                      "Mean Temperature (2001-2010)", 
                      
                      "Mean Precipitation (1971-1980)",
                      "Mean Precipitation (1981-1990)", 
                      "Mean Precipitation (1991-2000)", 
                      "Mean Precipitation (2001-2010)", 
                      
                      "Population Density (1980)", 
                      "Population Density (1990)", 
                      "Population Density (2000)", 
                      "Population Density (2010)", 
                      
                      "Median Age (1980)",
                      "Median Age (1990)",
                      "Median Age (2000)",
                      "Median Age (2010)", 
                      
                      "Mean TFP (2001-2019)",
                      "Mean Trade Share of GDP (2001-2019)",
                      "Mean Tax Revenue Share of GDP (2001-2019)",
                      "Mean Primary School Enrollment Rate (2001-2019)",
                      "Mean Secondary School Enrollment Rate (2001-2019)",
                      "Mean Child Mortality Rate Per 1000 (2001-2019)"),
                    column.sep.width = "0pt", 
                    font.size= "small", 
                    no.space = TRUE, 
                    header = FALSE,
                    omit.stat = c("rsq","f", "ser" ), 
                    digits = 1)

line = 11
i = 1
while (line < 54){
  print(i)
  line1 <- paste("&", output[line])
  line2 <- printm(unlist(subset[i]))
  print(line1)
  print(line2)
  write(line1, file="table1_appendix.tex", append = TRUE)
  write(line2, file="table1_appendix.tex", append = TRUE)
  line = line + 1
  i = i + 1
}