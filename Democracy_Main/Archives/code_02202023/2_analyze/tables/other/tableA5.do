
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
use "./output/total.dta", replace

**** conduct analysis 
// gen excess_deaths_per_million = (excess_deaths_count/population)

eststo clear
forv i = 1/5{
		eststo: ivregress 2sls excess_deaths_per_million /// Y: GDP growth rate in 2020
		(democracy_csp2018=${iv`i'}) /// X: Democracy Index in 2018 by CSP, Z: 5 IVs
		[w=total_gdp2019], /// W: Total GDP in 2019
		vce(robust) // robust 2SLS standard errors
		
 		eststo: ivregress 2sls excess_deaths_per_million abs_lat mean_temp_1991_2016 mean_precip_1991_2016 pop_density2020 median_age2020 diabetes_prevalence2019 (democracy_csp2018=${iv`i'}) [w=total_gdp2019], vce(robust)
}

esttab using ./output/tables/other/democracy_effect_excess_mortality.tex, ///
	replace label b(0) se(0) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) keep(democracy_csp2018) ///
	title(`"Democracy's Effect on Excess Deaths in 2020"') ///
	posthead(`"  & \multicolumn{10}{c}{ Dependent Variable is the Excess Deaths Per Million in 2020} \\ \cline{2-11}  \\[-1.8ex]"') ///
	prefoot(`"IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language \& trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops \& minerals} &  \multicolumn{2}{c}{pop. density} \\"' /// 
	`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 
	
