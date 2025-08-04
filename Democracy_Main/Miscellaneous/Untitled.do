
************************************ include diabetes prevalence in 2010
************************************ both with and without controls (10 columns)

// X: Democracy Index in 2000
// Y: Average GDP growth rate in 2001-2019.
// Z; the five IVs.  
// W: Average total GDP in 2001-2019
// C: absolute latitude, mean temperature (1991-2000), mean precipitation (1991-2000), 
// population density (2000), median age (2000)

eststo clear
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_2001_2019 (democracy_csp2000=${iv`i'})[w=mean_total_gdp_2001_2019], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_2001_2019 abs_lat mean_temp_1991_2000 mean_precip_1991_2000 pop_density2000 median_age2000 diabetes_prevalence2010 (democracy_csp2000=${iv`i'})[w=mean_total_gdp_2001_2019], vce(robust)
}
esttab using ./output/tables/other/democracy_effect_mean_21st_century_with_diabetes_control.tex, ///
	replace label b(a1) se(a1) stats(N, labels("N")) ///
	nodepvars nogaps nonotes mlabels(none) keep(democracy_csp2000) ///
	title(`"Democracy's Effect on the Mean GDP Growth Rate in 2001-2019"') ///
	posthead(`"&\multicolumn{10}{c}{ Dependent Variable is the Mean GDP Growth Rate in 2001-2019}\\\cline{2-11}\\[-1.8ex]"') ///
	prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' /// 
	`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')

// X: Democracy Index in 2018
// Y: GDP growth rate in 2020.
// Z; the five IVs.  
// W: Total GDP in 2019
// C: absolute latitude, mean temperature in (1991-2016), mean precipitation (1991-2016), population density (2020), median age (2020), diabetes prevalence (2019)

eststo clear
forv i = 1/5{
		eststo: ivregress 2sls gdp_growth2020 (democracy_csp2018=${iv`i'})[w=total_gdp2019], vce(robust)
		eststo: ivregress 2sls gdp_growth2020 abs_lat mean_temp_1991_2016 mean_precip_1991_2016 pop_density2020 median_age2020 diabetes_prevalence2019 (democracy_csp2018=${iv`i'})[w=total_gdp2020], vce(robust)
}

esttab using ./output/tables/other/democracy_effect_mean_21st_century_with_diabetes_control.tex, ///
	append label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) keep(democracy_csp2018) ///
	title(`"Democracy's Effect on the GDP Growth Rate in 2020"') ///
	posthead(`"  & \multicolumn{10}{c}{ Dependent Variable is the GDP Growth Rate in 2020} \\ \cline{2-11}  \\[-1.8ex]"') ///
	prefoot(`"IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' /// 
	`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 




************************************
************************************	


// egen avg_dem_index_2003_2019 = rowmean(democracy_fh2003-democracy_fh2019)
gen sum_dem_index_2003_2019 = democracy_fh2003 + democracy_fh2004 + democracy_fh2005 + ///
democracy_fh2006 + democracy_fh2007 + democracy_fh2008 + ///
democracy_fh2009 + democracy_fh2010 + democracy_fh2011 + ///
democracy_fh2012 + democracy_fh2013 + democracy_fh2014 + ///
democracy_fh2015 + democracy_fh2016 + democracy_fh2017 + ///
democracy_fh2018 + democracy_fh2019
gen avg_dem_index_2003_2019 = sum_dem_index_2003_2019/17


************************************
************************************ do NOT lag democracy index by a year. 

foreach var of varlist gdp_growth2003-gdp_growth2020{
	eststo clear
	local year = substr("`var'", 11, .)
	local lag_year = `year'-1
	if `year' == 2020{
		forv i = 1/5{
		eststo: ivregress 2sls `var' (democracy_fh`year'=${iv`i'})[w=total_gdp`lag_year'], vce(robust)
		}
	} 
	else {
	forv i = 1/5{
		eststo: ivregress 2sls `var' (democracy_fh`year'=${iv`i'})[w=total_gdp`year'], vce(robust)
	}	
}
	
esttab using ./output/tables/other/democracy_effect_21st_century.tex, ///
	append label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) keep(democracy_fh`year') ///
	title(`"Democracy's Effect on GDP Growth Rates in `year'"') posthead(`"  & \multicolumn{5}{c}{ Dependent Variable is the GDP Growth Rate in `year'} \\ \cline{2-6}  \\[-1.8ex]"') prefoot(`" IVs & settler mortality & language, trade & legal origins &  crops, minerals &  pop. density \\"' /// 
	`" Controls & \xmark & \xmark &  \xmark & \xmark & \xmark \\"') 
}	


************************************
************************************ lag democracy index by a year. 

foreach var of varlist gdp_growth2004-gdp_growth2020{
	eststo clear
	local year = substr("`var'", 11, .)
	local lag_year = `year'-1
	if `year' == 2020{
		forv i = 1/5{
		eststo: ivregress 2sls `var' (democracy_fh`lag_year'=${iv`i'})[w=total_gdp`lag_year'], vce(robust)
		}
	} 
	else {
	forv i = 1/5{
		eststo: ivregress 2sls `var' (democracy_fh`lag_year'=${iv`i'})[w=total_gdp`year'], vce(robust)
	}	
	}
	
esttab using ./output/tables/other/democracy_effect_21st_century_lag_democracy.tex, ///
	append label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) keep(democracy_fh`lag_year') ///
	title(`"Democracy's Effect on GDP Growth Rates in `year'"') posthead(`"  & \multicolumn{5}{c}{ Dependent Variable is the GDP Growth Rate in `year'} \\ \cline{2-6}  \\[-1.8ex]"') prefoot(`" IVs & settler mortality & language, trade & legal origins &  crops, minerals &  pop. density \\"' /// 
	`" Controls & \xmark & \xmark &  \xmark & \xmark & \xmark \\"') 
}	
	// esttab using ./output/tables/other/dem_effect_21st_century.csv, keep(democracy_fh`year') append label b(a1) se(a1) nolines nogaps compress plain
	


// Can you modify the regression by regressing the GDP growth rate in year X on the democracy index in year X-1? This way, we would alleviate the concern of reverse causality and omitted variables affecting both GDP and democracy.
// Can we add a 2SLS regression of (a) the average GDP growth rate between 200X-2019 on (b) the democracy level in 200X-1? This would be the most natural regression for the “21st century”





foreach var in gdp_growth1980 gdp_growth1981 gdp_growth1982 gdp_growth1983 ///
gdp_growth1984 gdp_growth1985 gdp_growth1986 gdp_growth1987 gdp_growth1988 ///
gdp_growth1989 gdp_growth1990 gdp_growth1991 gdp_growth1992 gdp_growth1993 /// 
gdp_growth1994 gdp_growth1995 gdp_growth1996 gdp_growth1997 gdp_growth1998 ///
gdp_growth1999 gdp_growth2000 gdp_growth2001 gdp_growth2002 gdp_growth2003 ///
gdp_growth2004 gdp_growth2005 gdp_growth2006 gdp_growth2007 gdp_growth2008 ///
gdp_growth2009 gdp_growth2010 gdp_growth2011 gdp_growth2012 gdp_growth2013 /// 
gdp_growth2014 gdp_growth2015 gdp_growth2016 gdp_growth2017 gdp_growth2018 ///
gdp_growth2019 gdp_growth2020 {
	eststo clear
	forv i = 1/5{
		eststo: ivregress 2sls `var' (democracy_fh=${iv`i'})[w=total_gdp], vce(robust)
		// eststo: ivregress 2sls `var' ${base_covariates} (democracy_fh=${iv`i'})[w=total_gdp], vce(robust)
		}
		esttab using ./output/tables/all/all_controls.csv, keep(democracy_fh) append label b(a1) se(a1) nolines nogaps compress plain
}

foreach var in gdp_growth1980 gdp_growth1981 gdp_growth1982 gdp_growth1983 ///
gdp_growth1984 gdp_growth1985 gdp_growth1986 gdp_growth1987 gdp_growth1988 ///
gdp_growth1989 gdp_growth1990 gdp_growth1991 gdp_growth1992 gdp_growth1993 /// 
gdp_growth1994 gdp_growth1995 gdp_growth1996 gdp_growth1997 gdp_growth1998 ///
gdp_growth1999 gdp_growth2000 gdp_growth2001 gdp_growth2002 gdp_growth2003 ///
gdp_growth2004 gdp_growth2005 gdp_growth2006 gdp_growth2007 gdp_growth2008 ///
gdp_growth2009 gdp_growth2010 gdp_growth2011 gdp_growth2012 gdp_growth2013 /// 
gdp_growth2014 gdp_growth2015 gdp_growth2016 gdp_growth2017 gdp_growth2018 ///
gdp_growth2019 gdp_growth2020 {
	eststo clear
	forv i = 1/5{
		eststo: ivregress 2sls `var' (democracy_fh=${iv`i'}), vce(robust)
		// eststo: ivregress 2sls `var' ${base_covariates} (democracy_fh=${iv`i'})[w=total_gdp], vce(robust)
		}
		esttab using ./output/tables/all/all_noweights.csv, keep(democracy_fh) append label b(a1) se(a1) nolines nogaps compress plain
}


ivregress 2sls gdp_growth2000 (democracy_fh=logem)[w=total_gdp], vce(robust)
ivregress 2sls gdp_growth2000 (democracy_fh=logem)[w=total_gdp], vce(robust)


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



