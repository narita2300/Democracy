********************************************************************************
* Robustness Check
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data


*** Load data 
use ${path_output}/total.dta, replace

*** we re-estimate our preferred specification without countries with a standarized residual above 1.96 or below -1.96. ***


forv i = 1/5{
	use ${path_output}/total.dta, replace

	ivreg2 gdp_growth2020 (${dem2019}=${iv`i'}) ${weight2019}, robust
	predict yhat
	gen resid = gdp_growth2020 - yhat
	egen resid_std = std(resid)
	keep if resid_std<=1.96 & resid_std>=-1.96
	drop yhat resid resid_std
	ivreg2 gdp_growth2020 (${dem2019}=${iv`i'}) ${weight2019}, robust

	use ${path_output}/total.dta, replace
	
	ivreg2 gdp_growth2020 ${base_covariates2019} (${dem2019}=${iv`i'}) ${weight2019}, robust
	predict yhat
	gen resid = gdp_growth2020 - yhat
	egen resid_std = std(resid)
	keep if resid_std<=1.96 & resid_std>=-1.96
	drop yhat resid resid_std
	ivreg2 gdp_growth2020 ${base_covariates2019} (${dem2019}=${iv`i'}) ${weight2019}, robust

}

forv i = 1/5{
	use ${path_output}/total.dta, replace

	ivreg2 mean_growth_rate_2001_2019 (${dem2000}=${iv`i'}) ${weight2000}, robust
	predict yhat
	gen resid = gdp_growth2020 - yhat
	egen resid_std = std(resid)
	keep if resid_std<=1.96 & resid_std>=-1.96
	drop yhat resid resid_std
	ivreg2 gdp_growth2020 (${dem2000}=${iv`i'}) ${weight2000}, robust

	use ${path_output}/total.dta, replace
	
	ivreg2 mean_growth_rate_2001_2019 ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, robust
	predict yhat
	gen resid = gdp_growth2020 - yhat
	egen resid_std = std(resid)
	keep if resid_std<=1.96 & resid_std>=-1.96
	drop yhat resid resid_std
	ivreg2 gdp_growth2020 ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, robust

}

ivreg2 gdp_growth2020 (${dem2019}=${iv2}) ${weight2019}, robust
predict yhat
gen resid = gdp_growth2020 - yhat
egen resid_std = std(resid)
keep if resid_std<=1.96 & resid_std>=-1.96
drop yhat resid resid_std
ivreg2 gdp_growth2020 (${dem2019}=${iv2}) ${weight2019}, robust

ivreg2 gdp_growth2020 ${base_covariates2019} (${dem2019}=${iv2}) ${weight2019}, robust
predict yhat
gen resid = gdp_growth2020 - yhat
egen resid_std = std(resid)
keep if resid_std<=1.96 & resid_std>=-1.96
drop yhat resid resid_std
ivreg2 gdp_growth2020 ${base_covariates2019} (${dem2019}=${iv2}) ${weight2019}, robust

ivreg2 gdp_growth2020 (${dem2019}=${iv3}) ${weight2019}, robust
predict yhat
gen resid = gdp_growth2020 - yhat
egen resid_std = std(resid)
keep if resid_std<=1.96 & resid_std>=-1.96
drop yhat resid resid_std
ivreg2 gdp_growth2020 (${dem2019}=${iv3}) ${weight2019}, robust

ivreg2 gdp_growth2020 ${base_covariates2019} (${dem2019}=${iv3}) ${weight2019}, robust
predict yhat
gen resid = gdp_growth2020 - yhat
egen resid_std = std(resid)
keep if resid_std<=1.96 & resid_std>=-1.96
drop yhat resid resid_std
ivreg2 gdp_growth2020 ${base_covariates2019} (${dem2019}=${iv3}) ${weight2019}, robust


