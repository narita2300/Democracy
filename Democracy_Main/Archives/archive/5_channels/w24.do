
*** cases over 10
import delimited ${path_input}/channels2020/OxCGRT_latest.csv, clear

tostring date, replace
gen dates = date(date, "YMD")
format dates %td

gen cases_over10 = 1 if confirmedcases>10
replace cases_over10 = 0 if confirmedcases<=10 | confirmedcases==.
keep if cases_over10 ==1 

sort countryname date
by countryname: gen cases_over10_date =_n==1
keep if cases_over10_date ==1
drop cases_over10 cases_over10_date

kountry countrycode, from(iso3c)
rename dates cases_over10

***

gen d1 = 1==c1_schoolclosing>0
gen d2 = 1==c2_workplaceclosing>0
gen d3 = 1==c3_cancelpublicevents>0
gen d4 = 1==c4_restrictionsongatherings>0
gen d5 = 1==c5_closepublictransport>0
gen d6 = 1==c6_stayathomerequirements>0
gen d7 = 1==c7_restrictionsoninternalmovemen>0
gen d8 = 1==c8_internationaltravelcontrols>0
gen d9 = 1==h1_publicinformationcampaigns>0
gen d10 = 1==h2_testingpolicy>0
gen d11 = 1==h3_contacttracing>0
gen d12 = 1==h6_facialcoverings>0
gen d13 = 1==h7_vaccinationpolicy>0

gen coverage = d1 + d2 + d3 + d4+ d5 + d6 + d7 + d8 + d9 + d10 + d11 + d12 + d13
gen coverage10 = 100*coverage/13

keep NAMES_STD coverage10

save ${path_data}/coverage10.dta, replace
