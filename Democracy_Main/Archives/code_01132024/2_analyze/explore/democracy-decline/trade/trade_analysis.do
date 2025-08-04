********************************************************************************
********************************************************************************

import excel ${path_input}/channels21st/protectionism/economic-freedom-of-the-world-2021-master-index-data-for-researchers-iso.xlsx, sheet("EFW Data 2021 Report") cellrange(B5:BV4297) firstrow case(lower) clear

rename iso_code_3 country_text_id

***** merge the dataset with the V-Dem dataset to get the regime type of each country when the election takes place *****
merge m:1 country_text_id year using "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/democracy/Country_Year_V-Dem_Core_CSV_v11.1/vdem_simple.dta",keep(match master) force nogenerate

drop if year ==.

***** merge the dataset with total.dta to get the total GDP in 2000
rename country_text_id iso3
merge m:1 iso3 using "/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta"
drop if _merge!=3

***** standardize variables to have mean zero and standard deviation one in 1970-2019 period
foreach var of varlist freedomtotradeinternationa atariffs airevenuefromtradetaxes ao aiimeantariffrate aq aiiistandarddeviationoftar as bregulatorytradebarriers binontarifftradebarriers biicompliancecostsofimport cblackmarketexchangerates dcontrolsofthemovementof difinancialopenness diicapitalcontrols diiifreedomofforeignerstov {
	local lab: variable label `var'
	di "`lab'"
	egen `var'_sd = std(`var')
	drop `var'
	rename `var'_sd `var'
	label variable `var' "`lab'"
}

label variable airevenuefromtradetaxes "4Ai  Revenue from trade taxes (\% of trade sector)"

***** save the data covering 1970-2019 for now
save "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/channels21st/protectionism/econfreedom_1970_2019.dta", replace

// ***** Which country experienced the largest growth between 1985-1995? 
// use "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/channels21st/protectionism/econfreedom_1970_2019.dta", clear
// keep if year == 1975 | year == 1990
// sort iso3 year
// bysort iso3: gen change_ftti_75_90 = freedomtotradeinternationa[_N] - freedomtotradeinternationa[1]

// drop if change_ftti_75_90==.
// duplicates drop iso3, force
// drop freedomtotradeinternation
// sort change_ftti_75_90
// keep iso3 countries change_ftti_75_90

***** GLOBAL TREND OVER TIME
use "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/channels21st/protectionism/econfreedom_1970_2019.dta", clear

/// X: year
/// Y: freedom to trade internationally index 
binscatter freedomtotradeinternationa year, ytitle("Freedom to trade internationally index ") savegraph(${path_dropbox}/figures/timeseries_inttrade_binned.png) replace
// Look at the global trend in each of the major components: 
// 4A. tariffs: atariffs
binscatter atariffs year, ytitle("Tariffs index") savegraph(${path_dropbox}/figures/timeseries_atariffs_binned.png) replace
// 4B. regulatory trade barriers: bregulatorytradebarriers
binscatter bregulatorytradebarriers year, ytitle("Regulatory trade barriers index") savegraph(${path_dropbox}/figures/timeseries_bregulatorytradebarriers_binned.png) replace
// 4C. black market exchange rates: cblackmarketexchangerates
binscatter cblackmarketexchangerates year, ytitle("Black market exchange rates index") savegraph(${path_dropbox}/figures/timeseries_cblackmarketexchangerates_binned.png) replace
// 4D. controls for the movement of capital and people: dcontrolsofthemovementof
binscatter dcontrolsofthemovementof year, ytitle("Controls for the movement of capital and people") savegraph(${path_dropbox}/figures/timeseries_dcontrolsofthemovementof_binned.png) replace

/// X: year
/// Y: revenue from trade taxes
binscatter ao year, ytitle("% taxed of trade sector") savegraph(${path_dropbox}/figures/timeseries_tradetaxrevenue_binned.png) replace
/// X: year 
/// Y: mean tariff rates
binscatter aq year, ytitle("Mean tariff rates") savegraph(${path_dropbox}/figures/timeseries_meantariffrate_binned.png) replace

***** Generate summary statistics
eststo clear
estpost tabstat freedomtotradeinternationa atariffs airevenuefromtradetaxes aiimeantariffrate aiiistandarddeviationoftar bregulatorytradebarriers binontarifftradebarriers biicompliancecostsofimport cblackmarketexchangerates dcontrolsofthemovementof difinancialopenness diicapitalcontrols diiifreedomofforeignerstov ///
, c(stat) stat(mean sd min p50 max n)

esttab using ${path_dropbox}/tables/appendix/descriptive_fraser.tex, ///
replace cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min p50 max count(fmt(%13.0fc))") nonumber ///
nomtitle noobs label collabels("Mean" "SD" "Min" "Median" "Max" "N") 

