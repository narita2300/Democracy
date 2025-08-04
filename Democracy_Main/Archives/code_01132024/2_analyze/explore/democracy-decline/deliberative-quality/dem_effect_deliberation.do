
use "/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/data/total.dta"

label variable v2xdl_delib2000 "Deliberative Component Index (2000)"
label variable v2xdl_delib2019 "Deliberative Component Index (2019)"
label variable v2xdl_delib2020 "Deliberative Component Index (2020)"

// create a variable recording the change in the quality of deliberation in 2001-2019
gen v2xdl_delib_diff_2001_2019 = v2xdl_delib2019 - v2xdl_delib2001
label variable v2xdl_delib_diff_2001_2019 "Change in Deliberative Component Index in 2001-2019"
gen v2xdl_delib_diff_2001_2010 = v2xdl_delib2010 - v2xdl_delib2001
label variable v2xdl_delib_diff_2001_2010 "Change in Deliberative Component Index in 2001-2010"
gen v2xdl_delib_diff_2011_2020 = v2xdl_delib2020 - v2xdl_delib2011
label variable v2xdl_delib_diff_2011_2020 "Change in Deliberative Component Index in 2011-2020"


********************************************************************************
*** Summary statistics ***
eststo clear
// eststo: estpost summarize v2xdl_delib2000 v2xdl_delib_diff_2001_2019
// esttab _all using "delib_summ.tex", replace cells("count mean sd min max")

estpost tabstat democracy_vdem2000 v2xdl_delib2000 v2xdl_delib2019 v2xdl_delib_diff_2001_2019, c(stat) stat(mean sd min p50 max n)

esttab using ${path_dropbox}/tables/appendix/descriptive_deliberative_index.tex, ///
cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min p50 max count(fmt(%13.0fc))") nonumber ///
nomtitle nonote noobs label collabels("Mean" "SD" "Min" "Median" "Max" "N")

********************************************************************************
*** OLS: Higher levels of democracy is associated with higher levels of deliberation quality
**** figure
// Note: our main variable measuring democracy (v2x_polyarchy) does not have the deliberative component index as its component)
graph twoway scatter v2xdl_delib2019 democracy_vdem2000, mlabel(iso3) || (lfit v2xdl_delib2019 democracy_vdem2000), ytitle("Deliberative Component Index (2019)") || (lfit v2xdl_delib2019 democracy_vdem2000 [w=total_gdp2000], legend(order (2 "Unweighted OLS" 3 "GDP-weighted OLS"))) 
graph export ${path_dropbox}/figures/ols_dem_delib.png

**** regression
est clear
eststo: reg v2xdl_delib2000 democracy_vdem2000, robust
eststo: reg v2xdl_delib2000 democracy_vdem2000 [w=total_gdp2000], robust
esttab using ${path_dropbox}/tables/appendix/ols_dem_delib.tex, replace b(3) se(3) label noconstant mtitle("Unweighted" "GDP-weighted") stats(N, labels("N") fmt(0))

********************************************************************************
*** OLS figure: Higher levels of democracy is associated with decreases in the quality of deliberation in 2001-2019
**** figure 
graph twoway (scatter v2xdl_delib_diff_2001_2019 democracy_vdem2000,  mlabel(iso3)) || (lfit v2xdl_delib_diff_2001_2019 democracy_vdem2000)|| (lfit v2xdl_delib_diff_2001_2019 democracy_vdem2000 [w=total_gdp2000]), legend(order(2 "Unweighted OLS" 3 "GDP-weighted OLS")) ytitle("Change in Deliberative Component Index in 2001-19")
graph export ${path_dropbox}/figures/ols_dem_change_delib_2001_2019.png

**** regression
est clear 
eststo: reg v2xdl_delib_diff_2001_2019 democracy_vdem2000, robust
eststo: reg v2xdl_delib_diff_2001_2019 democracy_vdem2000 [w=total_gdp2000], robust
esttab using ${path_dropbox}/tables/appendix/ols_dem_change_delib.tex, replace b(3) se(3) label noconstant mtitle("Unweighted" "GDP-weighted") stats(N, labels("N") fmt(0))

********************************************************************************
*** OLS figure: Higher levels of democracy is associated with decreases in the quality of deliberation in 2001-2010
**** figure 
graph twoway (scatter v2xdl_delib_diff_2001_2010 democracy_vdem2000,  mlabel(iso3)) || (lfit v2xdl_delib_diff_2001_2010 democracy_vdem2000)|| (lfit v2xdl_delib_diff_2001_2010 democracy_vdem2000 [w=total_gdp2000]), legend(order(2 "Unweighted OLS" 3 "GDP-weighted OLS")) ytitle("Change in Deliberative Component Index in 2001-10")
graph export ${path_dropbox}/figures/ols_dem_change_delib_2001_2010.png

**** regression
est clear 
eststo: reg v2xdl_delib_diff_2001_2010 democracy_vdem2000, robust
eststo: reg v2xdl_delib_diff_2001_2010 democracy_vdem2000 [w=total_gdp2000], robust
esttab using ${path_dropbox}/tables/appendix/ols_dem_change_delib_2001_2010.tex, replace b(3) se(3) label noconstant mtitle("Unweighted" "GDP-weighted") stats(N, labels("N") fmt(0))

********************************************************************************
*** OLS figure: Higher levels of democracy is associated with decreases in the quality of deliberation in 2011-2020
**** figure 
graph twoway (scatter v2xdl_delib_diff_2011_2020 democracy_vdem2010,  mlabel(iso3)) || (lfit v2xdl_delib_diff_2011_2020 democracy_vdem2010)|| (lfit v2xdl_delib_diff_2011_2020 democracy_vdem2010 [w=total_gdp2010]), legend(order(2 "Unweighted OLS" 3 "GDP-weighted OLS")) ytitle("Change in Deliberative Component Index in 2011-20")
graph export ${path_dropbox}/figures/ols_dem_change_delib_2011_2020.png

