********************************************************************************
* Table 2: 2SLS Regression Estimates of Democracy's Effects
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace

********************************************************
*** 2SLS on Covid-19 Outcomes: Control for Continent *** 
********************************************************

encode continent, generate(cont)

************************************ First row
************************************ Y: Mean GDP growth rate in 2001-2019

eststo clear
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_2001_2019 i.cont (${dem2000}=${iv`i'})${weight2000}, vce(robust)
		eststo: ivregress 2sls mean_growth_rate_2001_2019 i.cont ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000}, vce(robust)
}
esttab using ${path_appendix}/control_continent_panel1.tex, ///
	append label b(a1) se(a1) ///
	nodepvars noobs nogaps nostar nonotes mlabels(none) keep(${dem2000}) ///

************************************ Second row
************************************ Y: GDP growth rates in 2020

eststo clear
forv i = 1/5{
			eststo: ivregress 2sls gdp_growth2020 i.cont (${dem2019}=${iv`i'}) ${weight2019}, vce(robust)
			eststo: ivregress 2sls gdp_growth2020 i.cont ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, vce(robust)
}

esttab using ${path_appendix}/control_continent_panel2.tex, ///
	replace label b(a1) se(a1) ///
	nodepvars noobs nogaps nostar nonotes mlabels(none) keep(${dem2019}) ///

************************************ Third row
************************************ Y: Covid-19 Deaths Per Million in 2020
// Third row: democracy's effect on Total Covid-19 Deaths Per Million in 2020		
eststo clear
forv i = 1/5{
		eststo: ivregress 2sls total_deaths_per_million i.cont (${dem2019}=${iv`i'})${weight2019}, vce(robust)
		eststo: ivregress 2sls total_deaths_per_million i.cont ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, vce(robust)
}

esttab using ${path_appendix}/control_continent_panel3.tex, ///
	append label b(a1) se(a1) stats(N, labels("N")) ///
	nodepvars nogaps nostar nonotes mlabels(none) keep(${dem2019}) obslast ///
	prefoot(`" \hline \\[-1.8ex] IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals}  \\ Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 


include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(${path_appendix}/control_continent_panel1.tex ${path_appendix}/control_continent_panel2.tex ${path_appendix}/control_continent_panel3.tex) paneltitles("Mean GDP Growth Rate in 2001-2019" "GDP Growth Rate in 2020" "Covid-19 Deaths Per Million in 2020") columncount(11) save(${path_appendix}/8_2sls_control_continent.tex) cleanup

