
*** load data 
use "./output/total.dta", replace

ivregress 2sls gdp_growth2020 (democracy_csp2018=logem)[w=total_gdp2019], vce(robust)
ivregress 2sls mean_growth_rate_2001_2019 (democracy_csp2000=logem)[w=total_gdp2000], vce(robust)
ivregress 2sls total_deaths_per_million (democracy_csp2018=logem)[w=total_gdp2019], vce(robust)

gen dem_effect_gdp_2020 = democracy_csp2018 * -3.6
label variable dem_effect_gdp_2020 "Democracy's Estimated Effect"

gen dem_effect_gdp_2001_2019 = democracy_csp2000 * -3.0
label variable dem_effect_gdp_2001_2019 "Democracy's Estimated Effect"

gen dem_effect_deaths = democracy_csp2018 * 538
label variable dem_effect_deaths "Democracy's Estimated Effect"

gen no_dem_gdp_2020 = gdp_growth2020 - dem_effect_gdp_2020
label variable no_dem_gdp_2020 "After Subtracting Democracy's Effect"

gen no_dem_gdp_2001_2019 = mean_growth_rate_2001_2019 - dem_effect_gdp_2001_2019
label variable no_dem_gdp_2001_2019 "After Subtracting Democracy's Effect"

gen no_dem_deaths = total_deaths_per_million - dem_effect_deaths
label variable no_dem_deaths "After Subtracting Democracy's Effect"

eststo clear
bysort continent: eststo: quietly estpost summarize gdp_growth2020 dem_effect_gdp_2020 no_dem_gdp_2020 mean_growth_rate_2001_2019 dem_effect_gdp_2001_2019 no_dem_gdp_2001_2019 total_deaths_per_million  dem_effect_deaths no_dem_deaths
esttab using dem_effect.tex, cells("mean(fmt(1))") label replace nodepvars nogaps nonotes
