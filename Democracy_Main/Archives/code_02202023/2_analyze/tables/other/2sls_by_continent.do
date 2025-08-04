
***********************************************
*** 2SLS on Covid-19 Outcomes: By Continent *** 
***********************************************
use ${path_data}/total.dta, replace
// drop if countries == "Venezuela"

// World
eststo clear
eststo: regress mean_growth_rate_2001_2019 ${dem2000} ${weight2000}, vce(robust)
		
// Africa
eststo: regress mean_growth_rate_2001_2019 ${dem2000} ${weight2000} if continent == "Africa", vce(robust)

// Asia
eststo: regress mean_growth_rate_2001_2019 ${dem2000} ${weight2000} if continent == "Asia", vce(robust)

// Europe
eststo: regress mean_growth_rate_2001_2019 ${dem2000} ${weight2000} if continent == "Europe", vce(robust)

// Americas
eststo: regress mean_growth_rate_2001_2019 ${dem2000} ${weight2000} if  continent == "North America" | continent == "South America", vce(robust)
// eststo: regress mean_growth_rate_2001_2019 ${dem2000} ${weight2000} if  continent == "Europe" | continent == "North America" | continent == "South America" | continent == "Oceania", vce(robust)

esttab using ${path_output}/2sls_by_continent.tex, ///
replace label b(a1) se(a1) stats(N, labels("N")) ///
nodepvars nogaps nonotes mlabels(none) keep(${dem2000})


