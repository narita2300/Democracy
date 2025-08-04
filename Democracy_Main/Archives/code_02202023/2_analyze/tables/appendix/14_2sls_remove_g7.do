********************************************************************************
* Table 2: 2SLS Regression Estimates of Democracy's Effects
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace

drop if countries == "France" | countries =="United States" | countries == "Germany" | countries == "Japan" | countries == "United Kingdom" | countries == "Canada" | countries == "Italy"

// drop if countries == "Australia" | countries == "Austria" | countries == "Belgium" | countries == "Chile" | countries == "Colombia" | countries == "Czech Republic" | countries == "Denmark" | countries == "Estonia" | countries == "Finland" | countries == "France" | countries == "Germany" |countries == "Greece" | countries == "Hungary" | countries == "Iceland" | countries == "Ireland" | countries == "Italy" | countries == "Japan" | countries == "South Korea" | countries == "Latvia" | countries == "Lithuania" | countries == "Luxembourg" | countries == "Mexico" | countries == "Netherlands" | countries == "New Zealand" | countries == "Norway" | countries == "Poland" | countries == "Portgual" | countries == "Slovakia" | countries == "Slovenia" | countries == "Spain" | countries == "Sweden" | countries == "Switzerland" | countries == "Turkey" | countries == "United Kingdom" | countries == "United States"

******************************************
*** Panel A: 2SLS on Covid-19 Outcomes *** 
******************************************
local outcomes mean_growth_rate_2001_2019 gdp_growth2020 total_deaths_per_million

************************************ First row
************************************ Y: Mean GDP growth rate in 2001-2019
//democracy's effect on mean GDP growth rate in 2001-2019
eststo clear
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_2001_2019 (${dem2000}=${iv`i'})${weight2000}, vce(robust)
		eststo: ivregress 2sls mean_growth_rate_2001_2019 ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000}, vce(robust)
}
esttab using ${path_appendix}/14_2sls_remove_g7_panel1.tex, ///
	append label b(a1) se(a1) noobs nostar ///
	nodepvars nogaps nonotes mlabels(none) keep(${dem2000}) ///

************************************ Second row
************************************ Y: GDP growth rates in 2020
eststo clear
forv i = 1/5{
			eststo: ivregress 2sls gdp_growth2020 (${dem2019}=${iv`i'}) ${weight2019}, vce(robust)
			eststo: ivregress 2sls gdp_growth2020 ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, vce(robust)
}

esttab using ${path_appendix}/14_2sls_remove_g7_panel2.tex, ///
	replace label b(a1) se(a1) noobs nostar ///
	nodepvars nogaps nonotes mlabels(none) keep(${dem2019}) ///


************************************ Third row
************************************ Y: Covid-19 Deaths Per Million in 2020
// Third row: democracy's effect on Total Covid-19 Deaths Per Million in 2020		
eststo clear
forv i = 1/5{
		eststo: ivregress 2sls total_deaths_per_million (${dem2019}=${iv`i'})${weight2019}, vce(robust)
		eststo: ivregress 2sls total_deaths_per_million ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, vce(robust)
}

esttab using ${path_appendix}/14_2sls_remove_g7_panel3.tex, ///
	append label b(a1) se(a1) stats(N, fmt(0) labels("N")) nostar ///
	nodepvars nogaps nonotes mlabels(none) keep(${dem2019}) ///
	prefoot(`" \hline \\[-1.8ex] IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals}  \\ Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 
	
	
include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(${path_appendix}/14_2sls_remove_g7_panel1.tex ${path_appendix}/14_2sls_remove_g7_panel2.tex ${path_appendix}/14_2sls_remove_g7_panel3.tex) paneltitles("`: var label `:word 1 of `outcomes'''" "`: var label `:word 2 of `outcomes'''" "`: var label `:word 3 of `outcomes'''") columncount(11) save(${path_appendix}/14_2sls_remove_g7.tex) cleanup
