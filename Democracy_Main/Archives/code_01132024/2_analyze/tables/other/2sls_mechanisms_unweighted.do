********************************************************************************
* 2SLS: Mechanisms Behind Democracy's Effect in 21st Century 
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace
drop if gdppc2000==.

// The variables we will be looking at are: 
// 1. Investment as a % of GDP: mean_investment_2001_2019
// 2. Import Value Index (2000=100): mean_import_value_2001_2019
// 3. Export Value Index (2000=100): mean_export_value_2001_2019
// 4. Manufacturing Value Added, Annual % Growth: mean_manu_va_growth_2001_2019
// 5. Services Value Added, Annual % Growth: mean_serv_va_growth_2001_2019

***************************************************
*** Panel A: OLS on Mechanisms against Democracy *** 
***************************************************

eststo clear
foreach var in investment import_value export_value manu_va_growth serv_va_growth{
	eststo: reg mean_`var'_2001_2019 ${dem2000} ${weight2000}, vce(robust)
	eststo: reg mean_`var'_2001_2019 ${base_covariates2000} ${dem2000} ${weight2000}, vce(robust)
	eststo: reg mean_`var'_2001_2019 gdppc2000 total_gdp2000 ${base_covariates2000} ${dem2000} ${weight2000}, vce(robust)
}
esttab using ${path_output}/2sls_mechanisms_21st_main_unweighted.tex, ///
keep(${dem2000}) replace label b(a1) se(a1) stats(N, labels("N")) nogaps nonotes mlabels(none)

// eststo clear
// foreach var in loginvestment logimport_value logexport_value logmanu_va_growth logserv_va_growth{
// 	eststo: reg mean_`var'_2001_2019 ${dem2000} ${weight2000}, vce(robust)
// 	eststo: reg mean_`var'_2001_2019 ${base_covariates2000} ${dem2000} ${weight2000}, vce(robust)
// 	eststo: reg mean_`var'_2001_2019 gdppc2000 total_gdp2000 ${base_covariates2000} ${dem2000} ${weight2000}, vce(robust)
// }
// esttab using ${path_output}/2sls_mechanisms_21st_main_log.tex, ///
// keep(${dem2000}) replace label b(a1) se(a1) stats(N, labels("N")) nogaps nonotes mlabels(none)


***************************************************
*** Panel B-F: 2SLS on Mechanism against Democracy *** 
***************************************************

eststo clear
forvalues i = 1/5{
	eststo clear
	foreach var in investment import_value export_value manu_va_growth serv_va_growth{
		eststo: ivregress 2sls mean_`var'_2001_2019 (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
		eststo: ivregress 2sls mean_`var'_2001_2019 ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
		eststo: ivregress 2sls mean_`var'_2001_2019 gdppc2000 total_gdp2000 ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)	
}
esttab using ${path_output}/2sls_mechanisms_21st_main_unweighted.tex, ///
keep(${dem2000}) append label b(a1) se(a1) stats(N, fmt(0) labels("N")) nogaps nonotes mlabels(none)
}

// eststo clear
// forvalues i = 1/5{
// 	eststo clear
// 	foreach var in loginvestment logimport_value logexport_value logmanu_va_growth logserv_va_growth{
// 		eststo: ivregress 2sls mean_`var'_2001_2019 (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
// 		eststo: ivregress 2sls mean_`var'_2001_2019 ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
// 		eststo: ivregress 2sls mean_`var'_2001_2019 gdppc2000 total_gdp2000 ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)	
// }
// esttab using ${path_output}/2sls_mechanisms_21st_main_log.tex, ///
// keep(${dem2000}) append label b(a1) se(a1) stats(N, fmt(0) labels("N")) nogaps nonotes mlabels(none)
// }

