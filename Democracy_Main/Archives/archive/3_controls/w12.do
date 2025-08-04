
*** import precipitation data
import delimited ${path_input}/controls/precipitation/pr_1991_2016.csv, clear

bysort country: egen mean_precip_1991_2016 = mean(rainfallmm)
bysort country: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1

keep country iso3 mean_precip_1991_2016
kountry country, from(other)

save ${path_data}/precipitation.dta, replace

*** merge with countries data 
use ${path_data}/countries.dta, replace
merge 1:1 NAMES_STD using ${path_data}/precipitation.dta
drop if _merge==2
keep countries iso3 NAMES_STD mean_precip_1991_2016

*** save
save ${path_data}/precipitation.dta, replace


*** import precipitation data
import delimited ${path_input}/controls/precipitation/pr_1991_2016.csv, clear
drop if year > 2000

bysort country: egen mean_precip_1991_2000 = mean(rainfallmm)
bysort country: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1

keep country iso3 mean_precip_1991_2000
kountry country, from(other)
keep NAMES_STD mean_precip_1991_2000

merge 1:1 NAMES_STD using ${path_data}/precipitation.dta
drop if _merge==2
drop _merge

label variable mean_precip_1991_2000 "Mean Precipitation in 1991-2000"
label variable mean_precip_1991_2016 "Mean Precipitation in 1991-2016"

save ${path_data}/precipitation.dta, replace



*** import precipitation data
import delimited ${path_input}/controls/precipitation/pr_1991_2016.csv, clear
drop if year < 2001
drop if year > 2010

bysort country: egen mean_precip_2001_2010 = mean(rainfallmm)
bysort country: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1

keep country iso3 mean_precip_2001_2010
kountry country, from(other)
keep NAMES_STD mean_precip_2001_2010

merge 1:1 NAMES_STD using ${path_data}/precipitation.dta
drop if _merge==2
drop _merge

label variable mean_precip_2001_2010 "Mean Precipitation in 2001-2010"

save ${path_data}/precipitation.dta, replace


*** import precipitation data
import delimited ${path_input}/controls/precipitation/pr_1991_2016.csv, clear
drop if year < 2011

bysort country: egen mean_precip_2011_2016 = mean(rainfallmm)
bysort country: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1

keep country iso3 mean_precip_2011_2016
kountry country, from(other)
keep NAMES_STD mean_precip_2011_2016

merge 1:1 NAMES_STD using ${path_data}/precipitation.dta
drop if _merge==2
drop _merge

label variable mean_precip_2011_2016 "Mean Precipitation in 2011-2016"

save ${path_data}/precipitation.dta, replace


*** import precipitation data
import delimited ${path_input}/controls/precipitation/pr_1961_1990.csv, clear
drop if year < 1981
drop if year > 1990

bysort country: egen mean_precip_1981_1990 = mean(rainfallmm)
bysort country: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1

keep country iso3 mean_precip_1981_1990
kountry country, from(other)
keep NAMES_STD mean_precip_1981_1990

merge 1:1 NAMES_STD using ${path_data}/precipitation.dta
drop if _merge==2
drop _merge

label variable mean_precip_1981_1990 "Mean Precipitation in 1981-1990"

save ${path_data}/precipitation.dta, replace


*** import precipitation data
import delimited ${path_input}/controls/precipitation/pr_1961_1990.csv, clear
drop if year < 1971
drop if year > 1980

bysort country: egen mean_precip_1971_1980 = mean(rainfallmm)
bysort country: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1

keep country iso3 mean_precip_1971_1980
kountry country, from(other)
keep NAMES_STD mean_precip_1971_1980

merge 1:1 NAMES_STD using ${path_data}/precipitation.dta
drop if _merge==2
drop _merge

label variable mean_precip_1971_1980 "Mean Precipitation in 1971-1980"

save ${path_data}/precipitation.dta, replace