**** regression
est clear 
eststo: reg v2xdl_delib_diff_2011_2020 democracy_vdem2010, robust
eststo: reg v2xdl_delib_diff_2011_2020 democracy_vdem2010 [w=total_gdp2010], robust
esttab using ${path_dropbox}/tables/appendix/ols_dem_change_delib_2011_2020.tex, replace b(3) se(3) label noconstant mtitle("Unweighted" "GDP-weighted") stats(N, labels("N") fmt(0))

********************************************************************************
*** Reduced-form: higher levels of settler mortality is associated with lower levels of democracy, which is associated with lower deliberative quality -> Democracy causes higher delibrative quality 
**** figure
graph twoway (scatter v2xdl_delib2000 logem4, mlabel(iso3)) || (lfit v2xdl_delib2000 logem4)|| (lfit v2xdl_delib2000 logem4 [w=total_gdp2000]), legend(order(2 "Unweighted OLS" 3 "GDP-weighted OLS")) ytitle("Deliberative Component Index in 2000")
graph export ${path_dropbox}/figures/rf_logem_delib2000.png

**** regression
est clear
eststo: reg v2xdl_delib2000 logem4, robust
eststo: reg v2xdl_delib2000 logem4 [w=total_gdp2000], robust
esttab using ${path_dropbox}/tables/appendix/rf_logem_delib2000.tex, replace b(3) se(3) label noconstant mtitle("Unweighted" "GDP-weighted") stats(N, labels("N") fmt(0))

********************************************************************************
*** Reduced-form figure: higher levels of settler mrotality is associated with lower levels of democracy, which is associated with increases in deliberative quality -> Democracy causes decreases in deliberative quality 
**** figure
graph twoway (scatter v2xdl_delib_diff_2001_2019 logem4, mlabel(iso3)) || (lfit v2xdl_delib_diff_2001_2019 logem4)|| (lfit v2xdl_delib_diff_2001_2019 logem4 [w=total_gdp2000]), legend(order(2 "Unweighted OLS" 3 "GDP-weighted OLS")) ytitle("Change in Deliberative Component Index in 2001-19")
graph export ${path_dropbox}/figures/rf_logem_change_delib_2001_2019.png

**** regression

est clear
eststo: reg v2xdl_delib_diff_2001_2019 logem4, robust
eststo: reg v2xdl_delib_diff_2001_2019 logem4 [w=total_gdp2000], robust
esttab using ${path_dropbox}/tables/appendix/rf_logem_change_delib_2001_2019.tex, replace b(3) se(3) label noconstant mtitle("Unweighted" "GDP-weighted") stats(N, labels("N") fmt(0))

// ********************************************************************************
// *** 2SLS regression: democracy causes higher quality deliberation
// est clear
// forvalues i = 1/6{
// 	eststo: ivreg2 v2xdl_delib2000 (democracy_vdem2000=${iv`i'}) [w=total_gdp2000], robust
// 	eststo: ivreg2 v2xdl_delib2000 (democracy_vdem2000=${iv`i'}) ${base_covariates} [w=total_gdp2000], robust
// }
// esttab using ${path_dropbox}/tables/appendix/2sls_delib2000.tex, replace b(3) se(3) label noconstant mtitle("Unweighted" "GDP-weighted") stats(N, labels("N") fmt(0))

// forvalues i = 1/6{
// 	ivreg2 v2xdl_delib2000 (democracy_vdem2000=${iv`i'}) [w=total_gdp2000], robust
// }

********************************************************************************
*** 2SLS regression: democracy causes decreases in the deliberative component index 

est clear
forvalues i = 1/6{
	eststo: ivreg2 v2xdl_delib_diff_2001_2019 (democracy_vdem2000=${iv`i'}), robust
	eststo: ivreg2 v2xdl_delib_diff_2001_2019 ${base_covariates2000} (democracy_vdem2000=${iv`i'}), robust
}

esttab using ${path_dropbox}/tables/appendix/2sls_delib_diff_2001_2019_unweighted.tex, ///
replace label cells("b(fmt(3))" "se(par fmt(3))" "p(fmt(2))") ///
nodepvars nogaps nonotes nomtitle nostar mlabels(none) keep(democracy_vdem2000) prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') stats(N, labels("N") fmt(0))

est clear
forvalues i = 1/6{
	eststo: ivreg2 v2xdl_delib_diff_2001_2019 (democracy_vdem2000=${iv`i'}) [w=total_gdp2000], robust
	eststo: ivreg2 v2xdl_delib_diff_2001_2019 ${base_covariates2000} (democracy_vdem2000=${iv`i'}) [w=total_gdp2000], robust
	
}
esttab using ${path_dropbox}/tables/appendix/2sls_delib_diff_2001_2019_gdpweighted.tex, ///
replace label cells("b(fmt(3))" "se(par fmt(3))" "p(fmt(2))") ///
nodepvars nogaps nonotes nostar nomtitle mlabels(none) keep(democracy_vdem2000) prefoot(`" IVs & \multicolumn{2}{c}{settler mortality} &  \multicolumn{2}{c}{population density} & \multicolumn{2}{c}{legal origin} & \multicolumn{2}{c}{language} & \multicolumn{2}{c}{crops \& minerals} & \multicolumn{2}{c}{all IVs} \\"' `"Number of IVs & 1 & 1 & 1 & 1 & 1 & 1 & 2 & 2 & 10 & 10 & 15 & 15 \\"') stats(N, labels("N") fmt(0))

