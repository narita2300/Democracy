
********************************************************************************
* OLS on Mechanisms Behind Democracy's Effect in 21st Century 
********************************************************************************
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
use ${path_data}/total.dta, replace

foreach var in loginvestment logrtfpna logtrade logtax logprimary logsecondary logmortality{
	gen mean_`var'_1981_1990_pc = mean_`var'_1981_1990*100
	gen mean_`var'_1991_2000_pc = mean_`var'_1991_2000*100
	gen mean_`var'_2001_2010_pc = mean_`var'_2001_2010*100
	gen mean_`var'_2011_2019_pc = mean_`var'_2011_2019*100
}


**** by decade ****
// 1981-1990
eststo clear
foreach var in loginvestment logrtfpna logtrade logtax logprimary logsecondary logmortality{
	eststo: reg mean_`var'_1981_1990_pc democracy_vdem1980 [w=total_gdp1980], vce(robust)
	eststo: reg mean_`var'_1981_1990_pc abs_lat mean_temp_1971_1980 mean_precip_1971_1980 median_age1980 pop_density1980 democracy_vdem1980 [w=total_gdp1980], vce(robust)
	eststo: reg mean_`var'_1981_1990_pc gdppc1980 total_gdp1980 abs_lat mean_temp_1971_1980 mean_precip_1971_1980 median_age1980 pop_density1980 democracy_vdem1980 [w=total_gdp1980], vce(robust)
}
esttab using ${path_output}/ols_mechanisms_by_decade.tex, ///
replace label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
keep(democracy_vdem1980)

// 1991-2000
eststo clear
foreach var in loginvestment logrtfpna logtrade logtax logprimary logsecondary logmortality{
	eststo: reg mean_`var'_1991_2000_pc democracy_vdem1990 [w=total_gdp1990], vce(robust)
	eststo: reg mean_`var'_1991_2000_pc democracy_vdem1990 abs_lat mean_temp_1981_1990 mean_precip_1981_1990 median_age1990 pop_density1990 [w=total_gdp1990], vce(robust)
	eststo: reg mean_`var'_1991_2000_pc gdppc1990 total_gdp1990 democracy_vdem1990 abs_lat mean_temp_1981_1990 mean_precip_1981_1990 median_age1990 pop_density1990 [w=total_gdp1990], vce(robust)
}
esttab using ${path_output}/ols_mechanisms_by_decade.tex, ///
append label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
keep(democracy_vdem1990)

// 2001-2010
eststo clear
foreach var in loginvestment logrtfpna logtrade logtax logprimary logsecondary logmortality{
	eststo: reg mean_`var'_2001_2010_pc democracy_vdem2000 [w=total_gdp2000], vce(robust)
	eststo: reg mean_`var'_2001_2010_pc democracy_vdem2000 abs_lat mean_temp_1991_2000 mean_precip_1991_2000 median_age2000 pop_density2000 [w=total_gdp2000], vce(robust)
	eststo: reg mean_`var'_2001_2010_pc gdppc2000 total_gdp2000 democracy_vdem2000 abs_lat mean_temp_1991_2000 mean_precip_1991_2000 median_age2000 pop_density2000 [w=total_gdp2000], vce(robust)
}
esttab using ${path_output}/ols_mechanisms_by_decade.tex, ///
append label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
keep(democracy_vdem2000)

// 2011-2019
eststo clear
foreach var in loginvestment logrtfpna logtrade logtax logprimary logsecondary logmortality{
	eststo: reg mean_`var'_2011_2019_pc democracy_vdem2010 [w=total_gdp2010], vce(robust)
	eststo: reg mean_`var'_2011_2019_pc democracy_vdem2010 abs_lat mean_temp_2001_2010 mean_precip_2001_2010 median_age2010 pop_density2010 [w=total_gdp2010], vce(robust)
	eststo: reg mean_`var'_2011_2019_pc gdppc2010 total_gdp2010 democracy_vdem2010 abs_lat mean_temp_2001_2010 mean_precip_2001_2010 median_age2010 pop_density2010 [w=total_gdp2010], vce(robust)
}
esttab using ${path_output}/ols_mechanisms_by_decade.tex, ///
append label b(a1) se(a1) stats(N, labels("N")) nodepvars nogaps nonotes mlabels(none) ///
keep(democracy_vdem2010)

