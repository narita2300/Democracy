
*** import countries data 
use ${path_output}/data/countries.dta, replace

*** merge with freedom_house.dta
merge 1:1 NAMES_STD using ${path_output}/data/freedom_house.dta, nogenerate

*** merge with systemic_peace.dta
merge 1:1 NAMES_STD using ${path_output}/data/systemic_peace.dta, nogenerate

*** merge with economist.dta
merge 1:1 NAMES_STD using ${path_output}/data/economist.dta, nogenerate

*** save data
save ${path_output}/data/democracy.dta, replace
