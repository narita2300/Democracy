********************************************************************************
* Table 2: 2SLS Regression Estimates of Democracy's Effects
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use "./output/total.dta", replace

******************************************
*** Panel A: 2SLS on Covid-19 Outcomes *** 
******************************************

foreach var in gdp_growth total_deaths_per_million {
	eststo clear
	forv i = 1/5{
		eststo: ivregress 2sls `var' (democracy_fh=${iv`i'})[w=population], vce(robust)
		eststo: ivregress 2sls `var' ${base_covariates} (democracy_fh=${iv`i'})[w=population], vce(robust)
		}
		esttab using ./output/tables/table2/panelA.tex, keep(democracy_fh) append label b(a1) se(a1) nodepvars
		}

***************************************
*** Panel B: OLS on Democracy Index *** 
***************************************

eststo clear
forv i=1/5{
	eststo: reg democracy_fh ${iv`i'} [w=population], vce(robust)
	eststo: reg democracy_fh ${iv`i'} ${base_covariates} [w=population], vce(robust)
}
esttab using ./output/tables/table2/panelB.tex, nocons append label b(a1) se(a1) nodepvars scalar(F) r2(a1) obslast

******************************************
*** Panel C: OLS on Covid-19 Outcomes *** 
******************************************

foreach var in gdp_growth total_deaths_per_million{
	eststo clear
	eststo: reg `var' democracy_fh if logem !=. [w=population], vce(robust)
	eststo: reg `var' democracy_fh ${base_covariates} if logem !=. [w=population],  vce(robust)
	eststo: reg `var' democracy_fh if EurFrac !=. [w=population],  vce(robust)
	eststo: reg `var' democracy_fh ${base_covariates} if EurFrac !=. [w=population],  vce(robust)
	eststo: reg `var' democracy_fh if legor_uk !=. [w=population],  vce(robust)
	eststo: reg `var' democracy_fh ${base_covariates} if legor_uk !=. [w=population],  vce(robust)
	eststo: reg `var' democracy_fh if bananas !=. [w=population],  vce(robust)
	eststo: reg `var' democracy_fh ${base_covariates} if bananas !=. [w=population],  vce(robust)
	eststo: reg `var' democracy_fh if lpd1500s !=. [w=population],  vce(robust)
	eststo: reg `var' democracy_fh ${base_covariates} if lpd1500s !=. [w=population],  vce(robust)
	eststo: esttab using ./output/tables/table2/panelC.tex, append label b(a1) se(a1) keep(democracy_fh) compress nogaps
}

