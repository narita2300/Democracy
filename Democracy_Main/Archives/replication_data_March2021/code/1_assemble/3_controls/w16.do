
*** import countries data 
use ${path_output}/data/countries.dta, replace

*** merge with population.dta
merge 1:1 NAMES_STD using ${path_output}/data/population.dta, nogenerate

*** merge with total_gdp.dta
merge 1:1 NAMES_STD using ${path_output}/data/total_gdp.dta, nogenerate

*** merge with latitude.dta
merge 1:1 NAMES_STD using ${path_output}/data/latitude.dta, nogenerate

*** merge with temperature.dta
merge 1:1 NAMES_STD using ${path_output}/data/temperature.dta, nogenerate

*** merge with precipitation.dta
merge 1:1 NAMES_STD using ${path_output}/data/precipitation.dta, nogenerate

*** merge with population_density.dta
merge 1:1 NAMES_STD using ${path_output}/data/population_density.dta, nogenerate

*** merge with median_age.dta
merge 1:1 NAMES_STD using ${path_output}/data/median_age.dta, nogenerate

*** merge with diabetes.dta
merge 1:1 NAMES_STD using ${path_output}/data/diabetes.dta, nogenerate

*** save data
save ${path_output}/data/controls.dta, replace
