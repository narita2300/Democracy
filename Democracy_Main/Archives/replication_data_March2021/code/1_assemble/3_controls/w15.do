
*** import data
import excel "$path_input/controls/diabetes/IDF (age-adjusted-comparative-prevalence-of-diabetes---).xlsx", sheet("Sheet1") cellrange(A2:H230) firstrow clear

keep CountryTerritory E
rename E diabetes_prevalence

kountry CountryTerritory, from(other)

destring diabetes_prevalence, replace force

save ${path_output}/data/diabetes.dta, replace

*** merge with countries data 
use ${path_output}/data/countries.dta, replace
merge 1:m NAMES_STD using ${path_output}/data/diabetes.dta
drop if _merge==2
keep countries iso3 NAMES_STD diabetes_prevalence

*** save
save ${path_output}/data/diabetes.dta, replace
