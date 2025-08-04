
*** import countries data 
use ${path_data}/countries.dta, replace

*** merge with settler_mortality.dta
merge 1:1 NAMES_STD using ${path_data}/settler_mortality.dta, nogenerate

*** merge with lang_frankelromer.dta 
merge 1:1 NAMES_STD using ${path_data}/lang_frankelromer.dta, nogenerate

*** merge with legal_origin.dta 
merge 1:1 NAMES_STD using ${path_data}/legal_origin.dta, nogenerate

*** merge with crops_minerals.dta 
merge 1:1 NAMES_STD using ${path_data}/crops_minerals.dta, nogenerate

*** merge with pop_density.dta 
merge 1:1 NAMES_STD using ${path_data}/pop_density.dta, nogenerate

*** merge with urbanization in 1500s data
merge 1:1 NAMES_STD using ${path_data}/urban1500.dta, nogenerate

*** convert strings to numeric 
destring *Frac, replace
destring logFrankRom, replace ignore("NaN")
destring legor*, replace

*** save data
save ${path_data}/IVs.dta, replace
