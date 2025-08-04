********************************************************************************
* Table 2: 2SLS Regression Estimates of Democracy's Effects
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace


******************************************
*** Panel A: 2SLS on Covid-19 Outcomes *** 
******************************************

************************************ First row
************************************ Y: GDP growth rates in 2020
eststo clear
forv i = 1/5{
			eststo: ivregress 2sls gdp_growth2020 (${dem2019}=${iv`i'}), vce(robust)
			eststo: ivregress 2sls gdp_growth2020 ${base_covariates2019} (${dem2019}=${iv`i'}), vce(robust)
}

esttab using ./output/tables/table2_unweighted.tex, ///
	replace label b(a1) se(a1) stats(N, labels("N")) ///
	nodepvars nogaps nonotes mlabels(none) keep(${dem2019}) ///
	title(`"Democracy's Effect on Covid-19 Deaths Per Million in 2020"') ///
	posthead(`"&\multicolumn{10}{c}{ Dependent Variable is the GDP Growth Rate in 2020}\\\cline{2-11}\\[-1.8ex]"') ///
	prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' /// 
	`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')

************************************ Second row
************************************ Y: Mean GDP growth rate in 2001-2019
// Second row: democracy's effect on mean GDP growth rate in 2001-2019
eststo clear
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_2001_2019 (${dem2000}=${iv`i'}), vce(robust)
		eststo: ivregress 2sls mean_growth_rate_2001_2019 ${base_covariates2000} (${dem2000}=${iv`i'}), vce(robust)
}
esttab using ./output/tables/table2_unweighted.tex, ///
	append label b(a1) se(a1) stats(N, labels("N")) ///
	nodepvars nogaps nonotes mlabels(none) keep(${dem2000}) ///
	posthead(`"&\multicolumn{10}{c}{ Dependent Variable is the Mean GDP Growth Rate in 2001-2019}\\\cline{2-11}\\[-1.8ex]"')

************************************ Third row
************************************ Y: Covid-19 Deaths Per Million in 2020
// Third row: democracy's effect on Total Covid-19 Deaths Per Million in 2020		
eststo clear
forv i = 1/5{
		eststo: ivregress 2sls total_deaths_per_million (${dem2019}=${iv`i'}), vce(robust)
		eststo: ivregress 2sls total_deaths_per_million ${base_covariates2019} (${dem2019}=${iv`i'}), vce(robust)
}

esttab using ./output/tables/table2_unweighted.tex, ///
	append label b(a1) se(a1) stats(N, labels("N")) ///
	nodepvars nogaps nonotes mlabels(none) keep(${dem2019}) ///
	posthead(`"&\multicolumn{10}{c}{ Dependent Variable is Covid-19 Deaths Per Million in 2020}\\\cline{2-11}\\[-1.8ex]"')
	

******************************************
*** Panel B: OLS on Covid-19 Outcomes *** 
******************************************
* index: Freedom House's democracy index (democracy_fh)
* weight = GDP (total_gdp)

foreach var in gdp_growth2020 {
	eststo clear
	eststo: reg `var'   ${dem2019} if logem !=.   , vce(robust)
	eststo: reg `var'   ${dem2019} ${base_covariates2019} if logem !=.   ,  vce(robust)
	eststo: reg `var'   ${dem2019} if EurFrac !=.   ,  vce(robust)
	eststo: reg `var'   ${dem2019} ${base_covariates2019} if EurFrac !=.   ,  vce(robust)
	eststo: reg `var'   ${dem2019} if civil_law !=.   ,  vce(robust)
	eststo: reg `var'   ${dem2019} ${base_covariates2019} if civil_law !=.   ,  vce(robust)
	eststo: reg `var'   ${dem2019} if bananas !=.   ,  vce(robust)
	eststo: reg `var'   ${dem2019} ${base_covariates2019} if bananas !=.   ,  vce(robust)
	eststo: reg `var'   ${dem2019} if lpd1500s !=.   ,  vce(robust)
	eststo: reg `var'   ${dem2019} ${base_covariates2019} if lpd1500s !=.   ,  vce(robust)
	eststo: esttab using ./output/tables/table2_unweighted.tex, append label b(a1) se(a1) keep(${dem2019}) compress nogaps nolines nonotes nocons nodepvars
}

foreach var in mean_growth_rate_2001_2019{
	eststo clear
	eststo: reg `var' ${dem2000} if logem !=.  , vce(robust)
	eststo: reg `var' ${dem2000} ${base_covariates2000} if logem !=.  ,  vce(robust)
	eststo: reg `var' ${dem2000} if EurFrac !=.  ,  vce(robust)
	eststo: reg `var' ${dem2000} ${base_covariates2000} if EurFrac !=.  ,  vce(robust)
	eststo: reg `var' ${dem2000} if civil_law !=.  ,  vce(robust)
	eststo: reg `var' ${dem2000} ${base_covariates2000} if civil_law !=.  ,  vce(robust)
	eststo: reg `var' ${dem2000} if bananas !=.  ,  vce(robust)
	eststo: reg `var' ${dem2000} ${base_covariates2000} if bananas !=.  ,  vce(robust)
	eststo: reg `var' ${dem2000} if lpd1500s !=.  ,  vce(robust)
	eststo: reg `var' ${dem2000} ${base_covariates2000} if lpd1500s !=.  ,  vce(robust)
	eststo: esttab using ./output/tables/table2_unweighted.tex, append label b(a1) se(a1) keep(${dem2000}) compress nogaps nolines nonotes nocons nodepvars
}

foreach var in total_deaths_per_million {
	eststo clear
	eststo: reg `var'   ${dem2019} if logem !=.   , vce(robust)
	eststo: reg `var'   ${dem2019} ${base_covariates2019} if logem !=.   ,  vce(robust)
	eststo: reg `var'   ${dem2019} if EurFrac !=.   ,  vce(robust)
	eststo: reg `var'   ${dem2019} ${base_covariates2019} if EurFrac !=.   ,  vce(robust)
	eststo: reg `var'   ${dem2019} if civil_law !=.   ,  vce(robust)
	eststo: reg `var'   ${dem2019} ${base_covariates2019} if civil_law !=.   ,  vce(robust)
	eststo: reg `var'   ${dem2019} if bananas !=.   ,  vce(robust)
	eststo: reg `var'   ${dem2019} ${base_covariates2019} if bananas !=.   ,  vce(robust)
	eststo: reg `var'   ${dem2019} if lpd1500s !=.   ,  vce(robust)
	eststo: reg `var'   ${dem2019} ${base_covariates2019} if lpd1500s !=.   ,  vce(robust)
	eststo: esttab using ./output/tables/table2_unweighted.tex, append label b(a1) se(a1) keep(${dem2019}) compress nogaps nolines nonotes nocons nodepvars
}

