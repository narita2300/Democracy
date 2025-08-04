
********************************************************************************
* Table 2, Panel B: OLS Estimates of Democracy's Effects
********************************************************************************
clear 

*** Change to appropriate directory
cd ${path_dropbox}/tables

*** Load data 
use ${path_data}/total.dta, replace

********************************************************************************
* Dependent Variable: Mean GDP Growth Rate in 2001-2019 * 
// column 1
reg mean_growth_rate_2001_2019 democracy_vdem2000 [w=total_gdp2000] if logem4!=., robust 

// column 2
reg mean_growth_rate_2001_2019 democracy_vdem2000 ${base_covariates2000} [w=total_gdp2000] if logem4!=., robust 

// column 3
reg mean_growth_rate_2001_2019 democracy_vdem2000 [w=total_gdp2000] if lpd1500s !=., robust 

// column 4
reg mean_growth_rate_2001_2019 democracy_vdem2000 ${base_covariates2000} [w=total_gdp2000] if lpd1500s !=., robust 

// column 5
reg mean_growth_rate_2001_2019 democracy_vdem2000 [w=total_gdp2000] if legor_uk!=., robust 

// column 6
reg mean_growth_rate_2001_2019 democracy_vdem2000 ${base_covariates2000} [w=total_gdp2000] if legor_uk!=., robust 

// column 7
reg mean_growth_rate_2001_2019 democracy_vdem2000 [w=total_gdp2000] if EurFrac!=., robust 

// column 8
reg mean_growth_rate_2001_2019 democracy_vdem2000 ${base_covariates2000} [w=total_gdp2000] if EurFrac!=., robust 

// column 9
reg mean_growth_rate_2001_2019 democracy_vdem2000 [w=total_gdp2000] if bananas!=., robust 

// column 10 
reg mean_growth_rate_2001_2019 democracy_vdem2000 ${base_covariates2000} [w=total_gdp2000] if bananas!=., robust 

// column 11
reg mean_growth_rate_2001_2019 democracy_vdem2000 [w=total_gdp2000] if logem4!=. & lpd1500s!=. & legor_uk!=. & EurFrac!=. & bananas!=., robust 

// column 12
reg mean_growth_rate_2001_2019 democracy_vdem2000 ${base_covariates2000} [w=total_gdp2000] if logem4!=. & lpd1500s!=. & legor_uk!=. & EurFrac!=. & bananas!=., robust 


********************************************************************************
* Dependent Variable: GDP Growth Rate in 2020
// column 1
reg gdp_growth2020 democracy_vdem2019 [w=total_gdp2019] if logem4!=., robust 

// column 2
reg gdp_growth2020 democracy_vdem2019 ${base_covariates2019} [w=total_gdp2019] if logem4!=., robust 

// column 3
reg gdp_growth2020 democracy_vdem2019 [w=total_gdp2019] if lpd1500s !=., robust 

// column 4
reg gdp_growth2020 democracy_vdem2019 ${base_covariates2019} [w=total_gdp2019] if lpd1500s !=., robust 

// column 5
reg gdp_growth2020 democracy_vdem2019 [w=total_gdp2019] if legor_uk!=., robust 

// column 6
reg gdp_growth2020 democracy_vdem2019 ${base_covariates2019} [w=total_gdp2019] if legor_uk!=., robust 

// column 7
reg gdp_growth2020 democracy_vdem2019 [w=total_gdp2019] if EurFrac!=., robust 

// column 8
reg gdp_growth2020 democracy_vdem2019 ${base_covariates2019} [w=total_gdp2019] if EurFrac!=., robust 

// column 9
reg gdp_growth2020 democracy_vdem2019 [w=total_gdp2019] if bananas!=., robust 

// column 10 
reg gdp_growth2020 democracy_vdem2019 ${base_covariates2019} [w=total_gdp2019] if bananas!=., robust 

// column 11
reg gdp_growth2020 democracy_vdem2019 [w=total_gdp2019] if logem4!=. & lpd1500s!=. & legor_uk!=. & EurFrac!=. & bananas!=., robust 

// column 12
reg gdp_growth2020 democracy_vdem2019 ${base_covariates2019} [w=total_gdp2019] if logem4!=. & lpd1500s!=. & legor_uk!=. & EurFrac!=. & bananas!=., robust 

********************************************************************************
* Dependent Variable: Covid-19 Deaths Per Million in 2020
// column 1
reg total_deaths_per_million democracy_vdem2019 [w=total_gdp2019] if logem4!=., robust 

// column 2
reg total_deaths_per_million democracy_vdem2019 ${base_covariates2019} [w=total_gdp2019] if logem4!=., robust 

// column 3
reg total_deaths_per_million democracy_vdem2019 [w=total_gdp2019] if lpd1500s !=., robust 

// column 4
reg total_deaths_per_million democracy_vdem2019 ${base_covariates2019} [w=total_gdp2019] if lpd1500s !=., robust 

// column 5
reg total_deaths_per_million democracy_vdem2019 [w=total_gdp2019] if legor_uk!=., robust 

// column 6
reg total_deaths_per_million democracy_vdem2019 ${base_covariates2019} [w=total_gdp2019] if legor_uk!=., robust 

// column 7
reg total_deaths_per_million democracy_vdem2019 [w=total_gdp2019] if EurFrac!=., robust 

// column 8
reg total_deaths_per_million democracy_vdem2019 ${base_covariates2019} [w=total_gdp2019] if EurFrac!=., robust 

// column 9
reg total_deaths_per_million democracy_vdem2019 [w=total_gdp2019] if bananas!=., robust 

// column 10 
reg total_deaths_per_million democracy_vdem2019 ${base_covariates2019} [w=total_gdp2019] if bananas!=., robust 

// column 11
reg total_deaths_per_million democracy_vdem2019 [w=total_gdp2019] if logem4!=. & lpd1500s!=. & legor_uk!=. & EurFrac!=. & bananas!=., robust 

// column 12
reg total_deaths_per_million democracy_vdem2019 ${base_covariates2019} [w=total_gdp2019] if logem4!=. & lpd1500s!=. & legor_uk!=. & EurFrac!=. & bananas!=., robust 
