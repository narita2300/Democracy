
*** import countries data 
use ${path_data}/countries.dta, replace

*** merge with freedom_house.dta
merge 1:1 NAMES_STD using ${path_data}/freedom_house.dta, nogenerate

*** merge with systemic_peace.dta
merge 1:1 NAMES_STD using ${path_data}/systemic_peace.dta, nogenerate

*** merge with economist.dta
merge 1:1 NAMES_STD using ${path_data}/economist.dta, nogenerate

*** merge with economist.dta
merge 1:1 NAMES_STD using ${path_data}/vdem.dta, nogenerate

*** save data
save ${path_data}/democracy.dta, replace
