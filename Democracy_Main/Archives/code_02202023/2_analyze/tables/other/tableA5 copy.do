
********************************************************************************
* Table : 2SLS Regression Estimates of Democracy's Effects on Excess Mortality
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_output}/total.dta, replace

**** conduct analysis 
// gen excess_deaths_per_million = (excess_deaths_count/population)

eststo clear
forv i = 1/5{
		eststo: ivreg2 excess_deaths_per_million /// Y: GDP growth rate in 2020
		(${dem2019}=${iv`i'}) /// X: Democracy Index in 2018 by CSP, Z: 5 IVs
		${weight2019}, /// W: Total GDP in 2019
		robust // robust 2SLS standard errors
		
 		eststo: ivreg2 excess_deaths_per_million ${base_covariates2019} (${dem2019}=${iv`i'}) ${weight2019}, robust
}

esttab using ${path_output}/tables/tableA5.tex, ///
	replace label b(0) se(0) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) keep(${dem2019}) ///
	title(`"Democracy's Effect on Excess Deaths in 2020"') ///
	posthead(`"  & \multicolumn{10}{c}{ Dependent Variable is the Excess Deaths Per Million in 2020} \\ \cline{2-11}  \\[-1.8ex]"') ///
	prefoot(`"IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language \& trade} & \multicolumn{2}{c}{legal origin} &  \multicolumn{2}{c}{crops \& minerals} &  \multicolumn{2}{c}{pop. density} \\"' /// 
	`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 
	
