
*** import median age data
import excel "/Users/ayumis/Dropbox/Democracy/MainAnalysis/input/controls/median_age/MedianAgeTotalPop-20210520040839.xlsx",sheet("Data") cellrange(A3:AH257) clear


local y 1950
foreach v of varlist D-R {
	rename `v' median_age`y'
	label variable median_age`y' "Median Age in `y'"
	local y = `y'+5
}

kountry B, from(other) m
drop if MARKER==0
keep B NAMES_STD  median_age*

drop if median_age2020==26.8 //drop Micronesia observation because it refers to a region, not a country
save ${path_data}/median_age.dta, replace

*** merge with countries data 
use ${path_data}/countries.dta, replace
merge 1:m NAMES_STD using ${path_data}/median_age.dta
drop if _merge==2
keep countries iso3 NAMES_STD median_age*

*** save
save ${path_data}/median_age.dta, replace

