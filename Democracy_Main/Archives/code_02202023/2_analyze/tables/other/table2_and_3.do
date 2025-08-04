

clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use "./output/total.dta", replace

***** TABLE 2 *****
*** Panel A
foreach var in gdp_growth total_deaths_per_million {
	eststo clear
	forv i = 1/5{
		eststo: ivregress 2sls `var' (democracy_fh=${iv`i'})[w=total_gdp], vce(robust)
		eststo: ivregress 2sls `var' ${base_covariates} (democracy_fh=${iv`i'})[w=total_gdp], vce(robust)
		}
		esttab using ./output/tables/all/all.csv, keep(democracy_fh) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

*** Panel B
eststo clear
forv i=1/5{
	eststo: reg democracy_fh ${iv`i'} [w=total_gdp], vce(robust)
	eststo: reg democracy_fh ${iv`i'} ${base_covariates} [w=total_gdp], vce(robust)
}
esttab using ./output/tables/all/all.csv, nocons append label b(a1) se(a1) nodepvars drop(${base_covariates} _cons) scalar(F) r2(a1) obslast nolines nogaps nonotes compress plain


*** Panel C
eststo clear
foreach var in gdp_growth total_deaths_per_million{
	eststo clear
	eststo: reg `var' democracy_fh if logem !=. [w=total_gdp], vce(robust)
	eststo: reg `var' democracy_fh ${base_covariates} if logem !=. [w=total_gdp],  vce(robust)
	eststo: reg `var' democracy_fh if EurFrac !=. [w=total_gdp],  vce(robust)
	eststo: reg `var' democracy_fh ${base_covariates} if EurFrac !=. [w=total_gdp],  vce(robust)
	eststo: reg `var' democracy_fh if legor_uk !=. [w=total_gdp],  vce(robust)
	eststo: reg `var' democracy_fh ${base_covariates} if legor_uk !=. [w=total_gdp],  vce(robust)
	eststo: reg `var' democracy_fh if bananas !=. [w=total_gdp],  vce(robust)
	eststo: reg `var' democracy_fh ${base_covariates} if bananas !=. [w=total_gdp],  vce(robust)
	eststo: reg `var' democracy_fh if lpd1500s !=. [w=total_gdp],  vce(robust)
	eststo: reg `var' democracy_fh ${base_covariates} if lpd1500s !=. [w=total_gdp],  vce(robust)
	eststo: esttab using ./output/tables/all/all.csv, append label b(a1) se(a1) keep(democracy_fh) compress nogaps nolines nonotes nocons nodepvars plain
}

***** TABLE 3 *****
clear

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use "./output/total.dta", replace

*** Make sample consistent across mechanism variables
drop if containmenthealth10==. | coverage10 ==. | days_betw_10th_case_and_policy ==.

* index: Freedom House's democracy index
* weight: GDP (total_gdp)

foreach var in containmenthealth10 coverage10 days_betw_10th_case_and_policy {
	eststo clear
	forv i = 1/5{
		eststo: ivregress 2sls `var' (democracy_fh=${iv`i'})[w=total_gdp], vce(robust)
		eststo: ivregress 2sls `var' ${base_covariates} (democracy_fh=${iv`i'})[w=total_gdp], vce(robust)
	}
	esttab using ./output/tables/all/all.csv, keep(democracy_fh) append label b(a1) se(a1) compress nogaps nolines nonotes nocons nodepvars plain
}



