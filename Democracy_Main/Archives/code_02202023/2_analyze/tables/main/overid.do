********************************************************************************
* Table: Over-id Regressions
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace

cd ${path_dropbox}/tables

******************************************
*** Over-identified RF on Outcomes *** 
******************************************

local outcomes mean_growth_rate_2001_2019 gdp_growth2020 total_deaths_per_million
eststo clear
eststo: reg mean_growth_rate_2001_2019 ${iv1} ${iv2} ${iv3} ${iv4} ${iv5} ${weight2000}, robust
eststo: reg gdp_growth2020 ${iv1} ${iv2} ${iv3} ${iv4} ${iv5} ${weight2019}, robust
eststo: reg total_deaths_per_million ${iv1} ${iv2} ${iv3} ${iv4} ${iv5} ${weight2019}, robust

esttab using overid_rf.tex, ///
	replace label cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(2))") ///
	nodepvars nogaps nonotes nostar mlabels(none) drop(`covariates' _cons) stats(N, labels("N") fmt(0)) 
	
eststo clear
eststo: ivreg2 mean_growth_rate_2001_2019 (${dem2000} = ${iv1} ${iv2} ${iv3} ${iv4} ${iv5}) ${weight2000}, robust
eststo: ivreg2 gdp_growth2020 (${dem2019} = ${iv1} ${iv2} ${iv3} ${iv4} ${iv5})  ${weight2019}, robust
eststo: ivreg2 total_deaths_per_million (${dem2019} = ${iv1} ${iv2} ${iv3} ${iv4} ${iv5})  ${weight2019}, robust

esttab using overid_2sls.tex, ///
	replace label cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(2))") ///
	nodepvars nogaps nonotes nostar mlabels(none) drop(`covariates' _cons) stats(N, labels("N") fmt(0)) 
