********************************************************************************
* Table: 2SLS Regression Estimates of Democracy's Effects on GDP per capita 
********************************************************************************
clear 

*** Change to appropriate directory
cd ${path_dropbox}/tables

*** Load data 
use ${path_data}/total.dta, replace

******************************************
*** Panel A: 2SLS on GDP per capita in 2000 *** 
******************************************
local outcome gdppc2000 
// local weight "${weight2000}"
local covariates "${base_covariates2000}"
local index "${dem2000}"

eststo clear
forv i = 1/6{
			
			eststo: ivreg2 `outcome' (`index'=${iv`i'}) `weight', robust
			scalar fstat = e(widstat)
			estadd scalar fs = fstat

			eststo: ivreg2 `outcome' `covariates' (`index'=${iv`i'}) `weight', robust
			scalar fstat = e(widstat)
			estadd scalar fs = fstat
}

local last "stats(fs, fmt(1 1) labels("F-Statistic (First stage)")) prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"')"

esttab using ${path_output}/2sls_gdppc2000_panelA.csv, ///
replace cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(2))") stats(fs, fmt(1 1) labels("F-Statistic (First stage)")) ///
nodepvars nogaps nonotes nostar mlabels(none) keep(`index')

// esttab using 2sls_gdppc2000_panelA.tex, ///
// replace label cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(2))")  `last' ///
// nodepvars nogaps nonotes nostar mlabels(none) keep(`index')

******************************************
*** Panel B: OLS on GDP per capita in 2000 *** 
******************************************

// local outcomes mean_gdppc_growth_2001_2019 gdppc_growth2020 total_deaths_per_million
local outcome gdppc2000 
// local weight "${weight2000}"
local covariates "${base_covariates2000}"
local index "${dem2000}"
	
eststo clear
forv i = 1/6{

	if `i' == 6{
		eststo: reg `outcome' `index' if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. `weight', vce(robust)
		eststo: reg `outcome' `index' `covariates' if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. `weight', vce(robust)
	}
	else {
		eststo: reg `outcome' `index' if `:word 1 of ${iv`i'}' !=. `weight', vce(robust)
		eststo: reg `outcome' `index' `covariates' if `:word 1 of ${iv`i'}' !=. `weight', vce(robust)
	}
	
}

local last "stats(N, labels("N")) prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')"

esttab using 2sls_gdppc2000_panelB.csv, ///
replace b(a1) se(a1) stats(N, labels("N")) ///
nodepvars nogaps nonotes nostar mlabels(none) keep(`index') 

// esttab using 2sls_gdppc2000_panelB.tex, ///
// replace label b(a1) se(a1) `last' ///
// nodepvars nogaps nonotes nostar mlabels(none) keep(`index') 

********************************************************************************
* Table: 2SLS Regression Estimates of Democracy's Effects on GDP per capita 
********************************************************************************

******************************************
*** Panel A: 2SLS on Total GDP in 2000 *** 
******************************************
local outcome total_gdp2000 
// local weight "${weight2000}"
local covariates "${base_covariates2000}"
local index "${dem2000}"

eststo clear
forv i = 1/6{
			
			eststo: ivreg2 `outcome' (`index'=${iv`i'}) `weight', robust
			scalar fstat = e(widstat)
			estadd scalar fs = fstat

			eststo: ivreg2 `outcome' `covariates' (`index'=${iv`i'}) `weight', robust
			scalar fstat = e(widstat)
			estadd scalar fs = fstat
}

local last "stats(fs, fmt(1 1) labels("F-Statistic (First stage)")) prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"')"

esttab using ${path_output}/2sls_total_gdp2000_panelA.csv, ///
replace cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(2))") stats(fs, fmt(1 1) labels("F-Statistic (First stage)")) ///
nodepvars nogaps nonotes nostar mlabels(none) keep(`index')

// esttab using 2sls_total_gdp2000_panelA.tex, ///
// replace label cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(2))")  `last' ///
// nodepvars nogaps nonotes nostar mlabels(none) keep(`index')

******************************************
*** Panel B: OLS on Total GDP in 2000 *** 
******************************************

local outcome total_gdp2000  
// local weight "${weight2000}"
local covariates "${base_covariates2000}"
local index "${dem2000}"
	
eststo clear
forv i = 1/6{

	if `i' == 6{
		eststo: reg `outcome' `index' if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. `weight', vce(robust)
		eststo: reg `outcome' `index' `covariates' if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. `weight', vce(robust)
	}
	else {
		eststo: reg `outcome' `index' if `:word 1 of ${iv`i'}' !=. `weight', vce(robust)
		eststo: reg `outcome' `index' `covariates' if `:word 1 of ${iv`i'}' !=. `weight', vce(robust)
	}
	
}

local last "stats(N, labels("N")) prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')"

esttab using 2sls_total_gdp2000_panelB.csv, ///
replace b(a1) se(a1) stats(N, labels("N")) ///
nodepvars nogaps nonotes nostar mlabels(none) keep(`index') 

// esttab using 2sls_total_gdp2000_panelB.tex, ///
// replace label b(a1) se(a1) `last' ///
// nodepvars nogaps nonotes nostar mlabels(none) keep(`index') 

