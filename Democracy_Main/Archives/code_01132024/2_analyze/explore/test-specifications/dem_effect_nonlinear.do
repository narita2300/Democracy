
**************************************************************************** Table 1: No weighting  
use ${path_data}/total.dta, clear

***** OLS REGRESSIONS 
est clear
eststo: reg mean_growth_rate_2001_2019 democracy_vdem2000, robust
margins, dydx(democracy_vdem2000) at(democracy_vdem2000=(-2(1)2)) vsquish post
marginsplot, yline(0)

eststo: reg mean_growth_rate_2001_2019 c.democracy_vdem2000##c.democracy_vdem2000, robust
margins, dydx(democracy_vdem2000) at(democracy_vdem2000=(-2(1)2)) vsquish post
marginsplot, yline(0)
// margins, dydx(democracy_vdem2000) at((median) _all) vsquish post

eststo: reg mean_growth_rate_2001_2019 c.democracy_vdem2000##c.democracy_vdem2000##c.democracy_vdem2000, robust
margins, dydx(democracy_vdem2000) at(democracy_vdem2000=(-2(1)2)) vsquish post
marginsplot, yline(0)
predict yhat 
// margins, dydx(democracy_vdem2000) at((median) _all) vsquish post

esttab using ${path_dropbox}/tables/appendix/ols_democracy_growth_nonlinear_noweighting.tex, replace b(3) se(3) noconstant stats(N, labels("N") fmt(0)) drop(_cons) nonotes nomtitle coeflabels(democracy_vdem2000 "Democracy Index" c.democracy_vdem2000#c.democracy_vdem2000 "(Democracy Index)$^2$" c.democracy_vdem2000#c.democracy_vdem2000#c.democracy_vdem2000 "(Democracy Index)$^3$") posthead("& \multicolumn{3}{c}{Mean GDP Growth Rate in 2001-19} \\ \cline{2-4}\\[-1.8ex]")

***** OLS FIGURE
scatter mean_growth_rate_2001_2019 democracy_vdem2000 || lfit mean_growth_rate_2001_2019 democracy_vdem2000 || qfit mean_growth_rate_2001_2019 democracy_vdem2000 || line yhat democracy_vdem2000, sort legend(order(2 "Linear" 3 "Quadratic" 4 "Cubic")) ytitle("Mean GDP Growth Rate in 2001-19") 
graph export ${path_dropbox}/figures/democracy_growth_nonlinear_noweighting.png, replace

***** 2SLS REGRESSIONS
use ${path_data}/total.dta, clear

gen dem2 = democracy_vdem2000*democracy_vdem2000
gen dem3 = democracy_vdem2000*democracy_vdem2000*democracy_vdem2000

forvalues i = 1/2{
	est clear
	gen ${iv`i'}2 = ${iv`i'}*${iv`i'}
	gen ${iv`i'}3 = ${iv`i'}*${iv`i'}*${iv`i'}
	
	eststo: ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv`i'}), robust
	eststo: ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000 dem2 =${iv`i'} ${iv`i'}2), robust
	eststo: ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000 dem2 dem3 =${iv`i'} ${iv`i'}2 ${iv`i'}3), robust

	esttab using ${path_dropbox}/tables/appendix/2sls_democracy_growth_nonlinear_noweighting_panel`i'.tex, replace b(3) se(3) label noconstant stats(N, labels("N") fmt(0)) drop(_cons) nonotes nomtitle coeflabels(democracy_vdem2000 "Democracy Index" dem2 "(Democracy Index)$^2$" dem3 "(Democracy Index)$^3$") posthead("& \multicolumn{3}{c}{Mean GDP Growth Rate in 2001-19} \\ \cline{2-4}\\[-1.8ex]")
}

// Panel A: OLS
// Panel B: Log European Settler Mortality
// Panel C: Log Population Density in 1500s

**************************************************************************** Table 2: GDP-weighting
use ${path_data}/total.dta, clear

***** OLS REGRESSIONS 
est clear
eststo: reg mean_growth_rate_2001_2019 democracy_vdem2000 [w=total_gdp2000], robust
margins, dydx(democracy_vdem2000) at(democracy_vdem2000=(-2(1)2)) vsquish post
marginsplot, yline(0)

eststo: reg mean_growth_rate_2001_2019 c.democracy_vdem2000##c.democracy_vdem2000 [w=total_gdp2000], robust
margins, dydx(democracy_vdem2000) at(democracy_vdem2000=(-2(1)2)) vsquish post
marginsplot, yline(0)

eststo: reg mean_growth_rate_2001_2019 c.democracy_vdem2000##c.democracy_vdem2000##c.democracy_vdem2000 [w=total_gdp2000], robust
margins, dydx(democracy_vdem2000) at(democracy_vdem2000=(-2(1)2)) vsquish post
marginsplot, yline(0)
predict yhat

esttab using ${path_dropbox}/tables/appendix/ols_democracy_growth_nonlinear_gdpweighting.tex, replace b(3) se(3) noconstant stats(N, labels("N") fmt(0)) drop(_cons) nonotes nomtitle coeflabels(democracy_vdem2000 "Democracy Index" c.democracy_vdem2000#c.democracy_vdem2000 "(Democracy Index)$^2$" c.democracy_vdem2000#c.democracy_vdem2000#c.democracy_vdem2000 "(Democracy Index)$^3$") posthead("& \multicolumn{3}{c}{Mean GDP Growth Rate in 2001-19} \\ \cline{2-4}\\[-1.8ex]")

***** OLS FIGURE
scatter mean_growth_rate_2001_2019 democracy_vdem2000 || lfit mean_growth_rate_2001_2019 democracy_vdem2000 [w=total_gdp2000]  || qfit mean_growth_rate_2001_2019 democracy_vdem2000 [w=total_gdp2000]  || line yhat democracy_vdem2000, sort legend(order(2 "Linear" 3 "Quadratic" 4 "Cubic")) ytitle("Mean GDP Growth Rate in 2001-19") 
graph export ${path_dropbox}/figures/democracy_growth_nonlinear_gdpweighting.png, replace

***** 2SLS REGRESSIONS
use ${path_data}/total.dta, clear

gen dem2 = democracy_vdem2000*democracy_vdem2000
gen dem3 = democracy_vdem2000*democracy_vdem2000*democracy_vdem2000

forvalues i = 1/2{
	est clear
	gen ${iv`i'}2 = ${iv`i'}*${iv`i'}
	gen ${iv`i'}3 = ${iv`i'}*${iv`i'}*${iv`i'}
	
	eststo: ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv`i'}) [w=total_gdp2000], robust
	eststo: ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000 dem2 =${iv`i'} ${iv`i'}2) [w=total_gdp2000], robust
	eststo: ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000 dem2 dem3 =${iv`i'} ${iv`i'}2 ${iv`i'}3) [w=total_gdp2000], robust
	esttab using ${path_dropbox}/tables/appendix/2sls_democracy_growth_nonlinear_gdpweighting_panel`i'.tex, replace b(3) se(3) label noconstant stats(N, labels("N") fmt(0)) drop(_cons) nonotes nomtitle coeflabels(democracy_vdem2000 "Democracy Index" dem2 "(Democracy Index)$^2$" dem3 "(Democracy Index)$^3$") posthead("& \multicolumn{3}{c}{Mean GDP Growth Rate in 2001-19} \\ \cline{2-4}\\[-1.8ex]")
}

// Panel A: OLS
// Panel B: Log European Settler Mortality
// Panel C: Log Population Density in 1500s



