
*** import data
import excel ${path_input}/controls/total_gdp/Data_Extract_From_World_Development_Indicators.xlsx, sheet("Data") firstrow clear

keep CountryName CountryCode YR2019
kountry CountryName, from(other)
rename YR2019 total_gdp
destring total_gdp, replace force

replace total_gdp = total_gdp/1000000000

save ${path_output}/data/total_gdp.dta, replace

*** merge with countries data 
use ${path_output}/data/countries.dta, replace
merge 1:m NAMES_STD using ${path_output}/data/total_gdp.dta
drop if _merge==2
keep countries iso3 NAMES_STD total_gdp 

*** save
save ${path_output}/data/total_gdp.dta, replace
