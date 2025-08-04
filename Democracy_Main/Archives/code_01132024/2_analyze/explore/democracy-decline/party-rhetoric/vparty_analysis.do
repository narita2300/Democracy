
***** save the .csv V-Dem file as .dta so we can merge it with the V-Party dataset later  
 import delimited "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/democracy/Country_Year_V-Dem_Core_CSV_v11.1/V-Dem-CY-Core-v11.1.csv", clear 
keep if year>=1970

gen regime2000 = v2x_regime if year == 2000
bysort country_name: egen maxregime2000 = max(regime2000)
replace regime2000 = maxregime2000
drop maxregime2000

label define regime2000l 0 "Closed autocracies in 2000" 1 "Electoral autocracies in 2000" 2 "Electoral democracies in 2000" 3 "Liberal democracies in 2000"
label values regime2000 regime2000l

gen dem2000 = v2x_polyarchy if year == 2000
bysort country_name: egen maxdem2000 = max(dem2000)
replace dem2000 = maxdem2000
drop maxdem2000

label variable dem2000 "Democracy Index (V-Dem, 2000)"

save "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/democracy/Country_Year_V-Dem_Core_CSV_v11.1/vdem.dta", replace

********************************************************************************
 use "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/populism/CPD_V-Party_Stata_v1/V-Dem-CPD-Party-V1.dta", clear
keep if year >= 1970

***** merge the dataset with the V-Dem dataset to get the regime type of each country when the election takes place *****
merge m:1 country_text_id year using "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/democracy/Country_Year_V-Dem_Core_CSV_v11.1/vdem.dta",keep(match master) force

********************************************************************************
***** Generate descriptive stats *****

*** Summary statistics for the whole sample ***
eststo clear
estpost tabstat v2xpa_illiberal v2xpa_popul v2paseatshare v2pavote v2paanteli v2papeople v2paopresp v2paplur v2paminor v2paviol v2paimmig v2palgbt v2paculsup v2parelig v2pagender v2pawomlab v2pariglef v2pawelf v2paclient, c(stat) stat(mean sd min p50 max n)

esttab using ${path_dropbox}/tables/appendix/descriptive_vparty.tex, ///
replace cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min p50 max count(fmt(%13.0fc))") nonumber ///
nomtitle noobs label collabels("Mean" "SD" "Min" "Median" "Max" "N") ///
addnotes("The sample consists of parties that participated in national elections between 1970-2019 across 178 countries.")

*** Summary statistics for just ruling parties ***
eststo clear
estpost tabstat v2xpa_illiberal v2xpa_popul v2paseatshare v2pavote v2paanteli v2papeople v2paopresp v2paplur v2paminor v2paviol v2paimmig v2palgbt v2paculsup v2parelig v2pagender v2pawomlab v2pariglef v2pawelf v2paclient, c(stat) stat(mean sd min p50 max n), if v2pagovsup == 0 
esttab using ${path_dropbox}/tables/appendix/descriptive_vparty_ruling.tex, ///
cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min p50 max count(fmt(%13.0fc))") nonumber ///
nomtitle noobs label collabels("Mean" "SD" "Min" "Median" "Max" "N") ///
addnotes("The sample consists of parties that became the ruling parties in national elections between 1970-2019 across 178 countries.")

********************************************************************************
***** first, we just look at ruling parties in every election term *****
keep if v2pagovsup == 0

// if there are multiple ruling parties in one election, make the weighted illiberalism and populism score using the seat share 
// for each year-country group, make a seat-share-weighted populism score 
bysort year country_text_id: egen seatw_ruling_popul = wtmean(v2xpa_popul), weight(v2paseatshare)
bysort year country_text_id: egen seatw_ruling_illib = wtmean(v2xpa_illiberal), weight(v2paseatshare)

label variable seatw_ruling_popul "Ruling party's populism score"
label variable seatw_ruling_illib "Ruling party's illiberalism score"

duplicates drop year country_text_id, force

********************************************************************************
keep year country_text_id seatw_ruling_popul seatw_ruling_illib
 
