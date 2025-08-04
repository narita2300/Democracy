
*** import population density data
import excel ${path_input}/controls/population_density/WPP2019_POP_F06_POPULATION_DENSITY.xlsx, sheet("ESTIMATES") cellrange(A17:BZ306) firstrow clear

local y 1950
foreach v of varlist H-BZ {
rename `v' pop_density`y'
label variable pop_density`y' "Population Density in `y'"
local y = `y'+1
}

keep if Type=="Country/Area"
// keep Regionsubregioncountryorar pop_density2000 pop_density2020
kountry Regionsubregioncountryorar, from(other)
destring pop_density*, replace
drop Regionsubregioncountryorar

save ${path_data}/population_density.dta, replace

*** merge with countries data 
use ${path_data}/countries.dta, replace

merge 1:1 NAMES_STD using ${path_data}/population_density.dta
drop if _merge==2
keep countries iso3 NAMES_STD pop_density*

*** save
save ${path_data}/population_density.dta, replace
