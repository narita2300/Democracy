
*** import population data
import excel ${path_input}/controls/population/WPP2019_POP_F01_1_TOTAL_POPULATION_BOTH_SEXES.xlsx, sheet("ESTIMATES") cellrange(A17:BZ306) firstrow clear

keep if Index>=27
keep if Type=="Country/Area"
keep Regionsubregioncountryorar Countrycode BZ
rename BZ population
rename Regionsubregioncountryorar country

kountry country, from(other)
destring population, replace

replace population = population/1000

save ${path_output}/data/population.dta, replace

*** merge with countries data 
use ${path_output}/data/countries.dta, replace
merge 1:1 NAMES_STD using ${path_output}/data/population.dta
drop if _merge==2
keep countries iso3 NAMES_STD population 

*** save
save ${path_output}/data/population.dta, replace
