
********************************************************************************
* Table A4: 2SLS Regression excluding the US and China
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use "./output/total.dta", replace

***********************************************************************************
*** Panel A row 1 & Panel B row 2 : 2SLS with sample including the US and China ***
***********************************************************************************

foreach var in gdp_growth total_deaths_per_million {
	eststo clear
	forv i = 1/5{
		eststo: ivregress 2sls `var' (democracy_fh=${iv`i'})[w=population], vce(robust)
		eststo: ivregress 2sls `var' ${base_covariates} (democracy_fh=${iv`i'})[w=population], vce(robust)
	}
	esttab using ./output/tables/tableA4/tableA4.tex, keep(democracy_fh) append label b(a1) se(a1) nodepvars
}

**********************************************************************************
*** Panel A, row 2 : 2SLS on GDP growth with sample excluding the US and China ***
**********************************************************************************
drop if countries=="United States"
drop if countries=="China"

foreach var in gdp_growth total_deaths_per_million {
	eststo clear
	forv i = 1/5{
		eststo: ivregress 2sls `var' (democracy_fh=${iv`i'})[w=population], vce(robust)
		eststo: ivregress 2sls `var' ${base_covariates} (democracy_fh=${iv`i'})[w=population], vce(robust)
	}
	esttab using ./output/tables/tableA4/tableA4.tex, keep(democracy_fh) append label b(a1) se(a1) nodepvars
}
