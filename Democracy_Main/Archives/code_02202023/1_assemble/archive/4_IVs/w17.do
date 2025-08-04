
*** import data
use ${path_input}/IVs/settler_mortality/maketable5.dta, replace
// replace baseco=1 if shortnam=="CHN"
// keep if baseco==1
keep shortnam logem4
kountry shortnam, from(iso3c)
rename logem4 logem

save ${path_data}/settler_mortality.dta, replace

*** merge with countries data 
use ${path_data}/countries.dta, replace
merge 1:1 NAMES_STD using ${path_data}/settler_mortality.dta
drop if _merge==2
keep countries iso3 NAMES_STD logem

*** save
save ${path_data}/settler_mortality.dta, replace
