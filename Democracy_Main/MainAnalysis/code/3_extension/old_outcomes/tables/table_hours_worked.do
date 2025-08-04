// cap ssc install ivreg2, replace
// cap ssc install ranktest, replace

global main_path "/Users/leonardofancello/Dropbox/Democracy"
global path_code "${main_path}/Democracy_Main/MainAnalysis/code"
global path_data "${main_path}/Democracy_Main/MainAnalysis/output/data"
global path_output "${main_path}/Democracy_Main/MainAnalysis/output/tables/extensions/old"
global path_coefs "${path_output}/coefs"

global lang_trade_iv "EngFrac EurFrac"
global legor_iv "legor_uk"
global crops_minerals_iv "bananas coffee copper maize millet rice rubber silver sugarcane wheat"

global iv1 "logem"
global iv2 "lpd1500s"
global iv3 "legor_uk"
global iv4 "$lang_trade_iv"
global iv5 "$crops_minerals_iv"
global iv6 "logem lpd1500s $legor_iv $lang_trade_iv $crops_minerals_iv"

*********************************************************************
* Table : 2SLS Regression Estimates of Democracy's Effect By Decade * 
*********************************************************************

*** Load data 
use ${path_data}/total.dta, clear

drop if hours_worked_core==.

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
	
************************************ 
************************************ Y: Hours Worked per Employed

eststo clear 
forv i = 1/6{
		eststo: ivregress 2sls hours_worked_core (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
		eststo: ivregress 2sls hours_worked_core abs_lat mean_temp_1991_2000 mean_precip_1991_2000 median_age2000 pop_density2000 (democracy_vdem2000=${iv`i'})[w=total_gdp2000], vce(robust)
	}
	

esttab using ${path_output}/2sls_by_decade_panel1.tex, ///
keep(democracy_vdem2000) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///
prefoot(`" \hline \\[-1.8ex] IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs}  \\ Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark  & \xmark & \cmark\\"') stats(N, labels("N") fmt(0))

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(${path_output}/2sls_by_decade_panel1.tex) paneltitles("Hours Worked per Employed") columncount(13) save(${path_output}/2sls_by_decade_hours_worked.tex) cleanup
