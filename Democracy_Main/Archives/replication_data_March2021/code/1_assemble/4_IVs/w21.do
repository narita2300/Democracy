
*** import data
use ${path_input}/IVs/pop_density/unbundle.dta, clear

keep shortnam country lpd1500s
kountry shortnam, from(iso3c)

save ${path_output}/data/pop_density.dta, replace

*** merge with country data
use ${path_output}/data/countries.dta, replace
merge 1:1 NAMES_STD using ${path_output}/data/pop_density.dta
drop if _merge==2
drop _merge 
keep countries iso3 NAMES_STD lpd1500s

save ${path_output}/data/pop_density.dta, replace

*** import data for urbanization in 1500s ***
use ${path_input}/IVs/pop_density/maketable8.dta
keep shortnam sjb1500
keep if shortnam!=""
kountry shortnam, from(iso3c)

save ${path_output}/data/urban1500.dta, replace

*** merge with country data 
use ${path_output}/data/countries.dta, replace
merge 1:m NAMES_STD using ${path_output}/data/urban1500.dta
drop if _merge==2
bysort NAMES_STD: gen dup = cond(_N==1,0,_n)
drop if dup==2
keep countries iso3 NAMES_STD sjb1500
rename sjb1500 urban1500

save ${path_output}/data/urban1500.dta, replace
