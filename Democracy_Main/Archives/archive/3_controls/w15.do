
*** import diabetes data
import excel "$path_input/controls/diabetes/IDF (age-adjusted-comparative-prevalence-of-diabetes---).xlsx", sheet("Sheet1") cellrange(A2:H230) firstrow clear
keep CountryTerritory D E
rename D diabetes_prevalence2010
rename E diabetes_prevalence2019

label variable diabetes_prevalence2010 "Prevalence of Diabetes in 2010"
label variable diabetes_prevalence2019 "Prevalence of Diabetes in 2019"

kountry CountryTerritory, from(other)
destring diabetes_prevalence*, replace force

save ${path_data}/diabetes.dta, replace

*** merge with countries data 
use ${path_data}/countries.dta, replace
merge 1:m NAMES_STD using ${path_data}/diabetes.dta
drop if _merge==2
keep countries iso3 NAMES_STD diabetes_prevalence*

*** save
save ${path_data}/diabetes.dta, replace
