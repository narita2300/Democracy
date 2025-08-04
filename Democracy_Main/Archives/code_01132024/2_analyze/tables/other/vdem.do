
********************************************************************************
* Table: 2SLS Regression Estimates of Democracy's Effects using V-Dem
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use "./output/total.dta", replace


**********************************************************
*** Table: 2SLS on Economic and Public Health Outcomes *** 
**********************************************************

local dem2020 "democracy_vdem2019"
local dem2000 "democracy_vdem2000"


************************************ First row
************************************ Y: GDP growth rates in 2020
eststo clear
forv i = 1/5{
			eststo: ivregress 2sls gdp_growth2020 (democracy_vdem2019=${iv`i'}) [w=total_gdp2019], vce(robust)
			eststo: ivregress 2sls gdp_growth2020 ${base_covariates2019} (democracy_vdem2019=${iv`i'})[w=total_gdp2019], vce(robust)
}

esttab using ./output/tables/vdem.tex, ///
	replace label b(a1) se(a1) stats(N, labels("N")) ///
	nodepvars nogaps nonotes mlabels(none) keep(democracy_vdem2019) ///
	title(`"Democracy's Effect on Covid-19 Deaths Per Million in 2020"') ///
	posthead(`"&\multicolumn{10}{c}{ Dependent Variable is the GDP Growth Rate in 2020}\\\cline{2-11}\\[-1.8ex]"') ///
	prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' /// 
	`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')

************************************ Second row
************************************ Y: Mean GDP growth rate in 2001-2019
// Second row: democracy's effect on mean GDP growth rate in 2001-2019
eststo clear
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_2001_2019 (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_2001_2019 ${base_covariates2000} (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
}
esttab using ./output/tables/vdem.tex, ///
	append label b(a1) se(a1) stats(N, labels("N")) ///
	nodepvars nogaps nonotes mlabels(none) keep(democracy_vdem2000) ///
	posthead(`"&\multicolumn{10}{c}{ Dependent Variable is the Mean GDP Growth Rate in 2001-2019}\\\cline{2-11}\\[-1.8ex]"')

************************************ Third row
************************************ Y: Covid-19 Deaths Per Million in 2020
// Third row: democracy's effect on Total Covid-19 Deaths Per Million in 2020		
eststo clear
forv i = 1/5{
		eststo: ivregress 2sls total_deaths_per_million (democracy_vdem2019=${iv`i'})[w=total_gdp2019], vce(robust)
		eststo: ivregress 2sls total_deaths_per_million ${base_covariates2019} (democracy_vdem2019=${iv`i'})[w=total_gdp2019], vce(robust)
}

esttab using ./output/tables/vdem.tex, ///
	append label b(a1) se(a1) stats(N, labels("N")) ///
	nodepvars nogaps nonotes mlabels(none) keep(democracy_vdem2019) ///
	posthead(`"&\multicolumn{10}{c}{ Dependent Variable is Covid-19 Deaths Per Million in 2020}\\\cline{2-11}\\[-1.8ex]"')
	
******************************************
*** Panel B: OLS on Covid-19 Outcomes *** 
******************************************

foreach var in gdp_growth2020 {
	eststo clear
	eststo: reg `var' democracy_vdem2019 if logem !=. [w=total_gdp2019], vce(robust)
	eststo: reg `var' democracy_vdem2019 ${base_covariates2019} if logem !=. [w=total_gdp2019],  vce(robust)
	eststo: reg `var' democracy_vdem2019 if EurFrac !=. [w=total_gdp2019],  vce(robust)
	eststo: reg `var' democracy_vdem2019 ${base_covariates2019} if EurFrac !=. [w=total_gdp2019],  vce(robust)
	eststo: reg `var' democracy_vdem2019 if legor_uk !=. [w=total_gdp2019],  vce(robust)
	eststo: reg `var' democracy_vdem2019 ${base_covariates2019} if legor_uk !=. [w=total_gdp2019],  vce(robust)
	eststo: reg `var' democracy_vdem2019 if bananas !=. [w=total_gdp2019],  vce(robust)
	eststo: reg `var' democracy_vdem2019 ${base_covariates2019} if bananas !=. [w=total_gdp2019],  vce(robust)
	eststo: reg `var' democracy_vdem2019 if lpd1500s !=. [w=total_gdp2019],  vce(robust)
	eststo: reg `var' democracy_vdem2019 ${base_covariates2019} if lpd1500s !=. [w=total_gdp2019],  vce(robust)
	eststo: esttab using ./output/tables/vdem.tex, append label b(a1) se(a1) keep(democracy_vdem2019) compress nogaps nolines nonotes nocons nodepvars
}

foreach var in mean_growth_rate_2001_2019{
	eststo clear
	eststo: reg `var' democracy_vdem2000 if logem !=. [w=total_gdp2000], vce(robust)
	eststo: reg `var' democracy_vdem2000 ${base_covariates2000} if logem !=. [w=total_gdp2000],  vce(robust)
	eststo: reg `var' democracy_vdem2000 if EurFrac !=. [w=total_gdp2000],  vce(robust)
	eststo: reg `var' democracy_vdem2000 ${base_covariates2000} if EurFrac !=. [w=total_gdp2000],  vce(robust)
	eststo: reg `var' democracy_vdem2000 if legor_uk !=. [w=total_gdp2000],  vce(robust)
	eststo: reg `var' democracy_vdem2000 ${base_covariates2000} if legor_uk !=. [w=total_gdp2000],  vce(robust)
	eststo: reg `var' democracy_vdem2000 if bananas !=. [w=total_gdp2000],  vce(robust)
	eststo: reg `var' democracy_vdem2000 ${base_covariates2000} if bananas !=. [w=total_gdp2000],  vce(robust)
	eststo: reg `var' democracy_vdem2000 if lpd1500s !=. [w=total_gdp2000],  vce(robust)
	eststo: reg `var' democracy_vdem2000 ${base_covariates2000} if lpd1500s !=. [w=total_gdp2000],  vce(robust)
	eststo: esttab using ./output/tables/vdem.tex, append label b(a1) se(a1) keep(democracy_vdem2000) compress nogaps nolines nonotes nocons nodepvars
}

foreach var in total_deaths_per_million {
	eststo clear
	eststo: reg `var' democracy_vdem2019 if logem !=. [w=total_gdp2019], vce(robust)
	eststo: reg `var' democracy_vdem2019 ${base_covariates2019} if logem !=. [w=total_gdp2019],  vce(robust)
	eststo: reg `var' democracy_vdem2019 if EurFrac !=. [w=total_gdp2019],  vce(robust)
	eststo: reg `var' democracy_vdem2019 ${base_covariates2019} if EurFrac !=. [w=total_gdp2019],  vce(robust)
	eststo: reg `var' democracy_vdem2019 if legor_uk !=. [w=total_gdp2019],  vce(robust)
	eststo: reg `var' democracy_vdem2019 ${base_covariates2019} if legor_uk !=. [w=total_gdp2019],  vce(robust)
	eststo: reg `var' democracy_vdem2019 if bananas !=. [w=total_gdp2019],  vce(robust)
	eststo: reg `var' democracy_vdem2019 ${base_covariates2019} if bananas !=. [w=total_gdp2019],  vce(robust)
	eststo: reg `var' democracy_vdem2019 if lpd1500s !=. [w=total_gdp2019],  vce(robust)
	eststo: reg `var' democracy_vdem2019 ${base_covariates2019} if lpd1500s !=. [w=total_gdp2019],  vce(robust)
	eststo: esttab using ./output/tables/vdem.tex, append label b(a1) se(a1) keep(democracy_vdem2019) compress nogaps nolines nonotes nocons nodepvars
}


**********************************************************
*** Table: OLS on Democracy Index *** 
**********************************************************

eststo clear
forv i=1/5{
	eststo: reg democracy_vdem2019 ${iv`i'} [w=total_gdp2019], vce(robust)
	eststo: reg democracy_vdem2019 ${iv`i'} ${base_covariates2019} [w=total_gdp2019], vce(robust)
}
esttab using ./output/tables/vdem.tex, nocons append label b(a1) se(a1) nodepvars drop(${base_covariates2019} _cons) scalar(F) r2(a1) obslast nolines nogaps nonotes 