********************************************************************************
********************************************************************************
use "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/channels21st/protectionism/econfreedom_1970_2019.dta", clear

***** KEEP ONLY OBSERVATIONS IN 2001-19 PERIOD
keep if year > 2000 & year <=2019

*** currently the observations are by country-year 
*** make observations by country-index 
keep freedomtotradeinternationa atariffs airevenuefromtradetaxes ao aiimeantariffrate aq aiiistandarddeviationoftar as ///
bregulatorytradebarriers binontarifftradebarriers biicompliancecostsofimport ///
cblackmarketexchangerates ///
dcontrolsofthemovementof difinancialopenness diicapitalcontrols diiifreedomofforeignerstov dem2000 regime2000 total_gdp2000 iso3 year ${iv6} ${base_covariates2000} 

*** RE-standardize variables in 1970-2019 period
foreach var of varlist freedomtotradeinternationa atariffs airevenuefromtradetaxes ao aiimeantariffrate aq aiiistandarddeviationoftar as bregulatorytradebarriers binontarifftradebarriers biicompliancecostsofimport cblackmarketexchangerates dcontrolsofthemovementof difinancialopenness diicapitalcontrols diiifreedomofforeignerstov {
	local lab: variable label `var'
	di "`lab'"
	egen `var'_sd = std(`var')
	drop `var'
	rename `var'_sd `var'
	label variable `var' "`lab'"
}

local n = 1
local varname ftti atariffs airevenue ao aiitariff aw aiiisd as bregtrade binontariff bicostimport cblackmarket dcontrolmove difinopen diicapcontrol
foreach var of varlist freedomtotradeinternationa atariffs airevenuefromtradetaxes ao aiimeantariffrate aq aiiistandarddeviationoftar as bregulatorytradebarriers binontarifftradebarriers biicompliancecostsofimport cblackmarketexchangerates dcontrolsofthemovementof difinancialopenness diicapitalcontrols{
	sum `var'
	local name: word `n' of `varname'
	di "`name'"
	sort iso3 year
	bysort iso3: gen change_`name' = `var'[_N] - `var'[1]
	bysort iso3: egen mean_`name' = mean(`var')
	local n = `n' + 1
}

duplicates drop iso3, force

 save "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/channels21st/protectionism/econfreedom_bycountry.dta", replace
 
********************************************************************************
 use "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/channels21st/protectionism/econfreedom_bycountry.dta", clear
 
egen dem2000_std = std(dem2000)
replace dem2000 = dem2000_std

local titles `" "Freedom to trade internationally index"  "Tariffs index " "Tax revenue from trade index "  "Tax revenue from trade (\% of trade sector)" "Mean tariff rate index " "Mean tariff rate (\%)" "Reglulatory trade barriers index " "Regulatory trade barriers index " "Non-tariff trade barriers index " "Complicance costs of importing and exporting index "  "Black market exchange rates index "  "Controls of the movement of capital and people index " "Financial openness index " "Capital controls index " "Freedom of foreigners to visit index ""'
local n = 1
foreach var in ftti atariffs airevenue ao aiitariff aw aiiisd as bregtrade binontariff bicostimport cblackmarket dcontrolmove difinopen diicapcontrol{
	local title: word `n' of `titles'	
	binscatter change_`var' dem2000, ytitle("Change in 2001-2019 in" "`title'") xtitle("Democracy Index (V-Dem, 2000)") savegraph(${path_dropbox}/figures/democracy_change_`var'_binned.png) replace
	local n = `n' + 1
}

***** generate OLS tables 
// Y: Freedom to trade internationally index (levels & changes)
est clear
// Column 1 & 2: mean levels of the freedom to trade internationally index in 2001-2019
eststo: reg mean_ftti dem2000, robust
eststo: reg mean_ftti dem2000 [w=total_gdp2000], robust
// Column 3 & 4: changes in the freedom to trade internationally index in 2001-2019
eststo: reg change_ftti dem2000, robust
eststo: reg change_ftti dem2000 [w=total_gdp2000], robust

esttab using ${path_dropbox}/tables/appendix/ols_democracy_ftti.tex, replace b(3) se(3) label noconstant stats(N, labels("N") fmt(0)) drop(_cons) mtitles("Levels, unweighted" "Levels, GDP-weighted" "Changes, unweighted" "Changes, GDP-weighted") nonotes

***** generate 2SLS tables 
est clear
forvalues i = 1/6{
	eststo: ivreg2 change_ftti (dem2000=${iv`i'}) [w=total_gdp2000], robust
	eststo: ivreg2 change_ftti (dem2000=${iv`i'})  ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_change_ftti.tex, replace b(2) se(2) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(dem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

