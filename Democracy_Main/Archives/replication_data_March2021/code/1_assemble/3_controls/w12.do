
*** import data
import delimited ${path_input}/controls/precipitation/pr_1991_2016.csv, clear

bysort country: egen mean_precip = mean(rainfallmm)
bysort country: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1

keep country iso3 mean_precip
kountry country, from(other)

save ${path_output}/data/precipitation.dta, replace

*** merge with countries data 
use ${path_output}/data/countries.dta, replace
merge 1:1 NAMES_STD using ${path_output}/data/precipitation.dta
drop if _merge==2
keep countries iso3 NAMES_STD mean_precip

*** save
save ${path_output}/data/precipitation.dta, replace

