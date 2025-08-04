********************************************************************************
* Table A2: 2SLS Regression with Alternative Democracy Indices
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use "./output/total.dta", replace

*** Make the sample size consistent across different weightings
drop if democracy_fh==.
drop if democracy_csp==.
drop if democracy_eiu==.


foreach var in gdp_growth total_deaths_per_million {
	foreach index in democracy_fh democracy_csp democracy_eiu{
		eststo clear
		forv i = 1/5{
		eststo: ivregress 2sls `var' (`index'=${iv`i'})[w=population], vce(robust)
		eststo: ivregress 2sls `var' ${base_covariates} (`index'=${iv`i'})[w=population], vce(robust)
	}
		esttab using ./output/tables/tableA2/tableA2.tex, keep(`index') append label b(a1) se(a1) nodepvars
	}
	
}
