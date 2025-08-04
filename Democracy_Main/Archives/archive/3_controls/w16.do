
// load healthcare data
import excel "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/controls/healthcare/GlobalHealthSecurityIndex2019.xlsx", sheet("Sheet2") cellrange(N9:O204) firstrow clear

kountry Country, from(other)
replace NAMES_STD = "Democratic Republic of Congo" if Country=="Congo (Democratic Republic)"
replace NAMES_STD = "Swaziland" if Country=="eSwatini (Swaziland)"
merge 1:1 NAMES_STD using ${path_data}/countries.dta
drop if _merge==1
rename Score100 health_security_index 
label variable health_security_index "Global Health Security Index in 2019"
keep health_security_index NAMES_STD

*** save
save ${path_data}/healthcare.dta, replace

*** import countries data 
use ${path_data}/countries.dta, replace

*** merge with population.dta
merge 1:1 NAMES_STD using ${path_data}/population.dta, nogenerate

*** merge with total_gdp.dta
merge 1:1 NAMES_STD using ${path_data}/total_gdp.dta, nogenerate

*** merge with latitude.dta
merge 1:1 NAMES_STD using ${path_data}/latitude.dta, nogenerate

*** merge with temperature.dta
merge 1:1 NAMES_STD using ${path_data}/temperature.dta, nogenerate

*** merge with precipitation.dta
merge 1:1 NAMES_STD using ${path_data}/precipitation.dta, nogenerate

*** merge with population_density.dta
merge 1:1 NAMES_STD using ${path_data}/population_density.dta, nogenerate

*** merge with median_age.dta
merge 1:1 NAMES_STD using ${path_data}/median_age.dta, nogenerate

*** merge with diabetes.dta
merge 1:1 NAMES_STD using ${path_data}/diabetes.dta, nogenerate

*** merge with healthcare.dta
merge 1:1 NAMES_STD using ${path_data}/healthcare.dta, nogenerate

*** save data
save ${path_data}/controls.dta, replace
