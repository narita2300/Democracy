*** import data 
import delimited ${path_input}/channels/OxCGRT_latest.csv, clear

//convert date variable to date format
tostring date, replace
generate dates = date(date, "YMD")
format dates %td
drop date
rename dates date

keep if containmenthealthindex!=0
sort countryname date
by countryname: gen first=_n==1
keep if first==1
drop first

kountry countrycode, from(iso3c)
rename date introduce_policy
keep NAMES_STD introduce_policy

save ${path_output}/data/introduce_policy.dta, replace
