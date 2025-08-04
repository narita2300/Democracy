
********************************************************************************
***** 1. GENERATE DATA 
********************************************************************************
***** save the .csv V-Dem file as .dta so we can merge it with the V-Party dataset later  
 import delimited ${path_input}/democracy/Country_Year_V-Dem_Core_CSV_v11.1/V-Dem-CY-Core-v11.1.csv, clear 
keep if year>=1970

gen regime2000 = v2x_regime if year == 2000
bysort country_name: egen maxregime2000 = max(regime2000)
replace regime2000 = maxregime2000
drop maxregime2000

label define regime2000l 0 "Closed autocracies in 2000" 1 "Electoral autocracies in 2000" 2 "Electoral democracies in 2000" 3 "Liberal democracies in 2000"
label values regime2000 regime2000l

// gen democracy_vdem2000 = v2x_polyarchy if year == 2000
// bysort country_name: egen maxdemocracy_vdem2000 = max(democracy_vdem2000)
// replace democracy_vdem2000 = maxdemocracy_vdem2000
// drop maxdemocracy_vdem2000

// label variable democracy_vdem2000 "Democracy Index (V-Dem, 2000)"

save ${path_input}/democracy/Country_Year_V-Dem_Core_CSV_v11.1/vdem.dta, replace

********************************************************************************
***** make a dataset with the information on ruling parties 
use ${path_input}/populism/CPD_V-Party_Stata_v1/V-Dem-CPD-Party-V1.dta, clear
keep if v2pagovsup == 0
// if there are multiple ruling parties in one election, make the weighted illiberalism and populism score using the seat share 
// for each year-country group, make a seat-share-weighted populism score 
bysort year country_text_id: egen seatw_ruling_popul = wtmean(v2xpa_popul), weight(v2paseatshare)
bysort year country_text_id: egen seatw_ruling_illib = wtmean(v2xpa_illiberal), weight(v2paseatshare)
label variable seatw_ruling_popul "Ruling party's populism score"
label variable seatw_ruling_illib "Ruling party's illiberalism score"
duplicates drop year country_text_id, force
keep year country_text_id seatw_ruling_popul seatw_ruling_illib

save ${path_input}/populism/CPD_V-Party_Stata_v1/ruling.dta, replace

********************************************************************************
***** create national-vote-share-weighted average populism score across all the parties in each country *****
use ${path_input}/populism/CPD_V-Party_Stata_v1/V-Dem-CPD-Party-V1.dta, clear
keep if year >= 1970

***** merge the dataset with the V-Dem dataset to get the regime type of each country when the election takes place *****
merge m:1 country_text_id year using ${path_input}/democracy/Country_Year_V-Dem_Core_CSV_v11.1/vdem.dta, keep(match master) force

***** MAKE NATIONAL MEASURE OF POPULISM AND LIBERALISM *****
// for each year-country group, make a seat-share-weighted illiberalism and populism score 
bysort year country_text_id: egen seatw_popul = wtmean(v2xpa_popul), weight(v2paseatshare)
bysort year country_text_id: egen seatw_illib = wtmean(v2xpa_illiberal), weight(v2paseatshare)
label variable seatw_popul "Seat-share-weighted populism score"
label variable seatw_illib "Seat-share-weighted illiberalism score"

// for each year-country group, make a vote-share-weighted illiberalism and populism score 
 bysort year country_text_id: egen votew_popul = wtmean(v2xpa_popul), weight(v2pavote)
bysort year country_text_id: egen votew_illib = wtmean(v2xpa_illiberal), weight(v2pavote)
label variable votew_popul "Vote-share-weighted populism score"
label variable votew_illib "Vote-share-weighted illiberalism score"

***** MAKE THE DATASET BY COUNTRY-YEAR ****
duplicates drop year country_text_id, force
keep year country_text_id *w_popul *w_illib v2x_polyarchy regime2000
 
***** merge the dataset with the dataset on ruling parties (by country-year)*****
merge 1:1 country_text_id year using ${path_input}/populism/CPD_V-Party_Stata_v1/ruling.dta
keep if _merge==3
drop _merge

***** save data
save ${path_input}/populism/CPD_V-Party_Stata_v1/vparty_bycountryyear.dta, replace

********************************************************************************
***** make a dataset with observations by country for 2001-2019
***** load data
use ${path_input}/populism/CPD_V-Party_Stata_v1/vparty_bycountryyear.dta, clear

