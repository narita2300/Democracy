cap ssc install ivreg2, replace
cap ssc install ranktest, replace

global main_path "/Users/leonardofancello/Dropbox"
global path_code "${main_path}/Democracy/Democracy_Main/MainAnalysis/code"
global path_data "${main_path}/Democracy/Democracy_Main/MainAnalysis/output/data"
global path_output "${main_path}/Democracy/Democracy_Main/MainAnalysis/output/tables"
global path_coefs "${path_output}/coefs"

*********************************************************************
* Table : 2SLS Regression Estimates of Democracy's Effect By Decade * 
*********************************************************************

*** Change to appropriate directory
cd "${path_output}"
cap mkdir "old"

*** Load data 
use "${path_data}/total.dta", clear

drop if financial_flow_1981_1990==.
drop if financial_flow_1991_2000==.
drop if financial_flow_2001_2010==.
drop if financial_flow_2011_2020==.
drop if financial_flow_2020_2022==.

drop if democracy_vdem1980==.
drop if democracy_vdem1990==.
drop if democracy_vdem2000==.
drop if democracy_vdem2010==.
drop if democracy_vdem2019==.

drop if mean_temp_1971_1980==.
drop if mean_temp_1981_1990==.
drop if mean_temp_1991_2000==.
drop if mean_temp_2001_2010==.
drop if mean_temp_2011_2016==.

drop if total_gdp1980==.
drop if total_gdp1990==.
drop if total_gdp2000==.
drop if total_gdp2010==.
drop if total_gdp2019==.


************************************ 
************************************ Y: Mean Financial Flows in 1981-1990 

eststo clear 
forv i = 1/6{
		eststo: ivregress 2sls financial_flow_1981_1990 (democracy_vdem1980=${iv`i'})[w=total_gdp1980], vce(robust)
		eststo: ivregress 2sls financial_flow_1981_1990 abs_lat mean_temp_1971_1980 mean_precip_1971_1980 median_age1980 pop_density1980 (democracy_vdem1980=${iv`i'})[w=total_gdp1980], vce(robust)
	}
	
esttab using "old/2sls_by_decade_panel1.tex", ///
keep(democracy_vdem1980) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///

************************************ 
************************************ Y: Mean Financial Flows in 1991-2000

eststo clear 
forv i = 1/6{
		eststo: ivregress 2sls financial_flow_1991_2000 (democracy_vdem1990=${iv`i'})[w=total_gdp1990], vce(robust)
		eststo: ivregress 2sls financial_flow_1991_2000 abs_lat mean_temp_1981_1990 mean_precip_1981_1990 median_age1990 pop_density1990 (democracy_vdem1990=${iv`i'})[w=total_gdp1990], vce(robust)
	}

esttab using "old/2sls_by_decade_panel2.tex", ///
keep(democracy_vdem1990) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///
	
************************************ 
************************************ Y: Mean Financial Flows in 2001-2010

eststo clear 
forv i = 1/6{
		eststo: ivregress 2sls financial_flow_2001_2010 (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
		eststo: ivregress 2sls financial_flow_2001_2010 abs_lat mean_temp_1991_2000 mean_precip_1991_2000 median_age2000 pop_density2000 (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
	}
	

esttab using "old/2sls_by_decade_panel3.tex", ///
keep(democracy_vdem2000) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///

*********************************** 
************************************ Y: Mean Financial Flows in 2011-2020

eststo clear 
forv i = 1/6{
		eststo: ivregress 2sls financial_flow_2011_2020 (democracy_vdem2010=${iv`i'})[w=total_gdp2010], vce(robust)
		eststo: ivregress 2sls financial_flow_2011_2020 abs_lat mean_temp_2001_2010 mean_precip_2001_2010 median_age2010 pop_density2010 (democracy_vdem2010=${iv`i'})[w=total_gdp2010], vce(robust)
	}

	
esttab using "old/2sls_by_decade_panel4.tex", ///
keep(democracy_vdem2010) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///

*********************************** 
************************************ Y: Mean Financial Flows in 2020-2022

eststo clear 
forv i = 1/6{
		eststo: ivregress 2sls financial_flow_2020_2022 (democracy_vdem2019=${iv`i'})[w=total_gdp2019], vce(robust)
		eststo: ivregress 2sls financial_flow_2020_2022 abs_lat mean_temp_2011_2016 mean_precip_2011_2016 median_age2020 pop_density2019 (democracy_vdem2019=${iv`i'})[w=total_gdp2019], vce(robust)
	}

	
esttab using "old/2sls_by_decade_panel5.tex", ///
keep(democracy_vdem2019) ///
replace label b(a1) se(a1) obslast nostar nodepvars nogaps nonotes mlabels(none) ///
prefoot(`" \hline \\[-1.8ex] IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs}  \\ Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark  & \xmark & \cmark\\"') stats(N, labels("N") fmt(0))

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use("old/2sls_by_decade_panel1.tex" "old/2sls_by_decade_panel2.tex" "old/2sls_by_decade_panel3.tex" "old/2sls_by_decade_panel4.tex" "old/2sls_by_decade_panel5.tex") paneltitles("Growth Rate Mean Financial Flows in 1981-1990" "Growth Rate Mean Financial Flows in 1991-2000" "Growth Rate Mean Financial Flows in 2001-2010" "Growth Rate Mean Financial Flows in 2011-2020" "Growth Rate Mean Financial Flows in 2020-2022") columncount(13) save("old/2sls_by_decade_financial_flows.tex") cleanup