save "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/populism/CPD_V-Party_Stata_v1/ruling.dta", replace
*******************************************************************************
*** GLOBAL TREND
// generate median and mean by year to look at worldwide trends
bysort year: egen mean_v2xpa_illiberal = mean(v2xpa_illiberal)
bysort year: egen mean_v2xpa_popul = mean(v2xpa_popul)
bysort year: egen med_v2xpa_illiberal = median(v2xpa_illiberal)
bysort year: egen med_v2xpa_popul = median(v2xpa_popul)

// make a plot with 
/// X: year 
/// Y: liberalism index (v2xpa_illiberal)
graph twoway scatter v2xpa_illiberal year, title("Illiberalism score of ruling parties") || line mean_v2xpa_illiberal year || line med_v2xpa_illiberal year || lfit v2xpa_illiberal year, legend(order(1 "Ruling party's illiberalism score" 2 "Mean illiberalism score" 3 "Median illiberalism score"))
graph export ${path_dropbox}/figures/timeseries_illiberalism.png, replace

/// X: year
/// Y: populism index (v2xpa_popul)
graph twoway scatter v2xpa_popul year, title("Populism score of ruling parties") || line mean_v2xpa_popul year || line med_v2xpa_popul year || lfit v2xpa_popul year, legend(order(1 "Ruling party's populism score" 2 "Mean populism score" 3 "Median populism score"))
graph export ${path_dropbox}/figures/timeseries_populism.png, replace

*** TREND IN 2001-2019 BY REGIME TYPE IN 2000
// generate median and mean by year to look at worldwide trends
bysort year regime2000: egen mean_regime_v2xpa_illiberal = mean(v2xpa_illiberal)
bysort year regime2000: egen mean_regime_v2xpa_popul = mean(v2xpa_popul)
bysort year regime2000: egen med_regime_v2xpa_illiberal = median(v2xpa_illiberal)
bysort year regime2000: egen med_regime_v2xpa_popul = median(v2xpa_popul)

keep if year > 2000

/// X: year 
/// Y: liberalism index (v2xpa_illiberal)
graph twoway scatter v2xpa_illiberal year, by(regime2000)  || line mean_regime_v2xpa_illiberal year || line med_regime_v2xpa_illiberal year || lfit v2xpa_illiberal year, legend(order(1 "Ruling party's illiberalism score" 2 "Mean illiberalism score" 3 "Median illiberalism score" 4 "OLS fitted line"))
graph export ${path_dropbox}/figures/timeseries_illiberalism_byregime2000.png, replace

/// X: year
/// Y: populism index (v2xpa_popul)
graph twoway scatter v2xpa_popul year, by(regime2000) || line mean_regime_v2xpa_popul year || line med_regime_v2xpa_popul year || lfit v2xpa_popul year, legend(order(1 "Ruling party's populism score" 2 "Mean populism score" 3 "Median populism score" 4 "OLS fitted line"))
graph export ${path_dropbox}/figures/timeseries_populism_byregime2000.png, replace

********************************************************************************
********************************************************************************
***** now, look at the national-vote-share-weighted average populism score across all the parties in each country *****
 use "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/populism/CPD_V-Party_Stata_v1/V-Dem-CPD-Party-V1.dta", clear
keep if year >= 1970

***** merge the dataset with the V-Dem dataset to get the regime type of each country when the election takes place *****
merge m:1 country_text_id year using "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/democracy/Country_Year_V-Dem_Core_CSV_v11.1/vdem.dta",keep(match master) force

***** MAKE NATIONAL MEASURE OF POPULISM AND LIBERALISM *****
// for each year-country group, make a seat-share-weighted populism score 
bysort year country_text_id: egen seatw_popul = wtmean(v2xpa_popul), weight(v2paseatshare)
bysort year country_text_id: egen seatw_illib = wtmean(v2xpa_illiberal), weight(v2paseatshare)

label variable seatw_popul "Seat-share-weighted populism score"
label variable seatw_illib "Seat-share-weighted illiberalism score"

***** MAKE THE DATASET BY COUNTRY-YEAR ****
du plicates drop year country_text_id, force
keep year country_text_id seatw_popul seatw_illib v2x_regime v2x_polyarchy dem2000 regime2000
 
***** merge the dataset with the dataset on ruling parties (by country-year)*****
merge 1:1 country_text_id year using "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/populism/CPD_V-Party_Stata_v1/ruling.dta"
keep if _merge==3
drop _merge

