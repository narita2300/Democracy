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
drop if total_gdp2019==.

local y = 1

foreach var in gdp_growth2020 mean_growth_rate_2001_2019 total_deaths_per_million {
	
	if "`var'" == "gdp_growth2020" | "`var'"== "total_deaths_per_million"{
		local weight "total_gdp2019 population2019"
		local covariates "${base_covariates2019}"
		local index "democracy_vdem2019"
	}
	
	else if "`var'" == "mean_growth_rate_2001_2019" {
		local weight "total_gdp2000 population2000"
		local covariates "${base_covariates2000}"
		local index "democracy_vdem2000"
	}
	
	foreach w in `weight' {
		eststo clear
		forv i = 1/5{
		eststo: ivregress 2sls `var' (`index'=${iv`i'}) [w=`w'], vce(robust)
		eststo: ivregress 2sls `var' `covariates' (`index'=${iv`i'}) [w=`w'], vce(robust)
		}
		esttab using ./output/tables/tableA7_panel`y'_alt_vdem.tex, keep(`index') append label b(a1) se(a1) nodepvars
	}
	
	
	eststo clear
	// no weighting 
	forv i = 1/5{
		eststo: ivregress 2sls `var' (`index'=${iv`i'}) if inrange(`var', r(p1), r(p99)), vce(robust)
		eststo: ivregress 2sls `var' `covariates' (`index'=${iv`i'}) if inrange(`var', r(p1), r(p99)), vce(robust)
	}
	esttab using ./output/tables/tableA7_panel`y'_alt_vdem.tex, keep(`index') append label b(a1) se(a1) nodepvars
	
	local y = `y'+1
}
