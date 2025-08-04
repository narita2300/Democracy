

********************************************************************************
* Table : 2SLS Regression Estimates of Democracy's Effects on Excess Mortality
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace

**** conduct analysis 
// gen excess_deaths_per_million = (excess_deaths_count/population)

eststo clear
forv i = 1/6{
		eststo: ivregress 2sls excess_deaths_per_million /// Y: GDP growth rate in 2020
		(${dem2019}=${iv`i'}) /// X: Democracy Index in 2018 by CSP, Z: 5 IVs
		[w=total_gdp2019], /// W: Total GDP in 2019
		vce(robust) // robust 2SLS standard errors
		
 		eststo: ivregress 2sls excess_deaths_per_million ${base_covariates2019} (${dem2019}=${iv`i'}) [w=total_gdp2019], vce(robust)
}

esttab using ${path_appendix}/17_2sls_excess_mortality.tex, ///
	replace label b(0) se(0) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) keep(${dem2019}) ///
	posthead(`" \hline & \multicolumn{12}{c}{ Dependent Variable is Excess Deaths Per Million in 2020} \\ \cline{2-11}  \\[-1.8ex]"') ///
	prefoot(`" \hline \\[-1.8ex] IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals}  & \multicolumn{2}{c}{all IVs}   \\ Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 

