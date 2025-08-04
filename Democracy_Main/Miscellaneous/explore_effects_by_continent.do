// Goal: make a new dataset with the estimated effect of democratic political systems on GDP growth rates and Covid-19-related deaths per million

*** prepare the continent data for merge ***
import delimited "/Users/ayumis/Desktop/replication_data/random/country_continent.csv", delimiter(comma) varnames(10) rowrange(11) clear 

kountry three_letter_country_code, from(iso3c) 
keep NAMES_STD continent_name

save "/Users/ayumis/Desktop/replication_data/random/country_continent.dta", replace

*** load data 
use "/Users/ayumis/Desktop/replication_data/output/total.dta", replace
 
merge m:m NAMES_STD using /Users/ayumis/Desktop/replication_data/random/country_continent.dta
drop if _merge==2
drop _merge

egen continent = group(continent_name)

gen europe = 1 if continent_name=="Europe" 
replace europe = 0 if continent_name!= "Europe"

gen asia = 1 if continent_name=="Asia" 
replace asia = 0 if continent_name!= "Asia" 

gen africa = 1 if continent_name=="Africa" 
replace africa = 0 if continent_name!= "Africa" 


// First calculate the baseline regression result:
regress gdp_growth europe [w=total_gdp], vce(robust)
regress gdp_growth europe democracy_fh [w=total_gdp], vce(robust)

regress total_deaths_per_million western [w=total_gdp], vce(robust)
regress total_deaths_per_million western democracy_fh [w=total_gdp], vce(robust)

ivregress 2sls gdp_growth (democracy_fh=logem)[w=total_gdp], vce(robust)
ivregress 2sls total_deaths_per_million (democracy_fh=logem)[w=total_gdp], vce(robust)

ivregress 2sls gdp_growth i.continent (democracy_fh=logem)[w=total_gdp], vce(robust)
ivregress 2sls total_deaths_per_million i.continent (democracy_fh=logem)[w=total_gdp], vce(robust)

ivregress 2sls gdp_growth europe asia africa (democracy_fh=logem)[w=total_gdp], vce(robust)
ivregress 2sls total_deaths_per_million europe asia africa (democracy_fh=logem)[w=total_gdp], vce(robust)

******************************************************************************
ivregress 2sls gdp_growth (democracy_fh=logem)[w=total_gdp], vce(robust)
predict pred_gdp_growth

ivregress 2sls total_deaths_per_million (democracy_fh=logem)[w=total_gdp], vce(robust)
predict pred_deaths

gen dem_effect_gdp = democracy_fh * -3.1
gen dem_effect_deaths = democracy_fh * 441
gen no_dem_gdp = gdp_growth - dem_effect_gdp
gen no_dem_deaths = total_deaths_per_million - dem_effect_deaths

eststo clear
by continent_name: eststo: quietly estpost summarize gdp_growth no_dem_gdp total_deaths_per_million no_dem_deaths
esttab using gdp_effect.csv, cells("mean") label nodepvar replace wide r(coefs, transpose)

// Generate the average of GDP growth rates and Covid-19 related deaths per million by continent
eststo clear
tabstat gdp_growth no_dem_gdp total_deaths_per_million no_dem_deaths, by(continent_name)
eststo: estpost tabstat gdp_growth no_dem_gdp total_deaths_per_million no_dem_deaths, by(continent_name) stat(mean)

eststo clear
tabstat gdp_growth total_deaths_per_million, by(continent_name)
eststo: estpost tabstat gdp_growth, by(continent_name) stat(mean)


bysort continent_name: eststo: quietly estpost summarize
tabstat gdp_growth total_deaths_per_million no_dem_gdp no_dem_deaths, by(continent_name)
bysort continent_name: eststo: tabstat gdp_growth total_deaths_per_million
esttab using gdp_effect.csv, replace


tabstat gdp_growth no_dem_gdp, by(continent_name)
tabstat total_deaths_per_million no_dem_deaths, by(continent_name)


