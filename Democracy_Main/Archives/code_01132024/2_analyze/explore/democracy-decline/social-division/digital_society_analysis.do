
use "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/channels21st/digital-society-project/DigitalSocietyProject-v3-STATA/DSP-Dataset-v3.dta", clear

// rename country_text_id iso3
keep country_text_id year v2smmefra v2smpolsoc v2smpolhate 

***** merge the dataset with the V-Dem dataset to get the regime type of each country when the election takes place *****
merge m:1 country_text_id year using "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/democracy/Country_Year_V-Dem_Core_CSV_v11.1/vdem_simple.dta",keep(match master) force nogenerate

***** merge the dataset with total.dta to get the total GDP in 2000
rename country_text_id iso3
merge m:1 iso3 using "/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta"

drop if country_text_id ==""
keep if year >2000 
keep if year <2020

***** standardize the key variables across time and countries 
egen v2smmefra_sd = std(v2smmefra)
egen v2smpolsoc_sd = std(v2smpolsoc)
egen v2smpolhate_sd = std(v2smpolhate)

*****
drop v2smmefra v2smpolsoc v2smpolhate 
rename v2smmefra_sd v2smmefra
rename v2smpolsoc_sd v2smpolsoc
rename v2smpolhate_sd v2smpolhate

*****
label variable v2smpolsoc "Societal agreement on key political issues"
label variable v2smpolhate "Political parties' abstention from hate speech"
label variable v2smmefra "Similar presentation of events online"

*****
save "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/channels21st/digital-society-project/DigitalSocietyProject-v3-STATA/DSP-Dataset-temp.dta", replace

************************************************************************
// generate descriptive stats 
codebook v2smpolhate v2smpolsoc v2smmefra

*** Summary statistics for the whole sample ***
eststo clear
estpost tabstat v2smpolsoc v2smpolhate v2smmefra, c(stat) stat(mean sd min p50 max n)

esttab using ${path_dropbox}/tables/appendix/descriptive_digital.tex, ///
replace cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min p50 max count(fmt(%13.0fc))") nonumber ///
nomtitle noobs label collabels("Mean" "SD" "Min" "Median" "Max" "N") 

********************************************************************************
*** GLOBAL TREND
binscatter v2smpolsoc year, ytitle("Societal agreement on key political issues") savegraph(${path_dropbox}/figures/timeseries_v2smpolsoc_binned.png) replace
binscatter v2smpolhate year, ytitle("Political parties' abstention from hate speech") savegraph(${path_dropbox}/figures/timeseries_v2smpolhate_binned.png) replace
binscatter v2smmefra year, ytitle("Similar presentation of events online") savegraph(${path_dropbox}/figures/timeseries_v2smmefra_binned.png) replace

********************************************************************************
*** MAKE DATA BY-COUNTRY
use "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/channels21st/digital-society-project/DigitalSocietyProject-v3-STATA/DSP-Dataset-temp.dta", clear

keep if year > 2000 & year <=2019
// generate necessary variables and make dataset by-country
local n = 1
// local varname ftti atariffs airevenue ao aiitariff aw aiiisd as bregtrade binontariff bicostimport cblackmarket dcontrolmove difinopen diicapcontrol
foreach var of varlist v2smpolsoc v2smpolhate v2smmefra{
	sum `var'
	sort iso3 year
	bysort iso3: gen change_`var' = `var'[_N] - `var'[1]
	bysort iso3: egen mean_`var' = mean(`var')
	local n = `n' + 1
}

// keep iso3 change* mean* regime2000 dem2000 total_gdp2000
duplicates drop iso3, force

// normalize the democracy variable to have mean zero and standard deviation one
egen dem2000_sd = std(dem2000)
replace dem2000 = dem2000_sd

save "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/channels21st/digital-society-project/DigitalSocietyProject-v3-STATA/DSP-Dataset-bycountry.dta", replace

******************************************************************************** OLS
use "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/channels21st/digital-society-project/DigitalSocietyProject-v3-STATA/DSP-Dataset-bycountry.dta", clear 

*** OLS: DEMOCRACY AND POLARIZATION
// levels
binscatter mean_v2smpolsoc dem2000, ytitle("Societal agreement on key political issues") xtitle("Democracy Index (V-Dem, 2000)") savegraph(${path_dropbox}/figures/dem2000_mean_v2smpolsoc_binned.png) replace

binscatter mean_v2smpolhate dem2000, ytitle("Political parties' abstention from hate speech in 2001-2020") xtitle("Democracy Index (V-Dem, 2000)") savegraph(${path_dropbox}/figures/dem2000_mean_v2smpolhate_binned.png) replace

binscatter mean_v2smmefra dem2000, ytitle("Similar presentation of events online") xtitle("Democracy Index (V-Dem, 2000)") savegraph(${path_dropbox}/figures/dem2000_mean_v2smmefra_binned.png) replace

// changes in 2001-2019
binscatter change_v2smpolsoc dem2000, ytitle("Change in Societal agreement on key political issues index") xtitle("Democracy Index (V-Dem, 2000)") savegraph(${path_dropbox}/figures/dem2000_change_v2smpolsoc_binned.png) replace

binscatter change_v2smpolhate dem2000, ytitle("Change in Political parties' abstention from hate speech index") xtitle("Democracy Index (V-Dem, 2000)") savegraph(${path_dropbox}/figures/dem2000_change_v2smpolhate_binned.png) replace

binscatter change_v2smmefra dem2000, ytitle("Change in Similar presentation of events online index") xtitle("Democracy Index (V-Dem, 2000)") savegraph(${path_dropbox}/figures/dem2000_change_v2smmefra_binned.png) replace

*** generate OLS tables 

est clear
foreach var of varlist v2smpolsoc v2smpolhate v2smmefra{
eststo: reg change_`var' dem2000, robust
eststo: reg change_`var' dem2000 [w=total_gdp2000], robust
}

esttab using ${path_dropbox}/tables/appendix/ols_democracy_change_digital.tex, replace b(3) se(3) label noconstant stats(N, labels("N") fmt(0)) drop(_cons) nonotes nomtitle posthead("&\multicolumn{2}{c}{\shortstack{Societal agreement on key \\political issues}} & \multicolumn{2}{c}{\shortstack{Political parties' abstention from\\ hate speech}} & \multicolumn{2}{c}{\shortstack{Similar presentation\\ of political events online}} \\") prefoot("GDP-weighted? & N & Y & N & Y & N & Y\\")

******************************************************************************** 2SLS

use "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/channels21st/digital-society-project/DigitalSocietyProject-v3-STATA/DSP-Dataset-bycountry.dta", clear 

foreach var of varlist v2smpolsoc v2smpolhate v2smmefra{
est clear
	forvalues i = 1/6{
		eststo: ivreg2 change_`var' (dem2000=${iv`i'}) [w=total_gdp2000], robust
		eststo: ivreg2 change_`var' (dem2000=${iv`i'})  ${base_covariates2000} [w=total_gdp2000], robust
	}

	esttab using ${path_dropbox}/tables/appendix/2sls_change_`var'.tex, replace b(2) se(2) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(dem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 
}
