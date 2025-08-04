
*** import temperature data
import delimited ${path_input}/controls/temperature/tas_1991_2016.csv, clear 

bysort country: egen mean_temp_1991_2016 = mean(temperaturecelsius)
bysort country: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1

keep country iso3 mean_temp
kountry country, from(other)

save ${path_data}/temperature.dta, replace

*** merge with countries data 
use ${path_data}/countries.dta, replace
merge 1:1 NAMES_STD using ${path_data}/temperature.dta
drop if _merge==2
keep countries iso3 NAMES_STD mean_temp

*** save
save ${path_data}/temperature.dta, replace

*** import temperature data
import delimited ${path_input}/controls/temperature/tas_1991_2016.csv, clear 
drop if year > 2000

bysort country: egen mean_temp_1991_2000 = mean(temperaturecelsius)
bysort country: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1
drop dup 
keep country iso3 mean_temp
kountry country, from(other)
keep NAMES_STD mean_temp_1991_2000

merge 1:1 NAMES_STD using ${path_data}/temperature.dta
drop if _merge==2
keep countries iso3 NAMES_STD mean_temp*

label variable mean_temp_1991_2000 "Mean Temperature in 1991-2000"
label variable mean_temp_1991_2016 "Mean Temperature in 1991-2016"

*** save
save ${path_data}/temperature.dta, replace


*** import temperature data
import delimited ${path_input}/controls/temperature/tas_1991_2016.csv, clear 
drop if year < 2001
drop if year > 2010

bysort country: egen mean_temp_2001_2010 = mean(temperaturecelsius)
bysort country: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1
drop dup 
keep country iso3 mean_temp
kountry country, from(other)
keep NAMES_STD mean_temp_2001_2010

merge 1:1 NAMES_STD using ${path_data}/temperature.dta
drop if _merge==2
keep countries iso3 NAMES_STD mean_temp*

label variable mean_temp_2001_2010 "Mean Temperature in 2001-2010"

*** save
save ${path_data}/temperature.dta, replace



*** import temperature data
import delimited ${path_input}/controls/temperature/tas_1991_2016.csv, clear 
drop if year < 2011

bysort country: egen mean_temp_2011_2016 = mean(temperaturecelsius)
bysort country: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1
drop dup 
keep country iso3 mean_temp
kountry country, from(other)
keep NAMES_STD mean_temp_2011_2016

merge 1:1 NAMES_STD using ${path_data}/temperature.dta
drop if _merge==2
keep countries iso3 NAMES_STD mean_temp*

label variable mean_temp_2011_2016 "Mean Temperature in 2011-2016"

*** save
save ${path_data}/temperature.dta, replace





*** import temperature data
import delimited ${path_input}/controls/temperature/tas_1961_1990.csv, clear 
drop if year < 1981
drop if year > 1990

bysort country: egen mean_temp_1981_1990 = mean(temperaturecelsius)
bysort country: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1
drop dup 
keep country iso3 mean_temp
kountry country, from(other)
keep NAMES_STD mean_temp_1981_1990

merge 1:1 NAMES_STD using ${path_data}/temperature.dta
drop if _merge==2
keep countries iso3 NAMES_STD mean_temp*

label variable mean_temp_1981_1990 "Mean Temperature in 1981-1990"

*** save
save ${path_data}/temperature.dta, replace




*** import temperature data
import delimited ${path_input}/controls/temperature/tas_1961_1990.csv, clear 
drop if year < 1971
drop if year > 1980

bysort country: egen mean_temp_1971_1980 = mean(temperaturecelsius)
bysort country: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1
drop dup 
keep country iso3 mean_temp
kountry country, from(other)
keep NAMES_STD mean_temp_1971_1980

merge 1:1 NAMES_STD using ${path_data}/temperature.dta
drop if _merge==2
keep countries iso3 NAMES_STD mean_temp*

label variable mean_temp_1971_1980 "Mean Temperature in 1971-1980"

*** save
save ${path_data}/temperature.dta, replace