keep if year >=2001

***** MEAN IN 2001-19
// ruling parties
bysort country_text_id: egen mean_ruling_illib_2001_2019 = mean(seatw_ruling_illib)
bysort country_text_id: egen mean_ruling_popul_2001_2019 = mean(seatw_ruling_popul)
label variable  mean_ruling_illib_2001_2019 "Mean ruling party's illiberalism score in 2001-19"
label variable mean_ruling_popul_2001_2019 "Mean ruling party's populism score in 2001-19"

// seat-share-weighted
bysort country_text_id: egen mean_seatw_illib_2001_2019 = mean(seatw_illib)
bysort country_text_id: egen mean_seatw_popul_2001_2019 = mean(seatw_popul)
label variable mean_seatw_illib_2001_2019 "Mean seat-share-weighted illiberalism score in 2001-19"
label variable mean_seatw_popul_2001_2019 "Mean seat-share-weighted populism score in 2001-19"

// vote-share-weighted
bysort country_text_id: egen mean_votew_illib_2001_2019 = mean(votew_illib)
bysort country_text_id: egen mean_votew_popul_2001_2019 = mean(votew_popul)
label variable mean_votew_illib_2001_2019 "Mean vote-share-weighted illiberalism score in 2001-19"
label variable mean_votew_popul_2001_2019 "Mean vote-share-weighted populism score in 2001-19"

***** CHANGE IN 2001-19
sort country_text_id year

// ruling parties
bysort country_text_id: gen change_ruling_illib_2001_2019 = seatw_ruling_illib[_N] - seatw_ruling_illib[1]
bysort country_text_id: gen change_ruling_popul_2001_2019 = seatw_ruling_popul[_N] - seatw_ruling_popul[1]
label variable change_ruling_illib_2001_2019 "Change in ruling party's illiberalism score in 2001-19"
label variable change_ruling_popul_2001_2019 "Change in ruling party's populism score in 2001-19"

// seat-share-weighted 
bysort country_text_id: gen change_seatw_illib_2001_2019 = seatw_illib[_N] - seatw_illib[1]
bysort country_text_id: gen change_seatw_popul_2001_2019 = seatw_popul[_N] - seatw_popul[1]
label variable change_seatw_illib_2001_2019 "Change in seat-share-weighted illiberalism score in 2001-19"
label variable change_seatw_popul_2001_2019 "Change in seat-share-weighted populism score in 2001-19"

// vote-share-weighted 
bysort country_text_id: gen change_votew_illib_2001_2019 = votew_illib[_N] - seatw_illib[1]
bysort country_text_id: gen change_votew_popul_2001_2019 = votew_popul[_N] - seatw_popul[1]
label variable change_votew_illib_2001_2019 "Change in vote-share-weighted illiberalism score in 2001-19"
label variable change_votew_popul_2001_2019 "Change in vote-share-weighted populism score in 2001-19"

***** make observations by country (N=156, not 174 since we deleted observations for which v2pagovsup data is empty (ruling party is unclear))
duplicates drop country_text_id, force
drop year

***** merge the dataset with total.dta ****
rename country_text_id iso3
merge 1:1 iso3 using "/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta"
keep if _merge==3 // 応急処置
drop _merge 

***** normalize all the main outcome variables to have mean zero and standard deviation one across all countries in the sample
foreach var of varlist mean_ruling_illib_2001_2019 mean_seatw_illib_2001_2019 mean_votew_illib_2001_2019 change_ruling_illib_2001_2019 change_seatw_illib_2001_2019 change_votew_illib_2001_2019 mean_ruling_popul_2001_2019 mean_seatw_popul_2001_2019 mean_votew_popul_2001_2019 change_ruling_popul_2001_2019 change_seatw_popul_2001_2019 change_votew_popul_2001_2019 {
	local lab: variable label `var'
	di "`lab'"
	egen `var'_sd = std(`var')
	drop `var'
	rename `var'_sd `var'
	label variable `var' "`lab'"
}

***** save data
save ${path_input}/populism/CPD_V-Party_Stata_v1/vparty_bycountry.dta, replace

********************************************************************************
***** 2. DESCRIPTIVE STATISTICS
********************************************************************************
***** load the original dataset with observations by party-election 
use ${path_input}/populism/CPD_V-Party_Stata_v1/V-Dem-CPD-Party-V1.dta, clear
keep if year >= 1970

