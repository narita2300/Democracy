*************************************************************************************************
* Table : 2SLS Regression Estimates of Democracy's Effect By Decade with Control for Baseline GDP 
*************************************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use "./output/total.dta", replace


drop if mean_growth_rate_1981_1990==.
drop if mean_growth_rate_1991_2000==.
drop if mean_growth_rate_2001_2010==.
drop if mean_growth_rate_2011_2020==.

drop if democracy_vdem1980==.
drop if democracy_vdem1990==.
drop if democracy_vdem2000==.
drop if democracy_vdem2010==.

drop if mean_temp_1981_1990==.
drop if mean_temp_1991_2000==.
drop if mean_temp_2001_2010==.
drop if mean_temp_2011_2016==.

drop if total_gdp1980==.
drop if total_gdp1990==.
drop if total_gdp2000==.
drop if total_gdp2010==.

drop if gdppc1980==.
drop if gdppc1990==.
drop if gdppc2000==.
drop if gdppc2010==.

*************************************************************************************************
* Panel A : No control for baseline GDP 
*************************************************************************************************

************************************ 
************************************ Y: Mean GDP growth rate in 1981-1990 

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_1981_1990 (democracy_vdem1980=${iv`i'})[w=total_gdp1980], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_1981_1990 abs_lat mean_temp_1971_1980 mean_precip_1971_1980 median_age1980 pop_density1980 (democracy_vdem1980=${iv`i'})[w=total_gdp1980], vce(robust)
	}
	
esttab using ./output/tables/2sls_by_decade_panelA.tex, ///
keep(democracy_vdem1980) ///
replace label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 1981-1990} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' ///
`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 
	

************************************ 
************************************ Y: Mean GDP growth rate in 1991-2000

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_1991_2000 (democracy_vdem1990=${iv`i'})[w=total_gdp1990], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_1991_2000 abs_lat mean_temp_1981_1990 mean_precip_1981_1990 median_age1990 pop_density1990 (democracy_vdem1990=${iv`i'})[w=total_gdp1990], vce(robust)
	}

esttab using ./output/tables/2sls_by_decade_panelA.tex, ///
keep(democracy_vdem1990) ///
append label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 1991-2000} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' ///
`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 
	
	

************************************ 
************************************ Y: Mean GDP growth rate in 2001-2010

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_2001_2010 (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_2001_2010 abs_lat mean_temp_1991_2000 mean_precip_1991_2000 median_age2000 pop_density2000 (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
	}
	

esttab using ./output/tables/2sls_by_decade_panelA.tex, ///
keep(democracy_vdem2000) ///
append label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 2001-2010} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' ///
`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 
	
	

*********************************** 
************************************ Y: Mean GDP growth rate in 2011-2020

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_2011_2020 (democracy_vdem2010=${iv`i'})[w=total_gdp2010], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_2011_2020 abs_lat mean_temp_2001_2010 mean_precip_2001_2010 median_age2010 pop_density2010 (democracy_vdem2010=${iv`i'})[w=total_gdp2010], vce(robust)
	}

	
esttab using ./output/tables/2sls_by_decade_panelA.tex, ///
keep(democracy_vdem2010) ///
append label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 2011-2010} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' ///
`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 
	
	
*************************************************************************************************
* Panel B : Control for GDPPC 
*************************************************************************************************


************************************ control for GDPPC
************************************ Y: Mean GDP growth rate in 1981-1990 

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_1981_1990 gdppc1980 (democracy_vdem1980=${iv`i'})[w=total_gdp1980], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_1981_1990 gdppc1980 abs_lat mean_temp_1971_1980 mean_precip_1971_1980 median_age1980 pop_density1980 (democracy_vdem1980=${iv`i'})[w=total_gdp1980], vce(robust)
	}
	
esttab using ./output/tables/2sls_by_decade_panelC.tex, ///
keep(democracy_vdem1980) ///
replace label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 1981-1990} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' ///
`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 
	

************************************ control for GDPPC
************************************ Y: Mean GDP growth rate in 1991-2000

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_1991_2000 gdppc1990 (democracy_vdem1990=${iv`i'})[w=total_gdp1990], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_1991_2000 gdppc1990 abs_lat mean_temp_1981_1990 mean_precip_1981_1990 median_age1990 pop_density1990 (democracy_vdem1990=${iv`i'})[w=total_gdp1990], vce(robust)
	}

