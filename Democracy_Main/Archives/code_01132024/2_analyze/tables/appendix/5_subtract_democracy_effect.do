********************************************************************************
* Table : Comparison by continent
********************************************************************************

clear

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
// use "/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/total.dta", replace
use ${path_data}/total.dta, replace

ivregress 2sls ${outcome2} (${dem2019}=${iv1})${weight2019}, vce(robust)
matrix list e(b)
gen coef1 = e(b)[1,1]

ivregress 2sls ${outcome1} (${dem2000}=${iv1})${weight2000}, vce(robust)
matrix list e(b)
gen coef2 = e(b)[1,1]


ivregress 2sls total_deaths_per_million (${dem2019}=${iv1})${weight2019}, vce(robust)

matrix list e(b)
gen coef3 = e(b)[1,1]

label variable ${outcome2} "\hspace{3mm} Observed Mean"
label variable ${outcome1} "\hspace{3mm} Observed Mean"
label variable total_deaths_per_million "\hspace{3mm} Observed Mean"

replace continent="N. America" if continent=="North America"
replace continent="S. America" if continent=="South America"

gen dem_effect_gdp_2020 = ${dem2019} * coef1
label variable dem_effect_gdp_2020 "\hspace{3mm} Political Regimes' Effect"

gen dem_effect_gdp_2001_2019 = ${dem2000} * coef2
label variable dem_effect_gdp_2001_2019 "\hspace{3mm} Political Regimes' Effect"

gen dem_effect_deaths = ${dem2019} * coef3
label variable dem_effect_deaths "\hspace{3mm} Political Regimes' Effect"

gen no_dem_gdp_2020 = ${outcome2} - dem_effect_gdp_2020
label variable no_dem_gdp_2020 "\hspace{3mm} (Observed Mean) - (Political Regimes' Effect)"

gen no_dem_gdp_2001_2019 = ${outcome1} - dem_effect_gdp_2001_2019
label variable no_dem_gdp_2001_2019 "\hspace{3mm} (Observed Mean) - (Political Regimes' Effect)"

gen no_dem_deaths = total_deaths_per_million - dem_effect_deaths
label variable no_dem_deaths "\hspace{3mm} (Observed Mean) - (Political Regimes' Effect)"

eststo clear
bysort continent: eststo: quietly estpost summarize ${outcome1} dem_effect_gdp_2001_2019 no_dem_gdp_2001_2019 
esttab using ${path_appendix}/5_subtract_democracy_effect_panel1.tex, cells("mean(fmt(1))") label collabels(none) replace nodepvars nogaps nonotes noobs
include "${path_code}/2_analyze/tables/PanelCombine_simplest.do"
panelcombine, use(${path_appendix}/5_subtract_democracy_effect_panel1.tex) paneltitles("") columncount(11) save(${path_appendix}/5_subtract_democracy_effect_panelA.tex) cleanup

eststo clear
bysort continent: eststo: quietly estpost summarize ${outcome2} dem_effect_gdp_2020 no_dem_gdp_2020
esttab using ${path_appendix}/5_subtract_democracy_effect_panel2.tex, cells("mean(fmt(1))") label collabels(none) replace nodepvars nogaps nonotes noobs
include "${path_code}/2_analyze/tables/PanelCombine_simplest.do"
panelcombine, use(${path_appendix}/5_subtract_democracy_effect_panel2.tex) paneltitles("") columncount(11) save(${path_appendix}/5_subtract_democracy_effect_panelB.tex) cleanup


eststo clear
bysort continent: eststo: quietly estpost summarize total_deaths_per_million  dem_effect_deaths no_dem_deaths
esttab using ${path_appendix}/5_subtract_democracy_effect_panel3.tex, cells("mean(fmt(1))") stats(N, fmt(0) labels("N")) label collabels(none) replace nodepvars nogaps nonotes
include "${path_code}/2_analyze/tables/PanelCombine_simplest.do"
panelcombine, use(${path_appendix}/5_subtract_democracy_effect_panel3.tex) paneltitles("") columncount(11) save(${path_appendix}/5_subtract_democracy_effect_panelC.tex) cleanup

	


