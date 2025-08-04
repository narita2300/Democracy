********************************************************************************
* Table 3: 2SLS Regression Estimates of Democracy's Effects on Mechanisms
********************************************************************************
clear 

*** Change to appropriate directory
cd ${path_dropbox}/tables

*** Load data 
use ${path_data}/total.dta, replace

********************************************************************************
* Dependent Variable: Value Added, Agriculture (Annual % Growth) * 

// Panel A, column 1
reg mean_agr_va_growth_2001_2019 democracy_vdem2000 [w=total_gdp2000],robust

// Panel A, column 2
reg mean_agr_va_growth_2001_2019 democracy_vdem2000 ${base_covariates2000} [w=total_gdp2000],robust

// Panel B, column 1
ivreg2 mean_agr_va_growth_2001_2019 (democracy_vdem2000=logem4) [w=total_gdp2000], robust

// Panel B, column 2
ivreg2 mean_agr_va_growth_2001_2019 (democracy_vdem2000=logem4) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel C, column 1
ivreg2 mean_agr_va_growth_2001_2019 (democracy_vdem2000=lpd1500s) [w=total_gdp2000], robust

// Panel C, column 2
ivreg2 mean_agr_va_growth_2001_2019 (democracy_vdem2000=lpd1500s) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel D, column 1
ivreg2 mean_agr_va_growth_2001_2019 (democracy_vdem2000=legor_uk) [w=total_gdp2000], robust

// Panel D, column 2
ivreg2 mean_agr_va_growth_2001_2019 (democracy_vdem2000=legor_uk) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel E, column 1
ivreg2 mean_agr_va_growth_2001_2019 (democracy_vdem2000=EngFrac EurFrac) [w=total_gdp2000], robust

// Panel E, column 2
ivreg2 mean_agr_va_growth_2001_2019 (democracy_vdem2000=EngFrac EurFrac) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel F, column 1 
ivreg2 mean_agr_va_growth_2001_2019 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust

// Panel F, column 2
ivreg2 mean_agr_va_growth_2001_2019 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel G, column 1 
ivreg2 mean_agr_va_growth_2001_2019 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust

// Panel G, column 2
ivreg2 mean_agr_va_growth_2001_2019 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

********************************************************************************
* Dependent Variable: Value Added, Manufacturing (Annual % Growth) * 

// Panel A, column 3
reg mean_manu_va_growth_2001_2019 democracy_vdem2000 [w=total_gdp2000],robust

// Panel A, column 4
reg mean_manu_va_growth_2001_2019 democracy_vdem2000 ${base_covariates2000} [w=total_gdp2000],robust

// Panel B, column 3
ivreg2 mean_manu_va_growth_2001_2019 (democracy_vdem2000=logem4) [w=total_gdp2000], robust

// Panel B, column 4
ivreg2 mean_manu_va_growth_2001_2019 (democracy_vdem2000=logem4) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel C, column 3
ivreg2 mean_manu_va_growth_2001_2019 (democracy_vdem2000=lpd1500s) [w=total_gdp2000], robust

// Panel C, column 4
ivreg2 mean_manu_va_growth_2001_2019 (democracy_vdem2000=lpd1500s) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel D, column 3
ivreg2 mean_manu_va_growth_2001_2019 (democracy_vdem2000=legor_uk) [w=total_gdp2000], robust

// Panel D, column 4
ivreg2 mean_manu_va_growth_2001_2019 (democracy_vdem2000=legor_uk) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel E, column 3
ivreg2 mean_manu_va_growth_2001_2019 (democracy_vdem2000=EngFrac EurFrac) [w=total_gdp2000], robust

// Panel E, column 4
ivreg2 mean_manu_va_growth_2001_2019 (democracy_vdem2000=EngFrac EurFrac) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel F, column 3 
ivreg2 mean_manu_va_growth_2001_2019 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust

// Panel F, column 4
ivreg2 mean_manu_va_growth_2001_2019 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel G, column 3 
ivreg2 mean_manu_va_growth_2001_2019 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust

// Panel G, column 4
ivreg2 mean_manu_va_growth_2001_2019 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

********************************************************************************
* Dependent Variable: Value Added, Services (Annual % Growth) * 

// Panel A, column 5
reg mean_serv_va_growth_2001_2019 democracy_vdem2000 [w=total_gdp2000],robust

// Panel A, column 6
reg mean_serv_va_growth_2001_2019 democracy_vdem2000 ${base_covariates2000} [w=total_gdp2000],robust

// Panel B, column 5
ivreg2 mean_serv_va_growth_2001_2019 (democracy_vdem2000=logem4) [w=total_gdp2000], robust

// Panel B, column 6
ivreg2 mean_serv_va_growth_2001_2019 (democracy_vdem2000=logem4) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel C, column 5
ivreg2 mean_serv_va_growth_2001_2019 (democracy_vdem2000=lpd1500s) [w=total_gdp2000], robust

// Panel C, column 6
ivreg2 mean_serv_va_growth_2001_2019 (democracy_vdem2000=lpd1500s) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel D, column 5
ivreg2 mean_serv_va_growth_2001_2019 (democracy_vdem2000=legor_uk) [w=total_gdp2000], robust

