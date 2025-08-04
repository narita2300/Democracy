
*** cases over 10
import delimited ${path_input}/channels2020/OxCGRT_latest.csv, clear

tostring date, replace
gen dates = date(date, "YMD")
format dates %td

keep if jurisdiction=="NAT_TOTAL"

gen cases_over10 = 1 if confirmedcases!=. & confirmedcases>10
replace cases_over10 = 0 if confirmedcases<=10 | confirmedcases==.
keep if cases_over10==1
sort countryname date
by countryname: gen cases_over10_date =_n==1
keep if cases_over10_date ==1 
drop cases_over10 cases_over10_date

kountry countrycode, from(iso3c)
rename dates cases_over10
gen containmenthealth10 = containmenthealthindex/19.9988
keep NAMES_STD cases_over10 containmenthealth10

save ${path_data}/containmenthealth10.dta, replace
