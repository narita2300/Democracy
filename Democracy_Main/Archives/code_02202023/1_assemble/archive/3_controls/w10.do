
*** import latitude data
import delimited ${path_input}/controls/latitude/average-latitude-longitude-countries.csv, clear 

rename iso3166countrycode iso2
keep iso2 country latitude
gen abs_lat = abs(latitude)
drop latitude

kountry country, from(other)

save ${path_data}/latitude.dta, replace

*** merge with countries data 
use ${path_data}/countries.dta, replace
merge 1:1 NAMES_STD using ${path_output}/data/latitude.dta
drop if _merge==2
keep countries iso3 NAMES_STD abs_lat

*** save
save ${path_data}/latitude.dta, replace