// Panel D, column 6
ivreg2 mean_serv_va_growth_2001_2019 (democracy_vdem2000=legor_uk) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel E, column 5
ivreg2 mean_serv_va_growth_2001_2019 (democracy_vdem2000=EngFrac EurFrac) [w=total_gdp2000], robust

// Panel E, column 6
ivreg2 mean_serv_va_growth_2001_2019 (democracy_vdem2000=EngFrac EurFrac) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel F, column 5 
ivreg2 mean_serv_va_growth_2001_2019 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust

// Panel F, column 6
ivreg2 mean_serv_va_growth_2001_2019 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel G, column 5 
ivreg2 mean_serv_va_growth_2001_2019 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust

// Panel G, column 6
ivreg2 mean_serv_va_growth_2001_2019 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

********************************************************************************
* Dependent Variable: Capital Stock Formation (Annual % Growth) * 

// Panel A, column 7
reg mean_capital_growth_2001_2019 democracy_vdem2000 [w=total_gdp2000],robust

// Panel A, column 8
reg mean_capital_growth_2001_2019 democracy_vdem2000 ${base_covariates2000} [w=total_gdp2000],robust

// Panel B, column 7
ivreg2 mean_capital_growth_2001_2019 (democracy_vdem2000=logem4) [w=total_gdp2000], robust

// Panel B, column 8
ivreg2 mean_capital_growth_2001_2019 (democracy_vdem2000=logem4) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel C, column 7
ivreg2 mean_capital_growth_2001_2019 (democracy_vdem2000=lpd1500s) [w=total_gdp2000], robust

// Panel C, column 8
ivreg2 mean_capital_growth_2001_2019 (democracy_vdem2000=lpd1500s) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel D, column 7
ivreg2 mean_capital_growth_2001_2019 (democracy_vdem2000=legor_uk) [w=total_gdp2000], robust

// Panel D, column 8
ivreg2 mean_capital_growth_2001_2019 (democracy_vdem2000=legor_uk) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel E, column 7
ivreg2 mean_capital_growth_2001_2019 (democracy_vdem2000=EngFrac EurFrac) [w=total_gdp2000], robust

// Panel E, column 8
ivreg2 mean_capital_growth_2001_2019 (democracy_vdem2000=EngFrac EurFrac) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel F, column 7 
ivreg2 mean_capital_growth_2001_2019 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust

// Panel F, column 8
ivreg2 mean_capital_growth_2001_2019 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel G, column 7 
ivreg2 mean_capital_growth_2001_2019 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust

// Panel G, column 8
ivreg2 mean_capital_growth_2001_2019 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

********************************************************************************
* Dependent Variable: Labor Force (Annual % Growth) * 

// Panel A, column 9
reg mean_labor_growth_2001_2019 democracy_vdem2000 [w=total_gdp2000],robust

// Panel A, column 10
reg mean_labor_growth_2001_2019 democracy_vdem2000 ${base_covariates2000} [w=total_gdp2000],robust

// Panel B, column 9
ivreg2 mean_labor_growth_2001_2019 (democracy_vdem2000=logem4) [w=total_gdp2000], robust

// Panel B, column 10
ivreg2 mean_labor_growth_2001_2019 (democracy_vdem2000=logem4) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel C, column 9
ivreg2 mean_labor_growth_2001_2019 (democracy_vdem2000=lpd1500s) [w=total_gdp2000], robust

// Panel C, column 10
ivreg2 mean_labor_growth_2001_2019 (democracy_vdem2000=lpd1500s) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel D, column 9
ivreg2 mean_labor_growth_2001_2019 (democracy_vdem2000=legor_uk) [w=total_gdp2000], robust

// Panel D, column 10
ivreg2 mean_labor_growth_2001_2019 (democracy_vdem2000=legor_uk) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel E, column 9
ivreg2 mean_labor_growth_2001_2019 (democracy_vdem2000=EngFrac EurFrac) [w=total_gdp2000], robust

// Panel E, column 10
ivreg2 mean_labor_growth_2001_2019 (democracy_vdem2000=EngFrac EurFrac) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel F, column 9 
ivreg2 mean_labor_growth_2001_2019 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust

// Panel F, column 10
ivreg2 mean_labor_growth_2001_2019 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel G, column 9 
ivreg2 mean_labor_growth_2001_2019 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust

// Panel G, column 10
ivreg2 mean_labor_growth_2001_2019 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

********************************************************************************
* Dependent Variable: TFP (Annual % Growth) * 

// Panel A, column 11
reg mean_tfpgrowth_2001_2019 democracy_vdem2000 [w=total_gdp2000],robust

// Panel A, column 12
reg mean_tfpgrowth_2001_2019 democracy_vdem2000 ${base_covariates2000} [w=total_gdp2000],robust

// Panel B, column 11
ivreg2 mean_tfpgrowth_2001_2019 (democracy_vdem2000=logem4) [w=total_gdp2000], robust