***** merge the dataset with the V-Dem dataset to get the regime type of each country when the election takes place *****
merge m:1 country_text_id year using ${path_input}/democracy/Country_Year_V-Dem_Core_CSV_v11.1/vdem.dta, keep(match master) force

***** Generate descriptive stats *****
*** Summary statistics for the whole sample ***
eststo clear
estpost tabstat v2xpa_illiberal v2xpa_popul v2paseatshare v2pavote, c(stat) stat(mean sd min p50 max n)
esttab using ${path_dropbox}/tables/appendix/descriptive_vparty.tex, ///
replace cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min p50 max count(fmt(%13.0fc))") nonumber ///
nomtitle noobs label collabels("Mean" "SD" "Min" "Median" "Max" "N")

*** Summary statistics for just ruling parties ***
eststo clear
estpost tabstat v2xpa_illiberal v2xpa_popul v2paseatshare v2pavote, c(stat) stat(mean sd min p50 max n), if v2pagovsup == 0 
esttab using ${path_dropbox}/tables/appendix/descriptive_vparty_ruling.tex, ///
cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min p50 max count(fmt(%13.0fc))") nonumber ///
nomtitle noobs label collabels("Mean" "SD" "Min" "Median" "Max" "N") replace

********************************************************************************
***** load data with observations by country-election
use ${path_input}/populism/CPD_V-Party_Stata_v1/vparty_bycountryyear.dta, clear

***** GENERATE DESCRIPTIVE STATS *****
eststo clear
estpost tabstat seatw_ruling_illib seatw_illib votew_illib seatw_ruling_popul seatw_popul votew_popul, c(stat) stat(mean sd min p50 max n)

esttab using ${path_dropbox}/tables/appendix/descriptive_vparty_bycountry.tex, ///
cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min p50 max count(fmt(%13.0fc))") nonumber ///
nomtitle noobs label collabels("Mean" "SD" "Min" "Median" "Max" "N") replace
 
********************************************************************************
use ${path_input}/populism/CPD_V-Party_Stata_v1/vparty_bycountry.dta, clear

*** Summary statistics 
eststo clear
estpost tabstat mean_ruling_illib_2001_2019 mean_seatw_illib_2001_2019 mean_votew_illib_2001_2019 change_ruling_illib_2001_2019 change_seatw_illib_2001_2019 change_votew_illib_2001_2019 mean_ruling_popul_2001_2019 mean_seatw_popul_2001_2019 mean_votew_popul_2001_2019 change_ruling_popul_2001_2019 change_seatw_popul_2001_2019 change_votew_popul_2001_2019, c(stat) stat(mean sd min p50 max n)
esttab using ${path_dropbox}/tables/appendix/descriptive_vparty_mainoutcomes.tex, ///
replace cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min p50 max count(fmt(%13.0fc))") nonumber ///
nomtitle noobs label collabels("Mean" "SD" "Min" "Median" "Max" "N")

********************************************************************************
***** 3. TIMESERIES TRENDS
********************************************************************************
use ${path_input}/populism/CPD_V-Party_Stata_v1/vparty_bycountryyear.dta, clear

***** RULING PARTIES 
*** GLOBAL TREND
// binscatter v2smpolsoc year, ytitle("Societal agreement on key political issues") savegraph(${path_dropbox}/figures/timeseries_v2smpolsoc_binned.png) replace
binscatter seatw_ruling_illib year, ytitle("Illiberalism score of ruling parties") savegraph(${path_dropbox}/figures/timeseries_illiberalism_binned.png) replace
binscatter seatw_ruling_popul year, ytitle("Populism score of ruling parties") savegraph(${path_dropbox}/figures/timeseries_populism_binned.png) replace

*** TREND BY REGIME TYPE IN 2000
binscatter seatw_ruling_illib year, ytitle("Illiberalism score of ruling parties") by(regime2000) legend(lab(1 "Closed autocracies") lab(2 "Electoral autocracies") lab(3 "Electoral democracies") lab(4 "Liberal democracies")) savegraph(${path_dropbox}/figures/timeseries_illiberalism_binned_byregime.png) replace
binscatter seatw_ruling_popul year, ytitle("Populism score of ruling parties") by(regime2000) legend(lab(1 "Closed autocracies") lab(2 "Electoral autocracies") lab(3 "Electoral democracies") lab(4 "Liberal democracies")) savegraph(${path_dropbox}/figures/timeseries_populism_binned_byregime.png) replace

