********************************************************************************
* Table : Comparison by continent
********************************************************************************

clear

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data

*** Load data 
// use "/Users/ayumis/Dropbox/Democracy/MainAnalysis/output/total.dta", replace
use ${path_output}/total.dta, replace

ivregress 2sls gdp_growth2020 (${dem2019}=${iv1})${weight2019}, vce(robust)
matrix list e(b)
gen coef1 = e(b)[1,1]

ivregress 2sls mean_growth_rate_2001_2019 (${dem2000}=${iv1})${weight2000}, vce(robust)
matrix list e(b)
gen coef2 = e(b)[1,1]


ivregress 2sls total_deaths_per_million (${dem2019}=${iv1})${weight2019}, vce(robust)

matrix list e(b)
gen coef3 = e(b)[1,1]

label variable gdp_growth2020 "Observed Mean"
label variable mean_growth_rate_2001_2019 "Observed Mean"
label variable total_deaths_per_million "Observed Mean"

replace continent="N. America" if continent=="North America"
replace continent="S. America" if continent=="South America"

gen dem_effect_gdp_2020 = ${dem2019} * coef1
label variable dem_effect_gdp_2020 "Democracy's Estimated Effect"

gen dem_effect_gdp_2001_2019 = ${dem2000} * coef2
label variable dem_effect_gdp_2001_2019 "Democracy's Estimated Effect"

gen dem_effect_deaths = ${dem2019} * coef3
label variable dem_effect_deaths "Democracy's Estimated Effect"

gen no_dem_gdp_2020 = gdp_growth2020 - dem_effect_gdp_2020
label variable no_dem_gdp_2020 "(Observed Mean) - (Democracy's Estimated Effect)"

gen no_dem_gdp_2001_2019 = mean_growth_rate_2001_2019 - dem_effect_gdp_2001_2019
label variable no_dem_gdp_2001_2019 "(Observed Mean) - (Democracy's Estimated Effect)"

gen no_dem_deaths = total_deaths_per_million - dem_effect_deaths
label variable no_dem_deaths "(Observed Mean) - (Democracy's Estimated Effect)"

eststo clear
bysort continent: eststo: quietly estpost summarize gdp_growth2020 dem_effect_gdp_2020 no_dem_gdp_2020 mean_growth_rate_2001_2019 dem_effect_gdp_2001_2019 no_dem_gdp_2001_2019 total_deaths_per_million  dem_effect_deaths no_dem_deaths
esttab using ./output/tables/tableA3.tex, cells("mean(fmt(1))") stats(N, fmt(0) labels("N")) label collabels(none) replace nodepvars nogaps nonotes
