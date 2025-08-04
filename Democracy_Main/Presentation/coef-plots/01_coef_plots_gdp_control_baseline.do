
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data
cd ${path_dropbox}/figures

*** Load data 
use ${path_data}/total.dta, replace


**************************** GDP PER CAPITA GROWTH IN 2020 *******************************
foreach var in gdppc_growth2020 {
	eststo clear
	forv i = 1/6{
		if `i' == 6{
			eststo r`i': reg `var' ${dem2019} ${base_covariates2019} if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. ${weight2019}, vce(robust)
		}
		else {
			eststo r`i': reg `var' ${dem2019} ${base_covariates2019} if `:word 1 of ${iv`i'}' !=. ${weight2019}, vce(robust)
		}
		
		eststo m`i': ivregress 2sls `var' ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, vce(robust)
	}
}

coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r2,  keep(${dem2019}) rename(${dem2019} = "Population Density IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r3,  keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r4,  keep(${dem2019}) rename(${dem2019} = "Language IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r5,  keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m6, keep(${dem2019}) rename(${dem2019} = "All IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r6,  keep(${dem2019}) rename(${dem2019} = "All IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
, xline(0) graphregion(color(white)) mlabel format(%9.2g) xtitle("GDP Per Capita Growth Rate in 2020") xscale(range(-5 5)) xlabel(-5(1)5) title("Effect of 1 s.d. democracy increase on economic growth in 2020", span ) subtitle("Add baseline controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI")) caption("Baseline controls: absolute latitude, mean temperature, mean precipitation, population density, median age, and diabetes prevalence", span size(vsmall)) 

graph export ${path_presentation}/gdppc_coef_plot_baseline_controls.png, as(png) name("Graph") replace


**************************** GDP PER CAPITA GROWTH IN 2001-2019 *******************************

foreach var in mean_gdppc_growth_2001_2019 {
	eststo clear
	forv i = 1/6{
		if `i' == 6{
			eststo r`i': reg `var' ${dem2000} ${base_covariates2000} if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. ${weight2000}, vce(robust)
		}
		else {
			eststo r`i': reg `var' ${dem2000} ${base_covariates2000} if `:word 1 of ${iv`i'}' !=. ${weight2000}, vce(robust)
		}
		eststo m`i': ivregress 2sls `var'  ${base_covariates2000} (${dem2000}=${iv`i'})${weight2000}, vce(robust)
		}
}

coefplot (m1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r1,  keep(${dem2000}) rename(${dem2000} = "Settler Mortality IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m2, keep(${dem2000}) rename(${dem2000} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r2,  keep(${dem2000}) rename(${dem2000} = "Population Density IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m3, keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r3,  keep(${dem2000}) rename(${dem2000} = "Legal Origin IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m4, keep(${dem2000}) rename(${dem2000} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r4,  keep(${dem2000}) rename(${dem2000} = "Language IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m5, keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r5,  keep(${dem2000}) rename(${dem2000} = "Crops & Minerals IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m6, keep(${dem2000}) rename(${dem2000} = "All IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r6,  keep(${dem2000}) rename(${dem2000} = "All IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Mean GDP Per Capita Growth Rate in 2001-2019") xscale(range(-5 5)) xlabel(-5(1)5) title("Effect of 1 s.d. democracy increase on economic growth in 21st century", span size(medium)) subtitle("Add baseline controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI")) caption("Baseline controls: absolute latitude, mean temperature, mean precipitation, population density, and median age", span size(vsmall)) 

graph export ${path_presentation}/gdppc_21st_coef_plot_baseline_controls.png, as(png) name("Graph") replace

**************************** COVID-19 DEATHS IN 2020 *******************************

foreach var in total_deaths_per_million {
	eststo clear
	forv i = 1/6{
		if `i' == 6{
			eststo r`i': reg `var' ${dem2019} ${base_covariates2019} if logem != . & lpd1500s !=. & legor_uk !=. & EurFrac !=. & bananas!=. & copper !=. ${weight2019}, vce(robust)
		}
		else {
			eststo r`i': reg `var' ${dem2019} ${base_covariates2019} if `:word 1 of ${iv`i'}' !=. ${weight2019}, vce(robust)
		}
		eststo m`i': ivregress 2sls `var'  ${base_covariates2019} (${dem2019}=${iv`i'})${weight2019}, vce(robust)
		}
}

coefplot (m1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r1,  keep(${dem2019}) rename(${dem2019} = "Settler Mortality IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m2, keep(${dem2019}) rename(${dem2019} = "Population Density IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r2,  keep(${dem2019}) rename(${dem2019} = "Population Density IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m3, keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r3,  keep(${dem2019}) rename(${dem2019} = "Legal Origin IV") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m4, keep(${dem2019}) rename(${dem2019} = "Language IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r4,  keep(${dem2019}) rename(${dem2019} = "Language IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m5, keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r5,  keep(${dem2019}) rename(${dem2019} = "Crops & Minerals IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
(m6, keep(${dem2019}) rename(${dem2019} = "All IVs") mcolor(edkblue) ciopts(lcolor(edkblue)) mlabcolor(edkblue) mlabposition(12) ) ///
(r6,  keep(${dem2019}) rename(${dem2019} = "All IVs") offset(-0.2)  mlabposition(7)   mcolor(gs10) ciopts(lcolor(gs10)) mlabcolor(gs10)) ///
, xline(0) graphregion(color(white)) mlabel mlabposition(12) mlabcolor(edkblue) format(%9.2g) xtitle("Covid-19 Deaths Per Million in 2020") xscale(r(-100 800)) xlabel(0(200)800) title("Effect of 1 s.d. democracy increase on Covid-19 mortality in 2020", span size(medium)) subtitle("Add baseline controls", span margin(b=5)) legend(order(2 "2SLS" 4 "OLS" 1 "95% CI")) caption("Baseline controls: absolute latitude, mean temperature, mean precipitation, population density, median age, and diabetes prevalence", span size(vsmall)) 
graph export ${path_presentation}/deaths_coef_plot_baseline_controls.png, as(png) name("Graph") replace

