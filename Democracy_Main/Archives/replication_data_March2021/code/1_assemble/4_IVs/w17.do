
*** import data
use ${path_input}/IVs/settler_mortality/maketable5.dta, replace

keep shortnam logem4
kountry shortnam, from(iso3c)
rename logem4 logem

save ${path_output}/data/settler_mortality.dta, replace

*** merge with countries data 
use ${path_output}/data/countries.dta, replace
merge 1:1 NAMES_STD using ${path_output}/data/settler_mortality.dta
drop if _merge==2
keep countries iso3 NAMES_STD logem

*** save
save ${path_output}/data/settler_mortality.dta, replace