********************************************************************************

***** GENERATE DESCRIPTIVE STATS *****
eststo clear
estpost tabstat seatw_popul seatw_ruling_popul seatw_illib seatw_ruling_illib , c(stat) stat(mean sd min p50 max n)

esttab using ${path_dropbox}/tables/appendix/descriptive_vparty_bycountry.tex, ///
cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min p50 max count(fmt(%13.0fc))") nonumber ///
nomtitle noobs label collabels("Mean" "SD" "Min" "Median" "Max" "N") ///
addnotes("The sample is by country-election.") replace
 
********************************************************************************

*** GLOBAL TREND
// generate median and mean by year to look at worldwide trends
bysort year: egen mean_seatw_illib = mean(seatw_illib)
bysort year: egen mean_seatw_popul = mean(seatw_popul)
bysort year: egen med_seatw_illib = median(seatw_illib)
bysort year: egen med_seatw_popul = median(seatw_popul)

// make a plot with 
/// X: year 
/// Y: weighted liberalism index (seatw_illib)
graph twoway scatter seatw_illib year, title("Seat-share-weighted illiberalism score") || line mean_seatw_illib year || line med_seatw_illib year || lfit seatw_illib year, legend(order(1 "Weighted illiberalism score" 2 "World mean" 3 "World median" 4 "OLS fitted line"))
graph export ${path_dropbox}/figures/timeseries_seatw_illib.png, replace

// make a plot with 
/// X: year 
/// Y: weighted populism index (seatw_popul)
graph twoway scatter seatw_popul year, title("Seat-share-weighted populism score") || line mean_seatw_popul year || line med_seatw_popul year || lfit seatw_popul year, legend(order(1 "Weighted populism score of election" 2 "World mean" 3 "World median" 4 "OLS fitted line"))
graph export ${path_dropbox}/figures/timeseries_seatw_popul.png, replace

*** TREND BY REGIME TYPE IN 2000 ***

// generate median and mean by year to look at worldwide trends
bysort year regime2000: egen mean_regime_seatw_illib = mean(seatw_illib)
bysort year regime2000: egen mean_regime_seatw_popul = mean(seatw_popul)
bysort year regime2000: egen med_regime_seatw_illib = median(seatw_illib)
bysort year regime2000: egen med_regime_seatw_popul = median(seatw_popul)

keep if year > 2000

/// X: year 
/// Y: liberalism index (v2xpa_illiberal)
graph twoway scatter seatw_illib year, by(regime2000)  || line mean_regime_seatw_illib year || line med_regime_seatw_illib year || lfit seatw_illib year, legend(order(1 "Weighted illiberalism score" 2 "World mean" 3 "World median" 4 "OLS fitted line"))
graph export ${path_dropbox}/figures/timeseries_seatw_illib_byregime2000.png, replace

/// X: year
/// Y: populism index (v2xpa_popul)
graph twoway scatter seatw_popul year, by(regime2000) || line mean_regime_seatw_popul year || line med_regime_seatw_popul year || lfit seatw_popul year, legend(order(1 "Weighted populism score" 2 "World mean" 3 "World median" 4 "OLS fitted line")) 
graph export ${path_dropbox}/figures/timeseries_seatw_popul_byregime2000.png, replace

********************************************************************************
***** Now, look at the relationship between democracy and illiberal rhetoric in 2001-2019 (each row is by country-election) ****
keep if year >=2001

bysort country_text_id: egen mean_seatw_illib_2001_2019 = mean(seatw_illib)
bysort country_text_id: egen mean_seatw_popul_2001_2019 = mean(seatw_popul)
label variable mean_seatw_illib_2001_2019 "Mean weighted illiberalism score in 2001-2019"
label variable mean_seatw_popul_2001_2019 "Mean weighted populism score in 2001-2019"

bysort country_text_id: egen mean_ruling_illib_2001_2019 = mean(seatw_ruling_illib)
bysort country_text_id: egen mean_ruling_popul_2001_2019 = mean(seatw_ruling_popul)
label variable  mean_ruling_illib_2001_2019 "Mean Illiberalism Score of Ruling Parties in 2001-2019"
label variable mean_ruling_popul_2001_2019 "Mean Populism Score of Ruling Parties in 2001-2019"

