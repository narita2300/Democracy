********************************************************************************
* Table 2: 2SLS Regression Estimates of Democracy's Effects
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data
cd /Users/ayumis/Dropbox/Democracy/MainAnalysis

*** Load data 
use ${path_data}/total.dta, replace
// keep if ex2col==1

******************************************
*** Panel A: 2SLS on Covid-19 Outcomes *** 
******************************************

************************************ Second row
************************************ Y: Mean GDP growth rate in 2001-2019
// Second row: democracy's effect on mean GDP growth rate in 2001-2019
eststo clear
forv i = 1/5{
		eststo: ivreg2 mean_growth_rate_2001_2019 (${dem2000}=${iv`i'})${weight2000}, robust
		scalar fstat = e(widstat)
		estadd scalar fs = fstat
		estadd scalar fs_root = fstat^(1/2)
				
		eststo: ivreg2 mean_growth_rate_2001_2019 ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000}, robust
		scalar fstat = e(widstat)
		estadd scalar fs = fstat
		estadd scalar fs_root = fstat^(1/2)
}
// esttab using ./output/tables/table2_original.tex, ///
// 	replace label cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(2))" "t(fmt(2) abs)") stats(fs fs_root N, fmt(1 1 0) labels("F-Statistic (First stage)" "Root of F-stat" "N" )) ///
// 	nodepvars nogaps nonotes nostar collabels(none)mlabels(none) keep(${dem2000}) ///
// 	posthead(`"&\multicolumn{10}{c}{ Dependent Variable is the Mean GDP Growth Rate in 2001-2019}\\\cline{2-11}\\[-1.8ex]"') ///
// 	prefoot(`"Critical Value for |t| & 3.51 & \infty & 2.91 & 3.19 & 4.91 & \infty & \infty & 4.01 & 18.66 & \infty \\"' ///
// 	`"Pass Lee et al. Test? & \cmark & \xmark & \cmark & \cmark & \xmark & \xmark & \xmark & \xmark & \xmark & \xmark & \xmark"')
	
	esttab using ./output/tables/table2_original.tex, ///
	replace label cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(2))" "t(fmt(2) abs)") stats(fs fs_root, fmt( 1 1) labels("F-Statistic (First stage)" "Root of F-Statistic")) ///
	nodepvars nogaps nonotes nostar collabels(none)mlabels(none) keep(${dem2000}) ///
	posthead(`"&\multicolumn{10}{c}{ Dependent Variable is the Mean GDP Growth Rate in 2001-2019}\\\cline{2-11}\\[-1.8ex]"') ///
	postfoot(`"Critical Value for $|t|$ & 3.51 & \infty & 2.91 & 3.19 & 4.91 & $\infty$ & $\infty$ & 4.01 & 18.66 & $\infty$ \\"' ///
	`"Pass Lee et al. Test? & \cmark & \xmark & \cmark & \cmark & \xmark & \xmark & \xmark & \xmark & \xmark & \xmark"')
	

************************************ First row
************************************ Y: GDP growth rates in 2020
eststo clear
forv i = 1/5{
			eststo: ivreg2 gdp_growth2020 (${dem2019}=${iv`i'}) ${weight2019}, robust
			scalar fstat = e(widstat)
			estadd scalar fs = fstat
			estadd scalar fs_root = fstat^(1/2)
		
			eststo: ivreg2 gdp_growth2020 ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, robust
			scalar fstat = e(widstat)
			estadd scalar fs = fstat
			estadd scalar fs_root = fstat^(1/2)
}

esttab using ./output/tables/table2_original.tex, ///
	append label cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(2))" "t(fmt(2) abs)") stats(fs fs_root, fmt(1 1) labels("F-Statistic (First stage)" "Root of F-Statistic")) ///
	nodepvars nogaps nonotes nostar  collabels(none)mlabels(none) keep(${dem2019}) ///
	title(`"Democracy's Effect on Covid-19 Deaths Per Million in 2020"') ///
	posthead(`"&\multicolumn{10}{c}{ Dependent Variable is the GDP Growth Rate in 2020}\\\cline{2-11}\\[-1.8ex]"') ///
	postfoot(`" Critical Value for |t| & 3.03 & 2.17 & 2.41 & 1.98 & 3.11 & 2.75 & 7.37 & 2.85 & 4.54 & 5.43 \\"' ///
	`" Pass Lee et al.'s Test? & \cmark & \cmark & \xmark & \xmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark"')

// \\ Pass Lee et al.'s Test? \'
************************************ Third row
************************************ Y: Covid-19 Deaths Per Million in 2020
// Third row: democracy's effect on Total Covid-19 Deaths Per Million in 2020		
eststo clear
forv i = 1/5{
		eststo: ivreg2 total_deaths_per_million (${dem2019}=${iv`i'})${weight2019}, robust first
		scalar fstat = e(widstat)
		estadd scalar fs = fstat
		estadd scalar fs_root = fstat^(1/2)
		
		eststo: ivreg2 total_deaths_per_million ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, robust first
		scalar fstat = e(widstat)
		estadd scalar fs = fstat
		estadd scalar fs_root = fstat^(1/2)
}

esttab using ./output/tables/table2_original.tex, ///
	append label cells("b(fmt(1))" "se(par fmt(1))" "p(fmt(2))" "t(fmt(2) abs)") stats(fs fs_root N, fmt(1 1 0) labels("F-Statistic (First stage)" "Root of F-Statistic" "N" )) ///
	nodepvars nogaps nonotes nostar collabels(none) mlabels(none) keep(${dem2019}) ///
	posthead(`"&\multicolumn{10}{c}{ Dependent Variable is Covid-19 Deaths Per Million in 2020}\\\cline{2-11}\\[-1.8ex]"') ///
	postfoot(`"Critical Value for $|t|$ & 3.03 & 2.17 & 2.41 & 1.98 & 3.11 & 2.75 & 7.37 & 2.85 & 4.54 & 5.43 \\ "' ///
	`" Pass Lee et al.'s Test? & \cmark & \cmark & \cmark & \cmark & \cmark & \cmark & \xmark & \cmark & \xmark & \cmark \\"' ///
	`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} &  \multicolumn{2}{c}{language \& trade} &  \multicolumn{2}{c}{crops \& minerals} \\"' /// 
	`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')
	
******************************************
*** Panel B: OLS on Covid-19 Outcomes *** 
******************************************
* index: Freedom House's democracy index (democracy_fh)
* weight = GDP (total_gdp)

foreach var in gdp_growth2020 {
	eststo clear
	eststo: reg `var' ${dem2019} if logem !=. ${weight2019}, vce(robust)
	eststo: reg `var' ${dem2019} ${base_covariates2019} if logem !=. ${weight2019},  vce(robust)
	eststo: reg `var' ${dem2019} if EurFrac !=. ${weight2019},  vce(robust)
	eststo: reg `var' ${dem2019} ${base_covariates2019} if EurFrac !=. ${weight2019},  vce(robust)
	eststo: reg `var' ${dem2019} if civil_law !=. ${weight2019},  vce(robust)
	eststo: reg `var' ${dem2019} ${base_covariates2019} if civil_law !=. ${weight2019},  vce(robust)
	eststo: reg `var' ${dem2019} if bananas !=. ${weight2019},  vce(robust)
	eststo: reg `var' ${dem2019} ${base_covariates2019} if bananas !=. ${weight2019},  vce(robust)
	eststo: reg `var' ${dem2019} if lpd1500s !=. ${weight2019},  vce(robust)
	eststo: reg `var' ${dem2019} ${base_covariates2019} if lpd1500s !=. ${weight2019},  vce(robust)
	eststo: esttab using ./output/tables/table2_panelB.tex, replace label b(a1) se(a1) keep(${dem2019}) compress nogaps nolines nonotes nocons nodepvars
}

foreach var in mean_growth_rate_2001_2019{
	eststo clear
	eststo: reg `var' ${dem2000} if logem !=. ${weight2000}, vce(robust)
	eststo: reg `var' ${dem2000} ${base_covariates2000} if logem !=. ${weight2000},  vce(robust)
	eststo: reg `var' ${dem2000} if EurFrac !=. ${weight2000},  vce(robust)
	eststo: reg `var' ${dem2000} ${base_covariates2000} if EurFrac !=. ${weight2000},  vce(robust)
	eststo: reg `var' ${dem2000} if civil_law !=. ${weight2000},  vce(robust)
	eststo: reg `var' ${dem2000} ${base_covariates2000} if civil_law !=. ${weight2000},  vce(robust)
	eststo: reg `var' ${dem2000} if bananas !=. ${weight2000},  vce(robust)
	eststo: reg `var' ${dem2000} ${base_covariates2000} if bananas !=. ${weight2000},  vce(robust)
	eststo: reg `var' ${dem2000} if lpd1500s !=. ${weight2000},  vce(robust)
	eststo: reg `var' ${dem2000} ${base_covariates2000} if lpd1500s !=. ${weight2000},  vce(robust)
	eststo: esttab using ./output/tables/table2_panelB.tex, append label b(a1) se(a1) keep(${dem2000}) compress nogaps nolines nonotes nocons nodepvars
}

foreach var in total_deaths_per_million {
	eststo clear
	eststo: reg `var' ${dem2019} if logem !=. ${weight2019}, vce(robust)
	eststo: reg `var' ${dem2019} ${base_covariates2019} if logem !=. ${weight2019},  vce(robust)
	eststo: reg `var' ${dem2019} if EurFrac !=. ${weight2019},  vce(robust)
	eststo: reg `var' ${dem2019} ${base_covariates2019} if EurFrac !=. ${weight2019},  vce(robust)
	eststo: reg `var' ${dem2019} if civil_law !=. ${weight2019},  vce(robust)
	eststo: reg `var' ${dem2019} ${base_covariates2019} if civil_law !=. ${weight2019},  vce(robust)
	eststo: reg `var' ${dem2019} if bananas !=. ${weight2019},  vce(robust)
	eststo: reg `var' ${dem2019} ${base_covariates2019} if bananas !=. ${weight2019},  vce(robust)
	eststo: reg `var' ${dem2019} if lpd1500s !=. ${weight2019},  vce(robust)
	eststo: reg `var' ${dem2019} ${base_covariates2019} if lpd1500s !=. ${weight2019},  vce(robust)
	eststo: esttab using ./output/tables/table2_panelB.tex, append label b(a1) se(a1) keep(${dem2019}) compress nogaps nolines nonotes nocons nodepvars
}

