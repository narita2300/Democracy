

clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data
cd ${path_dropbox}/figures


*** Load data 
use ${path_data}/total.dta, replace

***** TABLE 2 *****

gen g7 = 0
replace g7 = 1 if countries == "France" | countries =="United States" | countries == "Germany" | countries == "Japan" | countries == "United Kingdom" | countries == "Canada" | countries == "Italy"


**************************** GDP GROWTH IN 2020 *******************************
foreach var in gdp_growth2020 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem2019}=${iv`i'})${weight2019}, vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2019}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on GDP Growth Rate in 2020") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_coef_plot.png, as(png) name("Graph") replace

// Baseline controls
foreach var in gdp_growth2020 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' ${base_covariates2019} (${dem2019}=${iv`i'}) ${weight2019}, vce(robust)
		}
}

coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on GDP Growth Rate in 2020") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_coef_plot_controls.png, as(png) name("Graph") replace

// GDP per capita control
foreach var in gdp_growth2020 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' gdppc2019 (${dem2019}=${iv`i'}) ${weight2019}, vce(robust)
		}
}

coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on GDP Growth Rate in 2020") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_coef_plot_gdppc_control.png, as(png) name("Graph") replace

// total GDP control
foreach var in gdp_growth2020 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' total_gdp2019 (${dem2019}=${iv`i'}) ${weight2019}, vce(robust)
		}
}

coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on GDP Growth Rate in 2020") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_coef_plot_total_gdp_control.png, as(png) name("Graph") replace

// index: csp
foreach var in gdp_growth2020 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (democracy_csp2018=${iv`i'})${weight2019}, vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2019}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(democracy_csp2018) rename(democracy_csp2018 = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(democracy_csp2018) rename(democracy_csp2018 = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(democracy_csp2018) rename(democracy_csp2018 = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(democracy_csp2018) rename(democracy_csp2018 = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(democracy_csp2018) rename(democracy_csp2018 = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on GDP Growth Rate in 2020") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_coef_plot_csp_index.png, as(png) name("Graph") replace

// index: eiu
foreach var in gdp_growth2020 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (democracy_eiu2019=${iv`i'})${weight2019}, vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2019}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(democracy_eiu2019) rename(democracy_eiu2019 = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(democracy_eiu2019) rename(democracy_eiu2019 = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(democracy_eiu2019) rename(democracy_eiu2019 = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(democracy_eiu2019) rename(democracy_eiu2019 = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(democracy_eiu2019) rename(democracy_eiu2019 = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on GDP Growth Rate in 2020") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_coef_plot_eiu_index.png, as(png) name("Graph") replace

// index: freedom house 
foreach var in gdp_growth2020 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (democracy_fh2019=${iv`i'})${weight2019}, vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2019}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(democracy_fh2019) rename(democracy_fh2019 = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(democracy_fh2019) rename(democracy_fh2019 = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(democracy_fh2019) rename(democracy_fh2019 = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(democracy_fh2019) rename(democracy_fh2019 = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(democracy_fh2019) rename(democracy_fh2019 = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on GDP Growth Rate in 2020") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_coef_plot_fh_index.png, as(png) name("Graph") replace

// no weighting 
foreach var in gdp_growth2020 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem2019}=${iv`i'}), vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2019}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on GDP Growth Rate in 2020") 
graph export ${path_presentation}/gdp_coef_plot_no_weighting.png, as(png) name("Graph") replace

// pop weighting 
foreach var in gdp_growth2020 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem2019}=${iv`i'}) [w=population2019], vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2019}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on GDP Growth Rate in 2020") 
graph export ${path_presentation}/gdp_coef_plot_pop_weighting.png, as(png) name("Graph") replace

foreach var in gdp_growth2020 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem2019}=${iv`i'})${weight2019} if !g7, vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2019}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on GDP Growth Rate in 2020") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_coef_plot_remove_g7.png, as(png) name("Graph") replace

foreach var in gdp_growth2020 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem2019}=${iv`i'})${weight2019} if countries != "China" & countries != "United States", vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2019}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on GDP Growth Rate in 2020") xscale(range(-5 5)) xlabel(-5(1)5)
// (m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
graph export ${path_presentation}/gdp_coef_plot_removeUSChina.png, as(png) name("Graph") replace


foreach var in gdp_growth2020 {
	eststo clear
	forv i = 1/5{
					ivreg2 `var' (${dem2019}=${iv`i'})${weight2019}, robust
					predict yhat
					gen resid = `outcome' - yhat
					egen resid_std = std(resid)
					eststo m`i': ivreg2 `var' (${dem2019}=${iv`i'})${weight2019} if resid_std<=1.96 & resid_std>=-1.96, robust
					drop yhat resid resid_std
	}
}

coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on GDP Growth Rate in 2020") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_coef_plot_remove_outliers.png, as(png) name("Graph") replace
	
**************************** GDP GROWTH IN 2001-2019 *******************************

foreach var in mean_growth_rate_2001_2019 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem2000}=${iv`i'})${weight2000}, vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2000}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2000}) rename(${dem2000} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Mean GDP Growth Rate in 2001-2019") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_21st_coef_plot.png, as(png) name("Graph") replace

// Baseline controls
foreach var in mean_growth_rate_2001_2019 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' ${base_covariates2000} (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
		}
}

coefplot (m1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2000}) rename(${dem2000} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Mean GDP Growth Rate in 2001-2019") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_21st_coef_plot_controls.png, as(png) name("Graph") replace

// GDP Per Capita control
foreach var in mean_growth_rate_2001_2019 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' gdppc2000 (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
		}
}