esttab using ./output/tables/2sls_by_decade_panelC.tex, ///
keep(democracy_vdem1990) ///
append label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 1981-1990} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' ///
`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 
	
	

************************************ control for GDPPC
************************************ Y: Mean GDP growth rate in 2001-2010

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_2001_2010 gdppc2000 (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_2001_2010 gdppc2000 abs_lat mean_temp_1991_2000 mean_precip_1991_2000 median_age2000 pop_density2000 (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
	}
	

esttab using ./output/tables/2sls_by_decade_panelC.tex, ///
keep(democracy_vdem2000) ///
append label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 1981-1990} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' ///
`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 
	
	

*********************************** control for GDPPC
************************************ Y: Mean GDP growth rate in 2011-2020

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_2011_2020 gdppc2010 (democracy_vdem2010=${iv`i'})[w=total_gdp2010], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_2011_2020 gdppc2010 abs_lat mean_temp_2001_2010 mean_precip_2001_2010 median_age2010 pop_density2010 (democracy_vdem2010=${iv`i'})[w=total_gdp2010], vce(robust)
	}

	
esttab using ./output/tables/2sls_by_decade_panelC.tex, ///
keep(democracy_vdem2010) ///
append label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 1981-1990} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' ///
`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 

*************************************************************************************************
* Panel C : Control for Baseline Total GDP
*************************************************************************************************


************************************ control for total_gdp
************************************ Y: Mean GDP growth rate in 1981-1990 

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_1981_1990 total_gdp1980 (democracy_vdem1980=${iv`i'})[w=total_gdp1980], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_1981_1990 total_gdp1980 abs_lat mean_temp_1971_1980 mean_precip_1971_1980 median_age1980 pop_density1980 (democracy_vdem1980=${iv`i'})[w=total_gdp1980], vce(robust)
	}
	
esttab using ./output/tables/2sls_by_decade_panelC.tex, ///
keep(democracy_vdem1980) ///
replace label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 1981-1990} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' ///
`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 
	

************************************ control for total_gdp
************************************ Y: Mean GDP growth rate in 1991-2000

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_1991_2000 total_gdp1990 (democracy_vdem1990=${iv`i'})[w=total_gdp1990], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_1991_2000 total_gdp1990 abs_lat mean_temp_1981_1990 mean_precip_1981_1990 median_age1990 pop_density1990 (democracy_vdem1990=${iv`i'})[w=total_gdp1990], vce(robust)
	}

esttab using ./output/tables/2sls_by_decade_panelC.tex, ///
keep(democracy_vdem1990) ///
append label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 1981-1990} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' ///
`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 
	
	

************************************ control for total_gdp
************************************ Y: Mean GDP growth rate in 2001-2010

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_2001_2010 total_gdp2000 (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_2001_2010 total_gdp2000 abs_lat mean_temp_1991_2000 mean_precip_1991_2000 median_age2000 pop_density2000 (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
	}
	

esttab using ./output/tables/2sls_by_decade_panelC.tex, ///
keep(democracy_vdem2000) ///
append label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 1981-1990} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' ///
`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 
	
	

*********************************** control for total_gdp
************************************ Y: Mean GDP growth rate in 2011-2020

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_2011_2020 total_gdp2010 (democracy_vdem2010=${iv`i'})[w=total_gdp2010], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_2011_2020 total_gdp2010 abs_lat mean_temp_2001_2010 mean_precip_2001_2010 median_age2010 pop_density2010 (democracy_vdem2010=${iv`i'})[w=total_gdp2010], vce(robust)
	}

	
esttab using ./output/tables/2sls_by_decade_panelC.tex, ///
keep(democracy_vdem2010) ///
append label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 1981-1990} \\ \cline{2-11}  \\[-1.8ex]"') ///
prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} & \multicolumn{2}{c}{language, trade} & \multicolumn{2}{c}{legal origins} &  \multicolumn{2}{c}{crops, minerals} &  \multicolumn{2}{c}{pop. density} \\"' ///
`" Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 
	
	