***** SEAT-SHARE-WEIGHTED SCORES
*** GLOBAL TREND
binscatter seatw_illib year, ytitle("Seat-share-weighted illiberalism score") savegraph(${path_dropbox}/figures/timeseries_seatw_illib_binned.png) replace
binscatter seatw_popul year, ytitle("Seat-share-weighted populism score") savegraph(${path_dropbox}/figures/timeseries_seatw_popul_binned.png) replace

*** TREND BY REGIME TYPE IN 2000 ***
binscatter seatw_illib year, ytitle("Seat-share-weighted illiberalism score") by(regime2000) legend(lab(1 "Closed autocracies") lab(2 "Electoral autocracies") lab(3 "Electoral democracies") lab(4 "Liberal democracies")) savegraph(${path_dropbox}/figures/timeseries_seatw_illib_binned_byregime.png) replace
binscatter seatw_popul year, ytitle("Seat-share-weighted populism score") by(regime2000) legend(lab(1 "Closed autocracies") lab(2 "Electoral autocracies") lab(3 "Electoral democracies") lab(4 "Liberal democracies")) savegraph(${path_dropbox}/figures/timeseries_seatw_popul_binned_byregime.png) replace

***** VOTE-SHARE-WEIGHTED SCORES
use ${path_input}/populism/CPD_V-Party_Stata_v1/vparty_bycountryyear.dta, clear

*** GLOBAL TREND
binscatter votew_illib year, ytitle("Vote-share-weighted illiberalism score") savegraph(${path_dropbox}/figures/timeseries_votew_illib_binned.png) replace
binscatter votew_popul year, ytitle("Vote-share-weighted populism score") savegraph(${path_dropbox}/figures/timeseries_votew_popul_binned.png) replace

*** TREND BY REGIME TYPE IN 2000 ***
binscatter votew_illib year, ytitle("Vote-share-weighted illiberalism score") by(regime2000) legend(lab(1 "Closed autocracies") lab(2 "Electoral autocracies") lab(3 "Electoral democracies") lab(4 "Liberal democracies")) savegraph(${path_dropbox}/figures/timeseries_votew_illib_binned_byregime.png) replace
binscatter votew_popul year, ytitle("Vote-share-weighted populism score") by(regime2000) legend(lab(1 "Closed autocracies") lab(2 "Electoral autocracies") lab(3 "Electoral democracies") lab(4 "Liberal democracies")) savegraph(${path_dropbox}/figures/timeseries_votew_popul_binned_byregime.png) replace

********************************************************************************
***** 4. OLS RELATIONSHIP WITH DEMOCRACY LEVELS IN 2000
********************************************************************************
***** relationship between democracy and illiberalism and populism in 2001-2019 (each row is by country-election) ****
use ${path_input}/populism/CPD_V-Party_Stata_v1/vparty_bycountry.dta, clear

***** LEVELS
/// X: democracy level in 2000
/// Y: mean illiberalism in 2001-2019
binscatter mean_ruling_illib_2001_2019 democracy_vdem2000, ytitle("Mean illiberalism score of ruling parties in 2001-19") xtitle("Democracy Index (V-Dem, 2000)")savegraph(${path_dropbox}/figures/democracy_illiberalism_binned_ruling.png) replace
binscatter mean_seatw_illib_2001_2019 democracy_vdem2000, ytitle("Mean seat-share-weighted illiberalism score in 2001-19") xtitle("Democracy Index (V-Dem, 2000)")savegraph(${path_dropbox}/figures/democracy_seatw_illiberalism_binned.png) replace
binscatter mean_votew_illib_2001_2019 democracy_vdem2000, ytitle("Mean vote-share-weighted illiberalism score in 2001-19") xtitle("Democracy Index (V-Dem, 2000)") savegraph(${path_dropbox}/figures/democracy_votew_illiberalism_binned.png) replace


