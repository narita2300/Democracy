clear 

*** Change to appropriate directory
cd ${path_dropbox}/tables

*** Load data 
use ${path_data}/total.dta, replace

********************************************************************************
* Dependent Variable: GDP Per Capita in 2000 * 

// column 1
ivreg2 gdppc2000 (democracy_vdem2000=logem4), robust first

// column 2
ivreg2 gdppc2000 ${base_covariates2000} (democracy_vdem2000=logem4), robust first

// column 3
ivreg2 gdppc2000 (democracy_vdem2000=lpd1500s), robust first

// column 4
ivreg2 gdppc2000 ${base_covariates2000} (democracy_vdem2000=lpd1500s), robust first

// column 5
ivreg2 gdppc2000 (democracy_vdem2000=legor_uk), robust first

// column 6
ivreg2 gdppc2000 ${base_covariates2000} (democracy_vdem2000=legor_uk), robust first

// column 7
ivreg2 gdppc2000 (democracy_vdem2000=EngFrac EurFrac), robust first

// column 8
ivreg2 gdppc2000 ${base_covariates2000} (democracy_vdem2000=EngFrac EurFrac), robust first

// column 9
ivreg2 gdppc2000 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat), robust first

// column 10 
ivreg2 gdppc2000 ${base_covariates2000} (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat), robust first

// column 11
ivreg2 gdppc2000 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat), robust first

// column 12
ivreg2 gdppc2000 ${base_covariates2000} (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat), robust first

********************************************************************************
* Dependent Variable: Total GDP in 2000 * 

// column 1
ivreg2 total_gdp2000 (democracy_vdem2000=logem4), robust first

// column 2
ivreg2 total_gdp2000 ${base_covariates2000} (democracy_vdem2000=logem4), robust first

// column 3
ivreg2 total_gdp2000 (democracy_vdem2000=lpd1500s), robust first

// column 4
ivreg2 total_gdp2000 ${base_covariates2000} (democracy_vdem2000=lpd1500s), robust first

// column 5
ivreg2 total_gdp2000 (democracy_vdem2000=legor_uk), robust first

// column 6
ivreg2 total_gdp2000 ${base_covariates2000} (democracy_vdem2000=legor_uk), robust first

// column 7
ivreg2 total_gdp2000 (democracy_vdem2000=EngFrac EurFrac), robust first

// column 8
ivreg2 total_gdp2000 ${base_covariates2000} (democracy_vdem2000=EngFrac EurFrac), robust first

// column 9
ivreg2 total_gdp2000 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat), robust first

// column 10 
ivreg2 total_gdp2000 ${base_covariates2000} (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat), robust first

// column 11
ivreg2 total_gdp2000 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat), robust first

// column 12
ivreg2 total_gdp2000 ${base_covariates2000} (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat), robust first