// Panel B, column 12
ivreg2 mean_tfpgrowth_2001_2019 (democracy_vdem2000=logem4) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel C, column 11
ivreg2 mean_tfpgrowth_2001_2019 (democracy_vdem2000=lpd1500s) [w=total_gdp2000], robust

// Panel C, column 12
ivreg2 mean_tfpgrowth_2001_2019 (democracy_vdem2000=lpd1500s) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel D, column 11
ivreg2 mean_tfpgrowth_2001_2019 (democracy_vdem2000=legor_uk) [w=total_gdp2000], robust

// Panel D, column 12
ivreg2 mean_tfpgrowth_2001_2019 (democracy_vdem2000=legor_uk) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel E, column 11
ivreg2 mean_tfpgrowth_2001_2019 (democracy_vdem2000=EngFrac EurFrac) [w=total_gdp2000], robust

// Panel E, column 12
ivreg2 mean_tfpgrowth_2001_2019 (democracy_vdem2000=EngFrac EurFrac) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel F, column 11 
ivreg2 mean_tfpgrowth_2001_2019 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust

// Panel F, column 12
ivreg2 mean_tfpgrowth_2001_2019 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel G, column 11 
ivreg2 mean_tfpgrowth_2001_2019 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust

// Panel G, column 12
ivreg2 mean_tfpgrowth_2001_2019 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

********************************************************************************
* Dependent Variable: Import Value Index (2000=100) * 

// Panel A, column 13
reg mean_import_value_2001_2019 democracy_vdem2000 [w=total_gdp2000],robust

// Panel A, column 14
reg mean_import_value_2001_2019 democracy_vdem2000 ${base_covariates2000} [w=total_gdp2000],robust

// Panel B, column 13
ivreg2 mean_import_value_2001_2019 (democracy_vdem2000=logem4) [w=total_gdp2000], robust

// Panel B, column 14
ivreg2 mean_import_value_2001_2019 (democracy_vdem2000=logem4) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel C, column 13
ivreg2 mean_import_value_2001_2019 (democracy_vdem2000=lpd1500s) [w=total_gdp2000], robust

// Panel C, column 14
ivreg2 mean_import_value_2001_2019 (democracy_vdem2000=lpd1500s) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel D, column 13
ivreg2 mean_import_value_2001_2019 (democracy_vdem2000=legor_uk) [w=total_gdp2000], robust

// Panel D, column 14
ivreg2 mean_import_value_2001_2019 (democracy_vdem2000=legor_uk) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel E, column 13
ivreg2 mean_import_value_2001_2019 (democracy_vdem2000=EngFrac EurFrac) [w=total_gdp2000], robust

// Panel E, column 14
ivreg2 mean_import_value_2001_2019 (democracy_vdem2000=EngFrac EurFrac) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel F, column 13 
ivreg2 mean_import_value_2001_2019 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust

// Panel F, column 14
ivreg2 mean_import_value_2001_2019 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel G, column 13 
ivreg2 mean_import_value_2001_2019 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust

// Panel G, column 14
ivreg2 mean_import_value_2001_2019 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

********************************************************************************
* Dependent Variable: Export Value Index (2000=100) * 

// Panel A, column 15
reg mean_export_value_2001_2019 democracy_vdem2000 [w=total_gdp2000],robust

// Panel A, column 16
reg mean_export_value_2001_2019 democracy_vdem2000 ${base_covariates2000} [w=total_gdp2000],robust

// Panel B, column 15
ivreg2 mean_export_value_2001_2019 (democracy_vdem2000=logem4) [w=total_gdp2000], robust

// Panel B, column 16
ivreg2 mean_export_value_2001_2019 (democracy_vdem2000=logem4) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel C, column 15
ivreg2 mean_export_value_2001_2019 (democracy_vdem2000=lpd1500s) [w=total_gdp2000], robust

// Panel C, column 16
ivreg2 mean_export_value_2001_2019 (democracy_vdem2000=lpd1500s) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel D, column 15
ivreg2 mean_export_value_2001_2019 (democracy_vdem2000=legor_uk) [w=total_gdp2000], robust

// Panel D, column 16
ivreg2 mean_export_value_2001_2019 (democracy_vdem2000=legor_uk) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel E, column 15
ivreg2 mean_export_value_2001_2019 (democracy_vdem2000=EngFrac EurFrac) [w=total_gdp2000], robust

// Panel E, column 16
ivreg2 mean_export_value_2001_2019 (democracy_vdem2000=EngFrac EurFrac) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel F, column 15 
ivreg2 mean_export_value_2001_2019 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust

// Panel F, column 16
ivreg2 mean_export_value_2001_2019 (democracy_vdem2000=bananas coffee copper maize millet rice rubber silver sugarcane wheat) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust

// Panel G, column 15 
ivreg2 mean_export_value_2001_2019 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) [w=total_gdp2000], robust

// Panel G, column 16
ivreg2 mean_export_value_2001_2019 (democracy_vdem2000=logem4 lpd1500s legor_uk EngFrac EurFrac bananas coffee copper maize millet rice rubber silver sugarcane wheat) gdppc2000 ${base_covariates2000} [w=total_gdp2000], robust


