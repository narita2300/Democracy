
********************************************************************************
* Table 2, Panel A: 2SLS Regression Estimates of Democracy's Effects
********************************************************************************
clear 

*** Change to appropriate directory
cd ${path_dropbox}/tables

*** Load data 
use ${path_data}/total.dta, replace

********************************************************************************
* Dependent Variable: Mean GDP Growth Rate in 2001-2019 * 

// column 1
ivreg2 mean_growth_rate_2001_2019 gdppc2000 (democracy_vdem2000=logem4) [w=total_gdp2000], robust first

// column 2
ivreg2 mean_growth_rate_2001_2019 gdppc2000 ${base_covariates2000} (democracy_vdem2000=logem4) [w=total_gdp2000], robust first

// column 3
ivreg2 mean_growth_rate_2001_2019 gdppc2000 (democracy_vdem2000=lpd1500s) [w=total_gdp2000], robust first

// column 4
ivreg2 mean_growth_rate_2001_2019 gdppc2000 ${base_covariates2000} (democracy_vdem2000=lpd1500s) [w=total_gdp2000], robust first

// column 5
ivreg2 mean_growth_rate_2001_2019 gdppc2000 (democracy_vdem2000=legor_uk) [w=total_gdp2000], robust first

// column 6
ivreg2 mean_growth_rate_2001_2019 gdppc2000 ${base_covariates2000} (democracy_vdem2000=legor_uk) [w=total_gdp2000], robust first

// column 7
ivreg2 mean_growth_rate_2001_2019 gdppc2000 (democracy_vdem2000=EngFrac EurFrac) [w=total_gdp2000], robust first

// column 8
ivreg2 mean_growth_rate_2001_2019 gdppc2000 ${base_covariates2000} (democracy_vdem2000=EngFrac EurFrac) [w=total_gdp2000], robust first

// column 9
ivreg2 mean_growth_rate_2001_2019 gdppc2000 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust first

// column 10 
ivreg2 mean_growth_rate_2001_2019 gdppc2000 ${base_covariates2000} (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust first

// column 11
ivreg2 mean_growth_rate_2001_2019 gdppc2000 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust first

// column 12
ivreg2 mean_growth_rate_2001_2019 gdppc2000 ${base_covariates2000} (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust first

********************************************************************************
* Dependent Variable: GDP Growth Rate in 2020
// column 1
ivreg2 gdp_growth2020 (democracy_vdem2019=logem4) [w=total_gdp2019], robust first

// column 2
ivreg2 gdp_growth2020 ${base_covariates2019} (democracy_vdem2019=logem4) [w=total_gdp2019], robust first

// column 3
ivreg2 gdp_growth2020 (democracy_vdem2019=lpd1500s) [w=total_gdp2019], robust first

// column 4
ivreg2 gdp_growth2020 ${base_covariates2019} (democracy_vdem2019=lpd1500s) [w=total_gdp2019], robust first

// column 5
ivreg2 gdp_growth2020 (democracy_vdem2019=legor_uk) [w=total_gdp2019], robust first

// column 6
ivreg2 gdp_growth2020 ${base_covariates2019} (democracy_vdem2019=legor_uk) [w=total_gdp2019], robust first

// column 7
ivreg2 gdp_growth2020 (democracy_vdem2019=EngFrac EurFrac) [w=total_gdp2019], robust first

// column 8
ivreg2 gdp_growth2020 ${base_covariates2019} (democracy_vdem2019=EngFrac EurFrac) [w=total_gdp2019], robust first

// column 9
ivreg2 gdp_growth2020 (democracy_vdem2019=bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2019], robust first

// column 10 
ivreg2 gdp_growth2020 ${base_covariates2019} (democracy_vdem2019=bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2019], robust first

// column 11
ivreg2 gdp_growth2020 (democracy_vdem2019=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2019], robust first

// column 12
ivreg2 gdp_growth2020 ${base_covariates2019} (democracy_vdem2019=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2019], robust first

********************************************************************************
* Dependent Variable: Covid-19 Deaths Per Million in 2020
// column 1
ivreg2 total_deaths_per_million (democracy_vdem2019=logem4) [w=total_gdp2019], robust first

// column 2
ivreg2 total_deaths_per_million ${base_covariates2019} (democracy_vdem2019=logem4) [w=total_gdp2019], robust first

// column 3
ivreg2 total_deaths_per_million (democracy_vdem2019=lpd1500s) [w=total_gdp2019], robust first

// column 4
ivreg2 total_deaths_per_million ${base_covariates2019} (democracy_vdem2019=lpd1500s) [w=total_gdp2019], robust first

// column 5
ivreg2 total_deaths_per_million (democracy_vdem2019=legor_uk) [w=total_gdp2019], robust first

// column 6
ivreg2 total_deaths_per_million ${base_covariates2019} (democracy_vdem2019=legor_uk) [w=total_gdp2019], robust first

// column 7
ivreg2 total_deaths_per_million (democracy_vdem2019=EngFrac EurFrac) [w=total_gdp2019], robust first

// column 8
ivreg2 total_deaths_per_million ${base_covariates2019} (democracy_vdem2019=EngFrac EurFrac) [w=total_gdp2019], robust first

// column 9
ivreg2 total_deaths_per_million (democracy_vdem2019=bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2019], robust first

// column 10 
ivreg2 total_deaths_per_million ${base_covariates2019} (democracy_vdem2019=bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2019], robust first

// column 11
ivreg2 total_deaths_per_million (democracy_vdem2019=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2019], robust first

// column 12
ivreg2 total_deaths_per_million ${base_covariates2019} (democracy_vdem2019=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2019], robust first