foreach i in 1 2 3 4 5{
	
	
		di "`i'"
		eststo clear
		// world
		eststo: ivregress 2sls mean_growth_rate_2001_2019 (${dem2000}=${iv`i'})${weight2000}, vce(robust)
		// eststo: ivregress 2sls mean_growth_rate_2001_2019 ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000}, vce(robust)
		
		// Africa
		eststo: ivregress 2sls mean_growth_rate_2001_2019 (${dem2000}=${iv`i'})${weight2000} if continent == "Africa", vce(robust)
		// eststo: ivregress 2sls mean_growth_rate_2001_2019 ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000} if continent == "Africa", vce(robust)
		
		// Asia
		eststo: ivregress 2sls mean_growth_rate_2001_2019 (${dem2000}=${iv`i'})${weight2000} if continent == "Asia", vce(robust)
		// eststo: ivregress 2sls mean_growth_rate_2001_2019 ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000} if continent == "Asia", vce(robust)
		
		if `i' != 1 & `i' != 5{
			// Europe
		eststo: ivregress 2sls mean_growth_rate_2001_2019 (${dem2000}=${iv`i'}) ${weight2000} if continent == "Europe", vce(robust)
		// eststo: ivregress 2sls mean_growth_rate_2001_2019 ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000} if continent == "Europe", vce(robust)
		}
		
		// Americas
		eststo: ivregress 2sls mean_growth_rate_2001_2019 (${dem2000}=${iv`i'})${weight2000} if continent == "North America" | continent == "South America", vce(robust)
		// eststo: ivregress 2sls mean_growth_rate_2001_2019 ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000} if continent == "North America" | continent == "South America", vce(robust)
		
		esttab using ${path_output}/2sls_by_continent.tex, ///
	append label b(a1) se(a1) stats(N, labels("N")) ///
	nodepvars nogaps nonotes mlabels(none) keep(${dem2000})
}

***********************************************
*** 2SLS on Covid-19 Outcomes: By Continent *** 
***********************************************
use ${path_data}/total.dta, replace
// drop if countries == "Venezuela"

// World
eststo clear
eststo: regress gdp_growth2020 ${dem2000} ${weight2000}, vce(robust)
		
// Africa
eststo: regress gdp_growth2020 ${dem2000} ${weight2000} if continent == "Africa", vce(robust)

// Asia
eststo: regress gdp_growth2020 ${dem2000} ${weight2000} if continent == "Asia", vce(robust)

// Europe
// eststo: regress gdp_growth2020 ${dem2000} ${weight2000} if continent == "Europe", vce(robust)

// Americas
eststo: regress gdp_growth2020 ${dem2000} ${weight2000} if  continent == "Europe" | continent == "North America" | continent == "South America" | continent == "Oceania", vce(robust)
// eststo: regress gdp_growth2020 ${dem2000} ${weight2000} if  continent == "Europe" | continent == "North America" | continent == "South America" | continent == "Oceania", vce(robust)

esttab using ${path_output}/2sls_2020_by_continent.tex, ///
replace label b(a1) se(a1) stats(N, labels("N")) ///
nodepvars nogaps nonotes mlabels(none) keep(${dem2000})


foreach i in 1 2 4{
		di "`i'"
		eststo clear
		// world
		eststo: ivregress 2sls gdp_growth2020 (${dem2000}=${iv`i'})${weight2000}, vce(robust)
		// eststo: ivregress 2sls gdp_growth2020 ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000}, vce(robust)
		
		// Africa
		eststo: ivregress 2sls gdp_growth2020 (${dem2000}=${iv`i'})${weight2000} if continent == "Africa", vce(robust)
		// eststo: ivregress 2sls gdp_growth2020 ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000} if continent == "Africa", vce(robust)
		
		// Asia
		eststo: ivregress 2sls gdp_growth2020 (${dem2000}=${iv`i'})${weight2000} if continent == "Asia", vce(robust)
		// eststo: ivregress 2sls gdp_growth2020 ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000} if continent == "Asia", vce(robust)
		
		// 
// 		eststo: ivregress 2sls gdp_growth2020 (${dem2000}=${iv`i'}) ${weight2000} if continent == "Europe", vce(robust)
// 		// eststo: ivregress 2sls gdp_growth2020 ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000} if continent == "Europe", vce(robust)
		
		// Europe and Americas
		eststo: ivregress 2sls gdp_growth2020 (${dem2000}=${iv`i'})${weight2000} if continent == "Europe" | continent == "North America" | continent == "South America" |continent == "Oceania", vce(robust)
		// eststo: ivregress 2sls gdp_growth2020 ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000} if continent == "North America" | continent == "South America", vce(robust)
		
		esttab using ${path_output}/2sls_2020_by_continent.tex, ///
	append label b(a1) se(a1) stats(N, labels("N")) ///
	nodepvars nogaps nonotes mlabels(none) keep(${dem2000})
}

***********************************************
*** 2SLS on Covid-19 Outcomes: By Continent *** 
***********************************************
use ${path_data}/total.dta, replace
// drop if countries == "Venezuela"

// World
eststo clear
eststo: regress total_deaths_per_million ${dem2000} ${weight2000}, vce(robust)
		
// Africa
eststo: regress total_deaths_per_million ${dem2000} ${weight2000} if continent == "Africa", vce(robust)

// Asia
eststo: regress total_deaths_per_million ${dem2000} ${weight2000} if continent == "Asia", vce(robust)

// Europe
eststo: regress total_deaths_per_million ${dem2000} ${weight2000} if continent == "Europe", vce(robust)

// Americas
eststo: regress total_deaths_per_million ${dem2000} ${weight2000} if  continent == "Europe" | continent == "North America" | continent == "South America" | continent == "Oceania", vce(robust)
// eststo: regress total_deaths_per_million ${dem2000} ${weight2000} if  continent == "Europe" | continent == "North America" | continent == "South America" | continent == "Oceania", vce(robust)

esttab using ${path_output}/2sls_deaths_by_continent.tex, ///
replace label b(a1) se(a1) stats(N, labels("N")) ///
nodepvars nogaps nonotes mlabels(none) keep(${dem2000})


foreach i in 1 2 4{
		di "`i'"
		eststo clear
		// world
		eststo: ivregress 2sls total_deaths_per_million (${dem2000}=${iv`i'})${weight2000}, vce(robust)
		// eststo: ivregress 2sls total_deaths_per_million ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000}, vce(robust)
		
		// Africa
		eststo: ivregress 2sls total_deaths_per_million (${dem2000}=${iv`i'})${weight2000} if continent == "Africa", vce(robust)
		// eststo: ivregress 2sls total_deaths_per_million ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000} if continent == "Africa", vce(robust)
		
		// Asia
		eststo: ivregress 2sls total_deaths_per_million (${dem2000}=${iv`i'})${weight2000} if continent == "Asia", vce(robust)
		// eststo: ivregress 2sls total_deaths_per_million ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000} if continent == "Asia", vce(robust)
		
		// 
// 		eststo: ivregress 2sls total_deaths_per_million (${dem2000}=${iv`i'}) ${weight2000} if continent == "Europe", vce(robust)
// 		// eststo: ivregress 2sls total_deaths_per_million ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000} if continent == "Europe", vce(robust)
		
		// Europe and Americas
		eststo: ivregress 2sls total_deaths_per_million (${dem2000}=${iv`i'})${weight2000} if continent == "Europe" | continent == "North America" | continent == "South America" |continent == "Oceania", vce(robust)
		// eststo: ivregress 2sls total_deaths_per_million ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000} if continent == "North America" | continent == "South America", vce(robust)
		
		esttab using ${path_output}/2sls_deaths_by_continent.tex, ///
	append label b(a1) se(a1) stats(N, labels("N")) ///
	nodepvars nogaps nonotes mlabels(none) keep(${dem2000})
}

// ***********************************************
// *** 2SLS on Economic Growth: By Continent *** 
// ***********************************************
// use ${path_data}/total.dta, replace
// drop if countries == "Venezuela"

// eststo clear

// eststo: regress mean_growth_rate_2001_2019 ${dem2000} ${weight2000}, vce(robust)
// eststo: regress mean_growth_rate_2001_2019 gdppc2000 ${dem2000} ${weight2000}, vce(robust)
// eststo: regress mean_growth_rate_2001_2019 gdppc2000 ${base_covariates2000} ${dem2000} ${weight2000}, vce(robust)
		
// // Africa
// eststo: regress mean_growth_rate_2001_2019 ${dem2000} ${weight2000} if continent == "Africa", vce(robust)
// eststo: regress mean_growth_rate_2001_2019 gdppc2000 ${dem2000} ${weight2000} if continent == "Africa", vce(robust)
// eststo: regress mean_growth_rate_2001_2019 gdppc2000 ${base_covariates2000} ${dem2000} ${weight2000} if continent == "Africa", vce(robust)

// // Asia
// eststo: regress mean_growth_rate_2001_2019 ${dem2000} ${weight2000} if continent == "Asia", vce(robust)
// eststo: regress mean_growth_rate_2001_2019 gdppc2000 ${dem2000} ${weight2000} if continent == "Asia", vce(robust)
// eststo: regress mean_growth_rate_2001_2019 gdppc2000 ${base_covariates2000} ${dem2000} ${weight2000} if continent == "Asia", vce(robust)

// // Europe
// eststo: regress mean_growth_rate_2001_2019 ${dem2000} ${weight2000} if continent == "Europe", vce(robust)
// eststo: regress mean_growth_rate_2001_2019 gdppc2000 ${dem2000} ${weight2000} if continent == "Europe", vce(robust)
// eststo: regress mean_growth_rate_2001_2019 gdppc2000 ${base_covariates2000} ${dem2000} ${weight2000} if continent == "Europe", vce(robust)

// // Americas
// eststo: regress mean_growth_rate_2001_2019 ${dem2000} ${weight2000} if continent == "North America" | continent == "South America", vce(robust)
// eststo: regress mean_growth_rate_2001_2019 gdppc2000 ${dem2000} ${weight2000} if continent == "North America" | continent == "South America", vce(robust)
// eststo: regress mean_growth_rate_2001_2019 gdppc2000 ${base_covariates2000} ${dem2000} ${weight2000} if continent == "North America" | continent == "South America", vce(robust)

// esttab using ${path_output}/2sls_by_continent.tex, ///
// replace label b(a1) se(a1) stats(N, labels("N")) ///
// nodepvars nogaps nonotes mlabels(none) keep(${dem2000})


