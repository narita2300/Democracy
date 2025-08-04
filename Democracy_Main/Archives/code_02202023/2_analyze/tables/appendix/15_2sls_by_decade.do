*************************************************************************************************
* Table : 2SLS Regression Estimates of Democracy's Effect By Decade with Control for Baseline GDP 
*************************************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace

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
	
esttab using ${path_appendix}/2sls_by_decade_panel1.tex, ///
keep(democracy_vdem1980) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///
// title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
// posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 1981-1990} \\ \cline{2-11}  \\[-1.8ex]"')
	

************************************ 
************************************ Y: Mean GDP growth rate in 1991-2000

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_1991_2000 (democracy_vdem1990=${iv`i'})[w=total_gdp1990], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_1991_2000 abs_lat mean_temp_1981_1990 mean_precip_1981_1990 median_age1990 pop_density1990 (democracy_vdem1990=${iv`i'})[w=total_gdp1990], vce(robust)
	}

esttab using ${path_appendix}/2sls_by_decade_panel2.tex, ///
keep(democracy_vdem1990) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///
// title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
// posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 1991-2000} \\ \cline{2-11}  \\[-1.8ex]"')
	
************************************ 
************************************ Y: Mean GDP growth rate in 2001-2010

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_2001_2010 (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_2001_2010 abs_lat mean_temp_1991_2000 mean_precip_1991_2000 median_age2000 pop_density2000 (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
	}
	

esttab using ${path_appendix}/2sls_by_decade_panel3.tex, ///
keep(democracy_vdem2000) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///
// title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
// posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 2001-2010} \\ \cline{2-11}  \\[-1.8ex]"')	

*********************************** 
************************************ Y: Mean GDP growth rate in 2011-2020

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_2011_2020 (democracy_vdem2010=${iv`i'})[w=total_gdp2010], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_2011_2020 abs_lat mean_temp_2001_2010 mean_precip_2001_2010 median_age2010 pop_density2010 (democracy_vdem2010=${iv`i'})[w=total_gdp2010], vce(robust)
	}

	
esttab using ${path_appendix}/2sls_by_decade_panel4.tex, ///
keep(democracy_vdem2010) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///
// title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
// posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 2011-2020} \\ \cline{2-11}  \\[-1.8ex]"')

// include "${path_code}/2_analyze/tables/appendix/PanelCombine5"
// panelcombine, use(${path_appendix}/2sls_by_decade_panel1.tex) paneltitles("") columncount(11) save(${path_appendix}/2sls_by_decade_panelA.tex) 

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(${path_appendix}/2sls_by_decade_panel1.tex ${path_appendix}/2sls_by_decade_panel2.tex ${path_appendix}/2sls_by_decade_panel3.tex ${path_appendix}/2sls_by_decade_panel4.tex) paneltitles("Mean GDP Growth Rate in 1981-1990" "Mean GDP Growth Rate in 1991-2000" "Mean GDP Growth Rate in 2001-2010" "Mean GDP Growth Rate in 2011-2020") columncount(11) save(${path_appendix}/15_2sls_by_decade_panelA.tex) cleanup




*************************************************************************************************
* Panel B : Control for GDPPC 
*************************************************************************************************

************************************ 
************************************ Y: Mean GDP growth rate in 1981-1990 

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_1981_1990 gdppc1980 (democracy_vdem1980=${iv`i'})[w=total_gdp1980], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_1981_1990 gdppc1980 abs_lat mean_temp_1971_1980 mean_precip_1971_1980 median_age1980 pop_density1980 (democracy_vdem1980=${iv`i'})[w=total_gdp1980], vce(robust)
	}
	
esttab using ${path_appendix}/2sls_by_decade_panel1.tex, ///
keep(democracy_vdem1980) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///
// title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
// posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 1981-1990} \\ \cline{2-11}  \\[-1.8ex]"')
	

************************************ 
************************************ Y: Mean GDP growth rate in 1991-2000

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_1991_2000 gdppc1990 (democracy_vdem1990=${iv`i'})[w=total_gdp1990], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_1991_2000 gdppc1990 abs_lat mean_temp_1981_1990 mean_precip_1981_1990 median_age1990 pop_density1990 (democracy_vdem1990=${iv`i'})[w=total_gdp1990], vce(robust)
	}

esttab using ${path_appendix}/2sls_by_decade_panel2.tex, ///
keep(democracy_vdem1990) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///
// title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
// posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 1991-2000} \\ \cline{2-11}  \\[-1.8ex]"')
	
************************************ 
************************************ Y: Mean GDP growth rate in 2001-2010

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_2001_2010 gdppc2000 (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_2001_2010 gdppc2000 abs_lat mean_temp_1991_2000 mean_precip_1991_2000 median_age2000 pop_density2000  (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
	}
	

esttab using ${path_appendix}/2sls_by_decade_panel3.tex, ///
keep(democracy_vdem2000) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///
// title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
// posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 2001-2010} \\ \cline{2-11}  \\[-1.8ex]"')	

*********************************** 
************************************ Y: Mean GDP growth rate in 2011-2020

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_2011_2020 gdppc2010 (democracy_vdem2010=${iv`i'})[w=total_gdp2010], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_2011_2020 gdppc2010 abs_lat mean_temp_2001_2010 mean_precip_2001_2010 median_age2010 pop_density2010 (democracy_vdem2010=${iv`i'})[w=total_gdp2010], vce(robust)
	}

	
esttab using ${path_appendix}/2sls_by_decade_panel4.tex, ///
keep(democracy_vdem2010) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///
// title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
// posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 2011-2020} \\ \cline{2-11}  \\[-1.8ex]"')

// include "${path_code}/2_analyze/tables/appendix/PanelCombine5"
// panelcombine, use(${path_appendix}/2sls_by_decade_panel1.tex) paneltitles("") columncount(11) save(${path_appendix}/2sls_by_decade_panelA.tex) 

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(${path_appendix}/2sls_by_decade_panel1.tex ${path_appendix}/2sls_by_decade_panel2.tex ${path_appendix}/2sls_by_decade_panel3.tex ${path_appendix}/2sls_by_decade_panel4.tex) paneltitles("Mean GDP Growth Rate in 1981-1990" "Mean GDP Growth Rate in 1991-2000" "Mean GDP Growth Rate in 2001-2010" "Mean GDP Growth Rate in 2011-2020") columncount(11) save(${path_appendix}/15_2sls_by_decade_panelB.tex) cleanup


*************************************************************************************************
* Panel C : Control for Baseline Total GDP
*************************************************************************************************

************************************ 
************************************ Y: Mean GDP growth rate in 1981-1990 

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_1981_1990 total_gdp1980 (democracy_vdem1980=${iv`i'})[w=total_gdp1980], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_1981_1990 total_gdp1980 abs_lat mean_temp_1971_1980 mean_precip_1971_1980 median_age1980 pop_density1980 (democracy_vdem1980=${iv`i'})[w=total_gdp1980], vce(robust)
	}
	
esttab using ${path_appendix}/2sls_by_decade_panel1.tex, ///
keep(democracy_vdem1980) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///
// title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
// posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 1981-1990} \\ \cline{2-11}  \\[-1.8ex]"')
	

************************************ 
************************************ Y: Mean GDP growth rate in 1991-2000

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_1991_2000 total_gdp1990 (democracy_vdem1990=${iv`i'})[w=total_gdp1990], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_1991_2000 total_gdp1990 abs_lat mean_temp_1981_1990 mean_precip_1981_1990 median_age1990 pop_density1990 (democracy_vdem1990=${iv`i'})[w=total_gdp1990], vce(robust)
	}

esttab using ${path_appendix}/2sls_by_decade_panel2.tex, ///
keep(democracy_vdem1990) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///
// title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
// posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 1991-2000} \\ \cline{2-11}  \\[-1.8ex]"')
	
************************************ 
************************************ Y: Mean GDP growth rate in 2001-2010

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_2001_2010 total_gdp2000 (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_2001_2010 total_gdp2000 abs_lat mean_temp_1991_2000 mean_precip_1991_2000 median_age2000 pop_density2000  (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
	}
	

esttab using ${path_appendix}/2sls_by_decade_panel3.tex, ///
keep(democracy_vdem2000) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///
// title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
// posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 2001-2010} \\ \cline{2-11}  \\[-1.8ex]"')	

*********************************** 
************************************ Y: Mean GDP growth rate in 2011-2020

eststo clear 
forv i = 1/5{
		eststo: ivregress 2sls mean_growth_rate_2011_2020 total_gdp2010 (democracy_vdem2010=${iv`i'})[w=total_gdp2010], vce(robust)
		eststo: ivregress 2sls mean_growth_rate_2011_2020 total_gdp2010 abs_lat mean_temp_2001_2010 mean_precip_2001_2010 median_age2010 pop_density2010 (democracy_vdem2010=${iv`i'})[w=total_gdp2010], vce(robust)
	}

	
esttab using ${path_appendix}/2sls_by_decade_panel4.tex, ///
keep(democracy_vdem2010) ///
replace label b(a1) se(a1) obslast nostar nodepvars nogaps nonotes mlabels(none) ///
prefoot(`" \hline \\[-1.8ex] IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals}  \\ Baseline Controls Other Than Baseline GDP & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') stats(N, labels("N") fmt(0))

// title(`"Democracy's Effect on Mean GDP Growth Rates by decade"') ///
// posthead(`" & \multicolumn{10}{c}{ Dependent Variable is Mean GDP Growth Rate in 2011-2020} \\ \cline{2-11}  \\[-1.8ex]"')

// include "${path_code}/2_analyze/tables/appendix/PanelCombine5"
// panelcombine, use(${path_appendix}/2sls_by_decade_panel1.tex) paneltitles("") columncount(11) save(${path_appendix}/2sls_by_decade_panelA.tex) 

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(${path_appendix}/2sls_by_decade_panel1.tex ${path_appendix}/2sls_by_decade_panel2.tex ${path_appendix}/2sls_by_decade_panel3.tex ${path_appendix}/2sls_by_decade_panel4.tex) paneltitles("Mean GDP Growth Rate in 1981-1990" "Mean GDP Growth Rate in 1991-2000" "Mean GDP Growth Rate in 2001-2010" "Mean GDP Growth Rate in 2011-2020") columncount(11) save(${path_appendix}/15_2sls_by_decade_panelC.tex) cleanup