/// X: democracy level in 2000
/// Y: mean populism in 2001-2019
binscatter mean_ruling_popul_2001_2019 democracy_vdem2000, ytitle("Mean populism score of ruling parties in 2001-19") xtitle("Democracy Index (V-Dem, 2000)")savegraph(${path_dropbox}/figures/democracy_populism_binned_ruling.png) replace
binscatter mean_seatw_popul_2001_2019 democracy_vdem2000, ytitle("Mean seat-share-weighted opulism score in 2001-19") xtitle("Democracy Index (V-Dem, 2000)")savegraph(${path_dropbox}/figures/democracy_seatw_populism_binned.png) replace
binscatter mean_votew_popul_2001_2019 democracy_vdem2000, ytitle("Mean vote-share-weighted populism score in 2001-19") xtitle("Democracy Index (V-Dem, 2000)") savegraph(${path_dropbox}/figures/democracy_votew_populism_binned.png) replace

***** CHANGES 
// X: democracy level in 2000
// Y: change in illiberalism in 2001-2019
binscatter change_ruling_illib_2001_2019 democracy_vdem2000, ytitle("Change in illiberalism score in 2001-19") xtitle("Democracy Index (V-Dem, 2000)") savegraph(${path_dropbox}/figures/democracy_change_illiberalism_2001_2019_binned_ruling.png) replace
binscatter change_seatw_illib_2001_2019 democracy_vdem2000, ytitle("Change in seat-share-weighted illiberalism score in 2001-19") xtitle("Democracy Index (V-Dem, 2000)") savegraph(${path_dropbox}/figures/democracy_change_seatw_illiberalism_2001_2019_binned.png) replace
binscatter change_votew_illib_2001_2019 democracy_vdem2000, ytitle("Change in vote-share-weighted illiberalism score in 2001-19") xtitle("Democracy Index (V-Dem, 2000)") savegraph(${path_dropbox}/figures/democracy_change_votew_illiberalism_2001_2019_binned.png) replace

// X: democracy level in 2000
// Y: change in populism in 2001-2019
binscatter change_ruling_popul_2001_2019 democracy_vdem2000, ytitle("Change in populism score in 2001-19") xtitle("Democracy Index (V-Dem, 2000)") savegraph(${path_dropbox}/figures/democracy_change_populism_2001_2019_binned_ruling.png) replace
binscatter change_seatw_popul_2001_2019 democracy_vdem2000, ytitle("Change in seat-share-weighted populism score in 2001-19") xtitle("Democracy Index (V-Dem, 2000)") savegraph(${path_dropbox}/figures/democracy_change_seatw_populism_2001_2019_binned.png) replace
binscatter change_votew_popul_2001_2019 democracy_vdem2000, ytitle("Change in vote-share-weighted populism score in 2001-19") xtitle("Democracy Index (V-Dem, 2000)") savegraph(${path_dropbox}/figures/democracy_change_votew_populism_2001_2019_binned.png) replace

***** SUMMARY OLS TABLES
 