sort country_text_id year
bysort country_text_id: gen change_seatw_illib_2001_2019 = seatw_illib[_N] - seatw_illib[1]
bysort country_text_id: gen change_seatw_popul_2001_2019 = seatw_popul[_N] - seatw_popul[1]
label variable change_seatw_illib_2001_2019 "Change in weighted illiberalism score in 2001-2019"
label variable change_seatw_popul_2001_2019 "Change in weighted populism score in 2001-2019"

bysort country_text_id: gen change_ruling_illib_2001_2019 = seatw_ruling_illib[_N] - seatw_ruling_illib[1]
bysort country_text_id: gen change_ruling_popul_2001_2019 = seatw_ruling_popul[_N] - seatw_ruling_popul[1]
label variable change_ruling_illib_2001_2019 "Change in Ruling Party's Illiberalism Score in 2001-2019'"
label variable change_ruling_popul_2001_2019 "Change in Ruling Party's Populism Score in 2001-2019'"

// make observations by country (N=156, not 174 since we deleted observations for which v2pagovsup data is empty (ruling party is unclear))
duplicates drop country_text_id, force
drop year

***** merge the dataset with total.dta ****
rename country_text_id iso3
merge 1:1 iso3 using "/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta"
drop if _merge
keep if _merge==3 // 応急処置
drop _merge 

********************************************************************************

// generate variable that records the illiberalism/populism score of ruling parties 
// generate variable that records the change in the weighted illiberalism/populism in 2001-2019

*** Are more democratic nations more likely to have illiberal rhetoric??? (LEVELS) ***
/// X: democracy level in 2000
/// Y: mean weighted illiberal rhetoric score in 2001-2019
graph twoway scatter mean_seatw_illib_2001_2019 dem2000, mlabel(iso3) || lfit mean_seatw_illib_2001_2019 dem2000 || lfit mean_seatw_illib_2001_2019 dem2000 [w=total_gdp2000], legend(order(1 "Mean illiberalism score in 2001-2019" 2 "Unweighted OLS" 3 "GDP-weighted OLS"))
graph export ${path_dropbox}/figures/democracy_illiberalism.png, replace

/// X: democracy level in 2000
/// Y: mean illiberal rhetoric score of ruling party in 2001-2019 
graph twoway scatter mean_ruling_illib_2001_2019 dem2000, mlabel(iso3)  || lfit mean_ruling_illib_2001_2019 dem2000 || lfit mean_ruling_illib_2001_2019 dem2000 [w=total_gdp2000], legend(order(1 "Mean illiberalism score of ruling parties in 2001-2019" 2 "Unweighted OLS" 3 "GDP-weighted OLS"))
graph export ${path_dropbox}/figures/democracy_illiberalism_byruling.png, replace

/// X: democracy level in 2000
/// Y: mean weighted populist rhetoric score in 2001-2019
graph twoway scatter mean_seatw_popul_2001_2019 dem2000, mlabel(iso3)  || lfit mean_seatw_popul_2001_2019 dem2000 || lfit mean_seatw_popul_2001_2019 dem2000 [w=total_gdp2000], legend(order(1 "Mean populism score in 2001-2019" 2 "Unweighted OLS" 3 "GDP-weighted OLS"))
graph export ${path_dropbox}/figures/democracy_populism.png, replace

/// X: democracy level in 2000
/// Y: mean weighted populist score of ruling party in 2001-2019 
graph twoway scatter mean_ruling_popul_2001_2019 dem2000, mlabel(iso3)  || lfit mean_ruling_popul_2001_2019 dem2000 || lfit mean_ruling_popul_2001_2019 dem2000 [w=total_gdp2000], legend(order(1 "Mean populism score of ruling parties in 2001-2019" 2 "Unweighted OLS" 3 "GDP-weighted OLS"))
graph export ${path_dropbox}/figures/democracy_populism_byruling.png, replace


*** Are more democratic nations more likely to experience greater increases in illiberalism and populism in 2001-2019??? (CHANGES) ***

