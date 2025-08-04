
*** import data
import excel ${path_input}/controls/population_density/WPP2019_POP_F06_POPULATION_DENSITY.xlsx, sheet("ESTIMATES") cellrange(A17:BZ306) firstrow clear
keep if Type=="Country/Area"
keep Regionsubregioncountryorar Countrycode BZ
rename BZ pop_density

kountry Regionsubregioncountryorar, from(other)
destring pop_density, replace

save ${path_output}/data/population_density.dta, replace

*** merge with countries data 
use ${path_output}/data/countries.dta, replace

merge 1:1 NAMES_STD using ${path_output}/data/population_density.dta
drop if _merge==2

keep countries iso3 NAMES_STD pop_density

*** save
save ${path_output}/data/population_density.dta, replace
