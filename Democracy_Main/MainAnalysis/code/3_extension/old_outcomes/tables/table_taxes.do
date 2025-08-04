// cap ssc install ivreg2, replace
// cap ssc install ranktest, replace

global main_path "/Users/leonardofancello/Dropbox"
global path_code "${main_path}/Democracy/Democracy_Main/MainAnalysis/code"
global path_data "${main_path}/Democracy/Democracy_Main/MainAnalysis/output/data"
global path_output "${main_path}/Democracy/Democracy_Main/MainAnalysis/output/tables/extensions"
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

drop if tax_burden2023==.
drop if corporate_tax_rate2023==.
drop if income_tax_rate2023==.
drop if sales_taxes2023==.

drop if democracy_vdem2020==.

drop if mean_temp_2011_2016==.

drop if total_gdp2022==.

************************************ 
************************************ Y: Tax Burden 2023

eststo clear 
forv i = 1/6{
		eststo: ivregress 2sls tax_burden2023 (democracy_vdem2020=${iv`i'})[w=total_gdp2022], vce(robust)
		eststo: ivregress 2sls tax_burden2023 abs_lat mean_temp_2011_2016 mean_precip_2011_2016 median_age2020 pop_density2020 (democracy_vdem2020=${iv`i'})[w=total_gdp2022], vce(robust)
	}

esttab using ${path_output}/old/2sls_tax_panel1.tex, ///
keep(democracy_vdem2020) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///
	
************************************ 
************************************ Y: Avg Corporate Tax Rate 2023

eststo clear 
forv i = 1/6{
		eststo: ivregress 2sls corporate_tax_rate2023 (democracy_vdem2020=${iv`i'})[w=total_gdp2022], vce(robust)
		eststo: ivregress 2sls corporate_tax_rate2023 abs_lat mean_temp_2011_2016 mean_precip_2011_2016 median_age2020 pop_density2020 (democracy_vdem2020=${iv`i'})[w=total_gdp2022], vce(robust)
	}
	

esttab using ${path_output}/old/2sls_tax_panel2.tex, ///
keep(democracy_vdem2020) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///

*********************************** 
************************************ Y: Avg Income Tax Rate 2023

eststo clear 
forv i = 1/6{
		eststo: ivregress 2sls income_tax_rate2023 (democracy_vdem2020=${iv`i'})[w=total_gdp2022], vce(robust)
		eststo: ivregress 2sls income_tax_rate2023 abs_lat mean_temp_2011_2016 mean_precip_2011_2016 median_age2020 pop_density2020 (democracy_vdem2020=${iv`i'})[w=total_gdp2022], vce(robust)
	}

	
esttab using ${path_output}/old/2sls_tax_panel3.tex, ///
keep(democracy_vdem2020) ///
replace label b(a1) se(a1) noobs nostar nodepvars nogaps nonotes mlabels(none) ///

*********************************** 
************************************ Y: Avg Sales Taxes 2023

eststo clear 
forv i = 1/6{
		eststo: ivregress 2sls sales_taxes2023 (democracy_vdem2020=${iv`i'})[w=total_gdp2022], vce(robust)
		eststo: ivregress 2sls sales_taxes2023 abs_lat mean_temp_2011_2016 mean_precip_2011_2016 median_age2020 pop_density2020 (democracy_vdem2020=${iv`i'})[w=total_gdp2022], vce(robust)
	}

	
esttab using ${path_output}/old/2sls_tax_panel4.tex, ///
keep(democracy_vdem2020) ///
replace label b(a1) se(a1) obslast nostar nodepvars nogaps nonotes mlabels(none) ///
prefoot(`" \hline \\[-1.8ex] IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs}  \\ Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark  & \xmark & \cmark\\"') stats(N, labels("N") fmt(0))

include "${path_code}/2_analyze/tables/PanelCombine_simple.do"
panelcombine, use(${path_output}/old/2sls_tax_panel1.tex ${path_output}/old/2sls_tax_panel2.tex ${path_output}/old/2sls_tax_panel3.tex ${path_output}/old/2sls_tax_panel4.tex) paneltitles("Tax Burden 2023" "Avg Corporate Tax Rate 2023" "Avg Income Tax Rate 2023" "Avg Sales Taxes 2023") columncount(13) save(${path_output}/old/2sls_tax_stats.tex) cleanup