// Illiberalism, levels 
est clear
foreach var of varlist mean_ruling_illib_2001_2019 mean_seatw_illib_2001_2019 mean_votew_illib_2001_2019 {
	eststo: reg `var' democracy_vdem2000, robust
	eststo: reg `var' democracy_vdem2000 [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/ols_democracy_illiberalism_level.tex, replace b(3) se(3) label noconstant stats(N, labels("N") fmt(0)) drop(_cons) nonotes nomtitle prefoot("GDP-weighted? & N & Y & N & Y & N & Y \\") posthead("&\multicolumn{2}{c}{\shortstack{Ruling parties; \\ mean in 2001-19}} & \multicolumn{2}{c}{\shortstack{Seat-share-weighted; \\ mean in 2001-19}} & \multicolumn{2}{c}{\shortstack{Vote-share-weighted; \\ mean in 2001-19}} \\") 

// Illiberalism, changes 
est clear
foreach var of varlist change_ruling_illib_2001_2019 change_seatw_illib_2001_2019 change_votew_illib_2001_2019 {
	eststo: reg `var' democracy_vdem2000, robust
	eststo: reg `var' democracy_vdem2000 [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/ols_democracy_illiberalism_change.tex, replace b(3) se(3) label noconstant stats(N, labels("N") fmt(0)) drop(_cons) nonotes nomtitle prefoot("GDP-weighted? & N & Y & N & Y & N & Y \\") posthead("&\multicolumn{2}{c}{\shortstack{Ruling parties; \\ change in 2001-19}} & \multicolumn{2}{c}{\shortstack{Seat-share-weighted; \\ change in 2001-19}} & \multicolumn{2}{c}{\shortstack{Vote-share-weighted; \\ change in 2001-19}} \\") 

// Populism
est clear
foreach var of varlist mean_ruling_popul_2001_2019 mean_seatw_popul_2001_2019 mean_votew_popul_2001_2019{
	eststo: reg `var' democracy_vdem2000, robust
	eststo: reg `var' democracy_vdem2000 [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/ols_democracy_populism_level.tex, replace b(3) se(3) label noconstant stats(N, labels("N") fmt(0)) drop(_cons) nonotes nomtitle prefoot("GDP-weighted? & N & Y & N & Y & N & Y \\") posthead("&\multicolumn{2}{c}{\shortstack{Ruling parties; \\ mean in 2001-19}} & \multicolumn{2}{c}{\shortstack{Seat-share-weighted; \\ mean in 2001-19}} & \multicolumn{2}{c}{\shortstack{Vote-share-weighted; \\ mean in 2001-19}} \\") 

est clear
foreach var of varlist change_ruling_popul_2001_2019 change_seatw_popul_2001_2019 change_votew_popul_2001_2019{
	eststo: reg `var' democracy_vdem2000, robust
	eststo: reg `var' democracy_vdem2000 [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/ols_democracy_populism_change.tex, replace b(3) se(3) label noconstant stats(N, labels("N") fmt(0)) drop(_cons) nonotes nomtitle prefoot("GDP-weighted? & N & Y & N & Y & N & Y\\") posthead("&\multicolumn{2}{c}{\shortstack{Ruling parties; \\ change in 2001-19}} & \multicolumn{2}{c}{\shortstack{Seat-share-weighted; \\ change in 2001-19}} & \multicolumn{2}{c}{\shortstack{Vote-share-weighted; \\ change in 2001-19}} \\") 

********************************************************************************
***** 5. 2SLS RELATIONSHIP WITH DEMOCRACY LEVELS IN 2000
********************************************************************************

// Y: change_ruling_illib_2001_2019
est clear
forvalues i = 1/6{
	eststo: ivreg2 change_ruling_illib_2001_2019 (democracy_vdem2000=${iv`i'})  [w=total_gdp2000], robust
	eststo: ivreg2 change_ruling_illib_2001_2019 (democracy_vdem2000=${iv`i'})  ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_change_ruling_illib_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(democracy_vdem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

// Y: change_seatw_illib_2001_2019
est clear
forvalues i = 1/6{
	eststo: ivreg2 change_seatw_illib_2001_2019 (democracy_vdem2000=${iv`i'})  [w=total_gdp2000], robust
	eststo: ivreg2 change_seatw_illib_2001_2019 (democracy_vdem2000=${iv`i'})  ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_change_seatw_illib_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(democracy_vdem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

// Y: change_votew_illib_2001_2019
est clear
forvalues i = 1/6{
	eststo: ivreg2 change_votew_illib_2001_2019 (democracy_vdem2000=${iv`i'})  [w=total_gdp2000], robust
	eststo: ivreg2 change_votew_illib_2001_2019 (democracy_vdem2000=${iv`i'})  ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_change_votew_illib_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(democracy_vdem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

// Y: change_ruling_popul_2001_2019
est clear
forvalues i = 1/6{
	eststo: ivreg2 change_ruling_popul_2001_2019 (democracy_vdem2000=${iv`i'})  [w=total_gdp2000], robust
	eststo: ivreg2 change_ruling_popul_2001_2019 (democracy_vdem2000=${iv`i'})  ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_change_ruling_popul_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(democracy_vdem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

// Y: change_seatw_popul_2001_2019
est clear
forvalues i = 1/6{
	eststo: ivreg2 change_seatw_popul_2001_2019 (democracy_vdem2000=${iv`i'})  [w=total_gdp2000], robust
	eststo: ivreg2 change_seatw_popul_2001_2019 (democracy_vdem2000=${iv`i'})  ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_change_seatw_popul_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(democracy_vdem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

// Y: change_votew_popul_2001_2019
est clear
forvalues i = 1/6{
	eststo: ivreg2 change_votew_popul_2001_2019 (democracy_vdem2000=${iv`i'})  [w=total_gdp2000], robust
	eststo: ivreg2 change_votew_popul_2001_2019 (democracy_vdem2000=${iv`i'})  ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_change_votew_popul_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(democracy_vdem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 
