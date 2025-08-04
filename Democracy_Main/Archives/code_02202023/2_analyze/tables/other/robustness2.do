


use ${path_output}/total.dta, replace

** we estimate our preferred specification without countries with a Cook’s distance above a common rule-of-thumb threshold (four divided by the number of observations) **

ivreg2 gdp_growth2020 (${dem2019}=${iv1})
predict cooksd, cooksd

ivregress 2sls gdp_growth2020 (${dem2019}=${iv1})
// predict hello

regress gdp_growth2020 ${dem2019} ${weight2019}
predict cooksd, cooksd 
drop if cooksd > (4/153)
drop cooksd
regress gdp_growth2020 ${dem2019}

regress mean_growth_rate_2001_2019 ${dem2000}
predict cooksd, cooksd
drop if cooksd > (4/153) 
drop cooksd
regress mean_growth_rate_2001_2019 ${dem2000}

regress total_deaths_per_million ${dem2019}
predict cooksd, cooksd 
drop if cooksd > (4/153)
drop cooksd
regress gdp_growth2020 ${dem2019}



** the relevant threshold is 4/N = 4/80 = 0.05
drop if cooksd > 0.05

drop if cooksd < -0.2
ivreg2 gdp_growth2020 (${dem2019}=${iv1}) ${weight2019}, robust


	
forv i = 1/5{
	use ${path_output}/total.dta, replace

	ivreg2 gdp_growth2020 (${dem2019}=${iv`i'}) ${weight2019}, robust
	predict cooksd
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
