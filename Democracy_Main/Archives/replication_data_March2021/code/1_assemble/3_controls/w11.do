
*** import data
import delimited ${path_input}/controls/temperature/tas_1991_2016.csv, clear 

bysort country: egen mean_temp = mean(temperaturecelsius)
bysort country: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1

keep country iso3 mean_temp
kountry country, from(other)

save ${path_output}/data/temperature.dta, replace

*** merge with countries data 
use ${path_output}/data/countries.dta, replace
merge 1:1 NAMES_STD using ${path_output}/data/temperature.dta
drop if _merge==2
keep countries iso3 NAMES_STD mean_temp

*** save
save ${path_output}/data/temperature.dta, replace


