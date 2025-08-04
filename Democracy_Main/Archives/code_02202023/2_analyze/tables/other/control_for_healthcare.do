
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use "./output/total.dta", replace

************************************ Outcome is the mean GDP growth rate in 2001-2019
************************************ both with and without controls (10 columns)

// X: Democracy Index in 2000
// Y: Average GDP growth rate in 2001-2019.
// Z; the five IVs.  
// W: Average total GDP in 2001-2019
// C: absolute latitude, mean temperature (1991-2000), mean precipitation (1991-2000), population density (2000), median age (2000)

eststo clear
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_2001_2019 ///
		(democracy_csp2000=${iv`i'}) ///
		[w=mean_total_gdp_2001_2019], ///
		vce(robust)
		
		eststo:ivregress 2sls mean_growth_rate_2001_2019 ///
		abs_lat mean_temp_1991_2000 mean_precip_1991_2000 ///
		pop_density2000 median_age2000 health_security_index ///
		(democracy_csp2000=${iv`i'}) ///
		[w=mean_total_gdp_2001_2019], ///
		vce(robust)
}
esttab using ./output/tables/other/democracy_effect_mean_21st_century_with_health_security_index.tex, ///
	replace label b(a1) se(a1) stats(N, labels("N")) ///
	nodepvars nogaps nonotes mlabels(none) keep(democracy_csp2000) ///
	title(`"Democracy's Effect on the Mean GDP Growth Rate in 2001-2019"') ///
	posthead(`"&\multicolumn{10}{c}{ Dependent Variable is the Mean GDP Growth Rate in 2001-2019}\\\cline{2-11}\\[-1.8ex]"') ///
	prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' /// 
	`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')

************************************ Outcome is the GDP growth rate in 2020
************************************ both with and without controls (10 columns)

// X: Democracy Index in 2018
// Y: GDP growth rate in 2020.
// Z; the five IVs.  
// W: Total GDP in 2020
// C: absolute latitude, mean temperature (1991-2016), mean precipitation (1991-2016), population density (2020, estimated in 2019), median age (2020, estimated in 2019)

eststo clear
forv i = 1/5{
		eststo: ivregress 2sls gdp_growth2020 (democracy_csp2018=${iv`i'})[w=total_gdp2019], vce(robust)
		
		eststo: ivregress 2sls gdp_growth2020 abs_lat mean_temp_1991_2016 mean_precip_1991_2016 pop_density2020 median_age2020 health_security_index ///
		(democracy_csp2018=${iv`i'})[w=total_gdp2020], vce(robust)
}

esttab using ./output/tables/other/democracy_effect_mean_21st_century_with_health_security_index.tex, ///
	append label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) keep(democracy_csp2018) ///
	title(`"Democracy's Effect on the GDP Growth Rate in 2020"') ///
	posthead(`"  & \multicolumn{10}{c}{ Dependent Variable is the GDP Growth Rate in 2020} \\ \cline{2-11}  \\[-1.8ex]"') ///
	prefoot(`"IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' /// 
	`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 
	