coefplot (m1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2000}) rename(${dem2000} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Mean GDP Growth Rate in 2001-2019") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_21st_coef_plot_gdppc_control.png, as(png) name("Graph") replace

// GDP Per Capita control
foreach var in mean_growth_rate_2001_2019 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' total_gdp2000 (${dem2000}=${iv`i'}) ${weight2000}, vce(robust)
		}
}

coefplot (m1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2000}) rename(${dem2000} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Mean GDP Growth Rate in 2001-2019") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_21st_coef_plot_total_gdp_control.png, as(png) name("Graph") replace

// index: polity index
foreach var in mean_growth_rate_2001_2019 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (democracy_csp2000=${iv`i'})${weight2000}, vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2019}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(democracy_csp2000) rename(democracy_csp2000 = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(democracy_csp2000) rename(democracy_csp2000 = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(democracy_csp2000) rename(democracy_csp2000 = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(democracy_csp2000) rename(democracy_csp2000 = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(democracy_csp2000) rename(democracy_csp2000 = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Mean GDP Growth Rate in 2001-2019") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_21st_coef_plot_csp_index.png, as(png) name("Graph") replace

// index: EIU
foreach var in mean_growth_rate_2001_2019 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (democracy_eiu2006=${iv`i'})${weight2000}, vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2019}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(democracy_eiu2006) rename(democracy_eiu2006 = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(democracy_eiu2006) rename(democracy_eiu2006 = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(democracy_eiu2006) rename(democracy_eiu2006 = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(democracy_eiu2006) rename(democracy_eiu2006 = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(democracy_eiu2006) rename(democracy_eiu2006 = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Mean GDP Growth Rate in 2001-2019") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_21st_coef_plot_eiu_index.png, as(png) name("Graph") replace


// index: Freedom House
foreach var in mean_growth_rate_2001_2019 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (democracy_fh2003=${iv`i'})${weight2000}, vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2019}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(democracy_fh2003) rename(democracy_fh2003 = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(democracy_fh2003) rename(democracy_fh2003 = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(democracy_fh2003) rename(democracy_fh2003 = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(democracy_fh2003) rename(democracy_fh2003 = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(democracy_fh2003) rename(democracy_fh2003 = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Mean GDP Growth Rate in 2001-2019") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_21st_coef_plot_fh_index.png, as(png) name("Graph") replace

// no weighting
foreach var in mean_growth_rate_2001_2019 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem2000}=${iv`i'}), vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2000}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2000}) rename(${dem2000} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Mean GDP Growth Rate in 2001-2019") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_21st_coef_plot_no_weighting.png, as(png) name("Graph") replace

// pop weighting
foreach var in mean_growth_rate_2001_2019 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem2000}=${iv`i'}) [w=population2019], vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2000}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2000}) rename(${dem2000} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Mean GDP Growth Rate in 2001-2019") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_21st_coef_plot_pop_weighting.png, as(png) name("Graph") replace

foreach var in mean_growth_rate_2001_2019 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem2000}=${iv`i'})${weight2000} if !g7, vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2000}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2000}) rename(${dem2000} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Mean GDP Growth Rate in 2001-2019") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_21st_coef_plot_remove_g7.png, as(png) name("Graph") replace

foreach var in mean_growth_rate_2001_2019 {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem2000}=${iv`i'})${weight2000} if countries != "China" & countries != "United States", vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2000}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2000}) rename(${dem2000} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Mean GDP Growth Rate in 2001-2019") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_21st_coef_plot_removeUSChina.png, as(png) name("Graph") replace

// (m3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///


foreach var in mean_growth_rate_2001_2019 {
	eststo clear
	forv i = 1/5{
					ivreg2 `var' (${dem2000}=${iv`i'})${weight2000}, robust
					predict yhat
					gen resid = `outcome' - yhat
					egen resid_std = std(resid)
					eststo m`i': ivreg2 `var' (${dem2000}=${iv`i'})${weight2000} if resid_std<=1.96 & resid_std>=-1.96, robust
					drop yhat resid resid_std
	}
}

coefplot (m1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2000}) rename(${dem2000} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Mean GDP Growth Rate in 2001-2019") xscale(range(-5 5)) xlabel(-5(1)5)

graph export ${path_presentation}/gdp_21st_coef_plot_remove_outliers.png, as(png) name("Graph") replace


**************************** COVID-19 DEATHS IN 2020 *******************************

foreach var in total_deaths_per_million {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem2019}=${iv`i'})${weight2019}, vce(robust)
		}
}

coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Covid-19 Deaths Per Million in 2020") xscale(r(-100 800)) xlabel(0(200)800)

graph export ${path_presentation}/deaths_coef_plot.png, as(png) name("Graph") replace

// Baseline controls
foreach var in total_deaths_per_million {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, vce(robust)
		}
}

coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Covid-19 Deaths Per Million in 2020") xscale(r(-100 800)) xlabel(0(200)800)

graph export ${path_presentation}/deaths_coef_plot_controls.png, as(png) name("Graph") replace

// index: polity index
foreach var in  total_deaths_per_million{
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (democracy_csp2018=${iv`i'})${weight2019}, vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2019}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(democracy_csp2018) rename(democracy_csp2018 = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(democracy_csp2018) rename(democracy_csp2018 = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(democracy_csp2018) rename(democracy_csp2018 = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(democracy_csp2018) rename(democracy_csp2018 = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(democracy_csp2018) rename(democracy_csp2018 = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Covid-19 Deaths Per Million in 2020") 

graph export ${path_presentation}/deaths_coef_plot_csp_index.png, as(png) name("Graph") replace

// index: EIU 
foreach var in  total_deaths_per_million{
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (democracy_eiu2019=${iv`i'})${weight2019}, vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2019}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(democracy_eiu2019) rename(democracy_eiu2019 = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(democracy_eiu2019) rename(democracy_eiu2019 = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(democracy_eiu2019) rename(democracy_eiu2019 = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(democracy_eiu2019) rename(democracy_eiu2019 = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(democracy_eiu2019) rename(democracy_eiu2019 = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Covid-19 Deaths Per Million in 2020") 

graph export ${path_presentation}/deaths_coef_plot_eiu_index.png, as(png) name("Graph") replace

// index: Freedom House
foreach var in  total_deaths_per_million{
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (democracy_fh2019=${iv`i'})${weight2019}, vce(robust)
		}
		// esttab using ./output/tables/all/all.csv, keep(${dem2019}) append label b(a1) se(a1) nodepvars nolines nogaps nonotes compress plain
}

coefplot (m1,  keep(democracy_fh2019) rename(democracy_fh2019 = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(democracy_fh2019) rename(democracy_fh2019 = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(democracy_fh2019) rename(democracy_fh2019 = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(democracy_fh2019) rename(democracy_fh2019 = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(democracy_fh2019) rename(democracy_fh2019 = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Covid-19 Deaths Per Million in 2020") 

graph export ${path_presentation}/deaths_coef_plot_fh_index.png, as(png) name("Graph") replace

// no weighting
foreach var in total_deaths_per_million {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem2019}=${iv`i'}), vce(robust)
		}
}

coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Covid-19 Deaths Per Million in 2020") xscale(r(-100 800)) xlabel(0(200)800)

graph export ${path_presentation}/deaths_coef_plot_no_weighting.png, as(png) name("Graph") replace

// pop weighting
foreach var in total_deaths_per_million {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem2019}=${iv`i'}) [w=population2019], vce(robust)
		}
}

coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Covid-19 Deaths Per Million in 2020") xscale(r(-100 800)) xlabel(0(200)800)

graph export ${path_presentation}/deaths_coef_plot_pop_weighting.png, as(png) name("Graph") replace

foreach var in total_deaths_per_million {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem2019}=${iv`i'})${weight2019} if !g7, vce(robust)
		}
}

coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Covid-19 Deaths Per Million in 2020") xscale(r(-100 800)) xlabel(0(200)800)

graph export ${path_presentation}/deaths_coef_plot_remove_g7.png, as(png) name("Graph") replace

foreach var in total_deaths_per_million {
	eststo clear
	forv i = 1/5{
		eststo m`i': ivregress 2sls `var' (${dem2019}=${iv`i'})${weight2019} if countries != "China" & countries !="United States", vce(robust)
		}
}

coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Covid-19 Deaths Per Million in 2020") xscale(r(-100 800)) xlabel(0(200)800)
// (m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///

graph export ${path_presentation}/deaths_coef_plot_removeUSChina.png, as(png) name("Graph") replace

foreach var in total_deaths_per_million {
	eststo clear
	forv i = 1/5{
					ivreg2 `var' (${dem2019}=${iv`i'})${weight2019}, robust
					predict yhat
					gen resid = `outcome' - yhat
					egen resid_std = std(resid)
					eststo m`i': ivreg2 `var' (${dem2019}=${iv`i'})${weight2019} if resid_std<=1.96 & resid_std>=-1.96, robust
					drop yhat resid resid_std
	}
}

coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
(m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
(m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
, xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on GDP Growth Rate in 2020") 

graph export ${path_presentation}/deaths_coef_plot_remove_outliers.png, as(png) name("Graph") replace

// ***** TABLE 3 *****
// clear

// *** Change to appropriate directory
// // cd YOUR-DIRECTORY/replication_data
// // ex) cd /Users/ayumis/Desktop/replication_data

// *** Load data 
// use ${path_output}/total.dta, replace

// *** Make sample consistent across mechanism variables
// drop if containmenthealth10==. | coverage10 ==. | days_betw_10th_case_and_policy ==.


// foreach var in containmenthealth10 {
// 	eststo clear
// 	forv i = 1/5{
// 		eststo m`i': ivregress 2sls `var' ${base_covariates2019} (${dem2019}=${iv`i'}) ${weight2019}, vce(robust)
// 	}
// }

// coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
// (m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// (m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// (m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// (m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// , xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Severity of Initial Policy") xscale(range(-0.5 0.1))

// graph export ${path_presentation}/severity_coef_plot.png, as(png) name("Graph") replace

// foreach var in coverage10{
// 	eststo clear
// 	forv i = 1/5{
// 		eststo m`i': ivregress 2sls `var' ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, vce(robust)
// 	}
// }

// coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
// (m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// (m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// (m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// (m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// , xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Coverage of Initial Policy") xscale(range(-20 10))

// graph export ${path_presentation}/coverage_coef_plot.png, as(png) name("Graph") replace


// foreach var in days_betw_10th_case_and_policy {
// 	eststo clear
// 	forv i = 1/5{
// 		eststo m`i': ivregress 2sls `var' ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, vce(robust)
// 	}
// }


// coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) offset(-0.05)) ///
// (m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// (m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// (m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// (m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue))) ///
// , xline(0) legend(off) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Democracy's Effect on Speed of Initial Policy") 

// graph export ${path_presentation}/speed_coef_plot.png, as(png) name("Graph") replace