// X: democracy level in 2000
// Y: change in weighted illiberal rhetoric score in 2001-2019
graph twoway scatter change_seatw_illib_2001_2019 dem2000, mlabel(iso3)  || lfit change_seatw_illib_2001_2019 dem2000 || lfit change_seatw_illib_2001_2019 dem2000 [w=total_gdp2000], legend(order(1 "Change in illiberalism score in 2001-2019" 2 "Unweighted OLS" 3 "GDP-weighted OLS"))
graph export ${path_dropbox}/figures/democracy_change_illiberalism_2001_2019.png, replace

// X: democracy level in 2000
// Y: change in illiberal rhetoric score in ruling parties in 2001-2019
graph twoway scatter change_ruling_illib_2001_2019 dem2000, mlabel(iso3)  || lfit change_ruling_illib_2001_2019 dem2000 || lfit change_ruling_illib_2001_2019 dem2000 [w=total_gdp2000], legend(order(1 "Change in illiberalism score of ruling parties in 2001-2019" 2 "Unweighted OLS" 3 "GDP-weighted OLS"))
graph export ${path_dropbox}/figures/democracy_change_illiberalism_2001_2019_byruling.png, replace

// X: democracy level in 2000
// Y: change in weighted populism rhetoric score in 2001-2019
graph twoway scatter change_seatw_popul_2001_2019 dem2000, mlabel(iso3)  || lfit change_seatw_popul_2001_2019 dem2000 || lfit change_seatw_popul_2001_2019 dem2000 [w=total_gdp2000], legend(order(1 "Change in populism score in 2001-2019" 2 "Unweighted OLS" 3 "GDP-weighted OLS"))
graph export ${path_dropbox}/figures/democracy_change_populism_2001_2019.png, replace


// X: democracy level in 2000
// Y: change in populist rhetoric score in ruling parties in 2001-2019 
graph twoway scatter change_ruling_popul_2001_2019 dem2000, mlabel(iso3)  || lfit change_ruling_popul_2001_2019 dem2000 || lfit change_ruling_popul_2001_2019 dem2000 [w=total_gdp2000], legend(order(1 "Change in populism score of ruling parties in 2001-2019" 2 "Unweighted OLS" 3 "GDP-weighted OLS"))
graph export ${path_dropbox}/figures/democracy_change_populism_2001_2019_byruling.png, replace

********************************************************************************
******************************************************************************** **** REDUCED FORM USING LOGEM
******** ILLIBERALISM
graph twoway scatter mean_seatw_illib_2001_2019 logem, mlabel(iso3) || lfit mean_seatw_illib_2001_2019 logem || lfit mean_seatw_illib_2001_2019 logem [w=total_gdp2000], legend(order(1 "Mean illiberalism score in 2001-2019" 2 "Unweighted OLS" 3 "GDP-weighted OLS"))
graph export ${path_dropbox}/figures/rf_logem_illiberalism.png, replace

est clear 
forvalues i = 1/6{
	eststo: reg mean_seatw_illib_2001_2019 ${iv`i'} [w=total_gdp2000], robust
	eststo: reg mean_seatw_illib_2001_2019 ${iv`i'} ${base_covariates2000} [w=total_gdp2000], robust
	}
esttab using ${path_dropbox}/tables/appendix/rf_mean_seatw_illib_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) drop(${base_covariates2000} _cons) nostar prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"') 

