********************************************************************************
* Table A3: 2SLS Regression with Alternative Weightings
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use "./output/total.dta", replace

*** Make the sample size consistent across different weightings
drop if total_gdp==.

foreach var in gdp_growth total_deaths_per_million {
	foreach weight in population total_gdp {
		eststo clear
		forv i = 1/5{
		eststo: ivregress 2sls `var' (democracy_fh=${iv`i'}) [w=`weight'], vce(robust)
		eststo: ivregress 2sls `var' ${base_covariates} (democracy_fh=${iv`i'}) [w=`weight'], vce(robust)
		}
		esttab using ./output/tables/tableA3/tableA3.tex, keep(democracy_fh) append label b(a1) se(a1) nodepvars
	}
	eststo clear
	forv i = 1/5{
		eststo: ivregress 2sls `var' (democracy_fh=${iv`i'}) , vce(robust)
		eststo: ivregress 2sls `var' ${base_covariates} (democracy_fh=${iv`i'}), vce(robust)
	}
	esttab using ./output/tables/tableA3/tableA3.tex, keep(democracy_fh) append label b(a1) se(a1) nodepvars
}


