********************************************************************************
* Table 3: 2SLS Regression on Potential Channels Behind Democracy's Effect
********************************************************************************
clear

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use "./output/total.dta", replace

*** Make sample consistent across mechanism variables
drop if containmenthealth10==. | coverage10 ==. | days_betw_10th_case_and_policy ==.

foreach var in containmenthealth10 coverage10 days_betw_10th_case_and_policy {
	eststo clear
	forv i = 1/5{
		eststo: ivregress 2sls `var' (democracy_fh=${iv`i'})[w=population], vce(robust)
		eststo: ivregress 2sls `var' ${base_covariates} (democracy_fh=${iv`i'})[w=population], vce(robust)
	}
	esttab using ./output/tables/table3/table3.tex, keep(democracy_fh) append label b(a1) se(a1) nodepvars
}
