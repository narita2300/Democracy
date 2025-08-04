

********************************************************************************
* 2SLS: Democracy and TFP
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace

********************************************************************************
// Generate the TFP growth rate between each year

forvalues year = 2001/2019{
	di `year'
	local last_year = `year' - 1
	gen rtfpna_change_`year' = (rtfpna`year' - rtfpna`last_year')/rtfpna`last_year'
}

egen mean_tfpgrowth_2001_2019 = rowmean(rtfpna_change_2001-rtfpna_change_2019)

********************************************************************************

eststo clear
foreach var in tfpgrowth{
	eststo: reg mean_`var'_2001_2019 ${dem2000} ${weight2000}, vce(robust)
	eststo: reg mean_`var'_2001_2019 ${dem2000} ${base_covariates2000} ${weight2000}, vce(robust)
	eststo: reg mean_`var'_2001_2019 ${dem2000} gdppc2000 total_gdp2000 ${base_covariates2000} ${weight2000}, vce(robust)
}

********************************************************************************

eststo clear
foreach var in rtfpna{
	eststo: reg mean_`var'_2001_2019 ${dem2000} ${weight2000}, vce(robust)
	eststo: reg mean_`var'_2001_2019 ${base_covariates2000} ${dem2000} ${weight2000}, vce(robust)
	eststo: reg mean_`var'_2001_2019 gdppc2000 total_gdp2000 ${base_covariates2000} ${dem2000} ${weight2000}, vce(robust)
}
esttab using ${path_output}/2sls_mechanisms_tfp.tex, ///
keep(${dem2000}) replace label b(a1) se(a1) stats(N, labels("N")) nogaps nonotes mlabels(none)

***************************************************
*** Panel B-F: 2SLS on Mechanism against Democracy *** 
***************************************************

eststo clear
forvalues i = 1/5{
		eststo clear
		foreach var in tfpgrowth{
			eststo: ivregress 2sls mean_`var'_2001_2019 (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
			eststo: ivregress 2sls mean_`var'_2001_2019 ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
			eststo: ivregress 2sls mean_`var'_2001_2019 gdppc2000 total_gdp2000 ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)	
	}
}

esttab using ${path_output}/2sls_mechanisms_tfp.tex, ///
keep(${dem2000}) replace label b(a1) se(a1) stats(N, labels("N")) nogaps nonotes mlabels(none)

********************************************************************************

eststo clear
forvalues i = 1/5{
	eststo clear
	foreach var in rtfpna{
		eststo: ivregress 2sls mean_`var'_2001_2019 (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
		eststo: ivregress 2sls mean_`var'_2001_2019 ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
		eststo: ivregress 2sls mean_`var'_2001_2019 gdppc2000 total_gdp2000 ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)	
}
}

esttab using ${path_output}/2sls_mechanisms_tfp.tex, ///
keep(${dem2000}) replace label b(a1) se(a1) stats(N, labels("N")) nogaps nonotes mlabels(none)