graph twoway scatter mean_ruling_illib_2001_2019 logem, mlabel(iso3)  || lfit mean_ruling_illib_2001_2019 logem || lfit mean_ruling_illib_2001_2019 logem [w=total_gdp2000], legend(order(1 "Mean illiberalism score of ruling parties in 2001-2019" 2 "Unweighted OLS" 3 "GDP-weighted OLS"))
graph export ${path_dropbox}/figures/rf_logem_illiberalism_byruling.png, replace
est clear 
forvalues i = 1/6{
	// eststo: reg mean_ruling_illib_2001_2019 ${iv`i'}, robust 
	eststo: reg mean_ruling_illib_2001_2019 ${iv`i'} [w=total_gdp2000], robust
	eststo: reg mean_ruling_illib_2001_2019 ${iv`i'} ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/rf_mean_ruling_illib_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) drop(${base_covariates2000} _cons) nostar prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')

graph twoway scatter change_seatw_illib_2001_2019 logem, mlabel(iso3)  || lfit change_seatw_illib_2001_2019 logem || lfit change_seatw_illib_2001_2019 logem [w=total_gdp2000], legend(order(1 "Change in illiberalism score in 2001-2019" 2 "Unweighted OLS" 3 "GDP-weighted OLS"))
graph export ${path_dropbox}/figures/rf_logem_change_illiberalism_2001_2019.png, replace
est clear 
forvalues i = 1/6{
// 	eststo: reg change_seatw_illib_2001_2019 ${iv`i'}, robust 
	eststo: reg change_seatw_illib_2001_2019 ${iv`i'} [w=total_gdp2000], robust
	eststo: reg change_seatw_illib_2001_2019 ${iv`i'} ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/rf_change_seatw_illib_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) drop(${base_covariates2000} _cons) nostar prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')


graph twoway scatter change_ruling_illib_2001_2019 logem, mlabel(iso3)  || lfit change_ruling_illib_2001_2019 logem || lfit change_ruling_illib_2001_2019 logem [w=total_gdp2000], legend(order(1 "Change in illiberalism score of ruling parties in 2001-2019" 2 "Unweighted OLS" 3 "GDP-weighted OLS"))
graph export ${path_dropbox}/figures/rf_logem_change_illiberalism_2001_2019_byruling.png, replace
est clear 
forvalues i = 1/6{
	// reg change_ruling_illib_2001_2019 ${iv`i'}, robust 
	eststo: reg change_ruling_illib_2001_2019 ${iv`i'} [w=total_gdp2000], robust
	eststo: reg change_ruling_illib_2001_2019 ${iv`i'} ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/rf_change_ruling_illib_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) drop(${base_covariates2000} _cons) nostar prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')

******* POPULISM 
graph twoway scatter mean_seatw_popul_2001_2019 logem, mlabel(iso3) || lfit mean_seatw_popul_2001_2019 logem || lfit mean_seatw_popul_2001_2019 logem [w=total_gdp2000], legend(order(1 "Mean populism score in 2001-2019" 2 "Unweighted OLS" 3 "GDP-weighted OLS"))
graph export ${path_dropbox}/figures/rf_logem_populism.png, replace

est clear
forvalues i = 1/6{
	//eststo: reg mean_seatw_popul_2001_2019 ${iv`i'}, robust 
	eststo: reg mean_seatw_popul_2001_2019 ${iv`i'} [w=total_gdp2000], robust
	eststo: reg mean_seatw_popul_2001_2019 ${iv`i'} ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/rf_mean_seatw_popul_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) drop(${base_covariates2000} _cons) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')

graph twoway scatter mean_ruling_popul_2001_2019 logem, mlabel(iso3)  || lfit mean_ruling_popul_2001_2019 logem || lfit mean_ruling_popul_2001_2019 logem [w=total_gdp2000], legend(order(1 "Mean illiberalism score of ruling parties in 2001-2019" 2 "Unweighted OLS" 3 "GDP-weighted OLS"))
graph export ${path_dropbox}/figures/rf_logem_populism_byruling.png, replace
est clear 
forvalues i = 1/6{
	// eststo: reg mean_ruling_popul_2001_2019 ${iv`i'}, robust 
	eststo: reg mean_ruling_popul_2001_2019 ${iv`i'} [w=total_gdp2000], robust
	eststo: reg mean_ruling_popul_2001_2019 ${iv`i'} ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/rf_mean_ruling_popul_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) drop(${base_covariates2000} _cons) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')

graph twoway scatter change_seatw_popul_2001_2019 logem, mlabel(iso3)  || lfit change_seatw_popul_2001_2019 logem || lfit change_seatw_popul_2001_2019 logem [w=total_gdp2000], legend(order(1 "Change in populism score in 2001-2019" 2 "Unweighted OLS" 3 "GDP-weighted OLS"))
graph export ${path_dropbox}/figures/rf_logem_change_populism_2001_2019.png, replace
est clear
forvalues i = 1/6{
	// eststo: reg change_seatw_popul_2001_2019 ${iv`i'}, robust 
	eststo: reg change_seatw_popul_2001_2019 ${iv`i'} [w=total_gdp2000], robust
	eststo: reg change_seatw_popul_2001_2019 ${iv`i'} ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/rf_change_seatw_popul_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) drop(${base_covariates2000} _cons) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')

graph twoway scatter change_ruling_popul_2001_2019 logem, mlabel(iso3)  || lfit change_ruling_popul_2001_2019 logem || lfit change_ruling_popul_2001_2019 logem [w=total_gdp2000], legend(order(1 "Change in populism score of ruling parties in 2001-2019" 2 "Unweighted OLS" 3 "GDP-weighted OLS"))
graph export ${path_dropbox}/figures/rf_logem_change_populism_2001_2019_byruling.png, replace
est clear 
forvalues i = 1/6{
	eststo: reg change_ruling_popul_2001_2019 ${iv`i'} [w=total_gdp2000], robust
	eststo: reg change_ruling_popul_2001_2019 ${iv`i'} ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/rf_change_ruling_popul_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) drop(${base_covariates2000} _cons) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\"')

********************************************************************************
******************************************************************************** 2SLS on levels (weighted by baseline GDP )

// Y: mean_seatw_illib_2001_2019
est clear
forvalues i = 1/6{
	eststo: ivreg2 mean_seatw_illib_2001_2019 (dem2000=${iv`i'})  [w=total_gdp2000], robust
	eststo: ivreg2 mean_seatw_illib_2001_2019 (dem2000=${iv`i'})  ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_mean_seatw_illib_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(dem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

// Y: mean_ruling_illib_2001_2019
est clear
forvalues i = 1/6{
	eststo: ivreg2 mean_ruling_illib_2001_2019 (dem2000=${iv`i'})  [w=total_gdp2000], robust
	eststo: ivreg2 mean_ruling_illib_2001_2019 (dem2000=${iv`i'})  ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_mean_ruling_illib_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(dem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 


// Y: mean_seatw_popul_2001_2019
est clear
forvalues i = 1/6{
	eststo: ivreg2 mean_seatw_popul_2001_2019 (dem2000=${iv`i'})  [w=total_gdp2000], robust
	eststo: ivreg2 mean_seatw_popul_2001_2019 (dem2000=${iv`i'})  ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_mean_seatw_popul_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(dem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

// Y: mean_ruling_popul_2001_2019
est clear
forvalues i = 1/6{
	eststo: ivreg2 mean_ruling_popul_2001_2019 (dem2000=${iv`i'})  [w=total_gdp2000], robust
	eststo: ivreg2 mean_ruling_popul_2001_2019 (dem2000=${iv`i'})  ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_mean_ruling_popul_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(dem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

********************************************************************************
******************************************************************************** 2SLS on levels (no weighting)

// Y: mean_seatw_illib_2001_2019
est clear
forvalues i = 1/6{
	eststo: ivreg2 mean_seatw_illib_2001_2019 (dem2000=${iv`i'}), robust
	eststo: ivreg2 mean_seatw_illib_2001_2019 (dem2000=${iv`i'})  ${base_covariates2000}, robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_mean_seatw_illib_2001_2019_noweighting.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(dem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

// Y: mean_ruling_illib_2001_2019
est clear
forvalues i = 1/6{
	eststo: ivreg2 mean_ruling_illib_2001_2019 (dem2000=${iv`i'}), robust
	eststo: ivreg2 mean_ruling_illib_2001_2019 (dem2000=${iv`i'})  ${base_covariates2000}, robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_mean_ruling_illib_2001_2019_noweighting.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(dem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 


// Y: mean_seatw_popul_2001_2019
est clear
forvalues i = 1/6{
	eststo: ivreg2 mean_seatw_popul_2001_2019 (dem2000=${iv`i'}), robust
	eststo: ivreg2 mean_seatw_popul_2001_2019 (dem2000=${iv`i'})  ${base_covariates2000}, robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_mean_seatw_popul_2001_2019_noweighting.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(dem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

// Y: mean_ruling_popul_2001_2019
est clear
forvalues i = 1/6{
	eststo: ivreg2 mean_ruling_popul_2001_2019 (dem2000=${iv`i'}), robust
	eststo: ivreg2 mean_ruling_popul_2001_2019 (dem2000=${iv`i'})  ${base_covariates2000}, robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_mean_ruling_popul_2001_2019_noweighting.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(dem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

********************************************************************************
******************************************************************************** 2SLS on changes (weighted by baseline GDP )

// Y: change_seatw_illib_2001_2019
est clear
forvalues i = 1/6{
// 	ivreg2 change_ruling_popul_2001_2019 ${iv`i'}, robust 
	eststo: ivreg2 change_seatw_illib_2001_2019 (dem2000=${iv`i'})  [w=total_gdp2000], robust
	eststo: ivreg2 change_seatw_illib_2001_2019 (dem2000=${iv`i'})  ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_change_seatw_illib_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(dem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

// Y: change_ruling_illib_2001_2019
est clear
forvalues i = 1/6{
	eststo: ivreg2 change_ruling_illib_2001_2019 (dem2000=${iv`i'})  [w=total_gdp2000], robust
	eststo: ivreg2 change_ruling_illib_2001_2019 (dem2000=${iv`i'})  ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_change_ruling_illib_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(dem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

// Y: change_seatw_popul_2001_2019
est clear
forvalues i = 1/6{
// 	ivreg2 change_ruling_popul_2001_2019 ${iv`i'}, robust 
	eststo: ivreg2 change_seatw_popul_2001_2019 (dem2000=${iv`i'})  [w=total_gdp2000], robust
	eststo: ivreg2 change_seatw_popul_2001_2019 (dem2000=${iv`i'})  ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_change_seatw_popul_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(dem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

// Y: change_ruling_popul_2001_2019
est clear
forvalues i = 1/6{
// 	ivreg2 change_ruling_popul_2001_2019 ${iv`i'}, robust 
	eststo: ivreg2 change_ruling_popul_2001_2019 (dem2000=${iv`i'})  [w=total_gdp2000], robust
	eststo: ivreg2 change_ruling_popul_2001_2019 (dem2000=${iv`i'})  ${base_covariates2000} [w=total_gdp2000], robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_change_ruling_popul_2001_2019.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(dem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

********************************************************************************
******************************************************************************** 2SLS on changes (unweighted)

// Y: change_seatw_illib_2001_2019
est clear
forvalues i = 1/6{
// 	ivreg2 change_ruling_popul_2001_2019 ${iv`i'}, robust 
	eststo: ivreg2 change_seatw_illib_2001_2019 (dem2000=${iv`i'}), robust
	eststo: ivreg2 change_seatw_illib_2001_2019 (dem2000=${iv`i'})  ${base_covariates2000}, robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_change_seatw_illib_2001_2019_noweighting.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(dem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

// Y: change_ruling_illib_2001_2019
est clear
forvalues i = 1/6{
	eststo: ivreg2 change_ruling_illib_2001_2019 (dem2000=${iv`i'}), robust
	eststo: ivreg2 change_ruling_illib_2001_2019 (dem2000=${iv`i'})  ${base_covariates2000}, robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_change_ruling_illib_2001_2019_noweighting.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(dem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

// Y: change_seatw_popul_2001_2019
est clear
forvalues i = 1/6{
// 	ivreg2 change_ruling_popul_2001_2019 ${iv`i'}, robust 
	eststo: ivreg2 change_seatw_popul_2001_2019 (dem2000=${iv`i'}), robust
	eststo: ivreg2 change_seatw_popul_2001_2019 (dem2000=${iv`i'})  ${base_covariates2000}, robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_change_seatw_popul_2001_2019_noweighting.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(dem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 

// Y: change_ruling_popul_2001_2019
est clear
forvalues i = 1/6{
// 	ivreg2 change_ruling_popul_2001_2019 ${iv`i'}, robust 
	eststo: ivreg2 change_ruling_popul_2001_2019 (dem2000=${iv`i'}), robust
	eststo: ivreg2 change_ruling_popul_2001_2019 (dem2000=${iv`i'})  ${base_covariates2000}, robust
}
esttab using ${path_dropbox}/tables/appendix/2sls_change_ruling_popul_2001_2019_noweighting.tex, replace b(3) se(3) label noconstant nomtitles stats(N, labels("N") fmt(0)) keep(dem2000) nostar nonotes prefoot(`"Baseline Controls & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark & \xmark & \cmark\\ IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') 



