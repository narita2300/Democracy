
*** import data
import excel ${path_input}/controls/median_age/MedianAgeTotalPop.xlsx, sheet("Data") cellrange(A2:D257) firstrow clear

kountry Location, from(other) m
drop if MARKER==0
rename D median_age
keep Location NAMES_STD  median_age
drop if median_age==26.8 //drop Micronesia observation because it refers to a region, not a country
save ${path_output}/data/median_age.dta, replace

*** merge with countries data 
use ${path_output}/data/countries.dta, replace
merge 1:m NAMES_STD using ${path_output}/data/median_age.dta
drop if _merge==2
keep countries iso3 NAMES_STD median_age

*** save
save ${path_output}/data/median_age.dta, replace
