
************************************
************************************ Containment Health Index (severity)

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

************************************
************************************ Containment Health Index (coverage)

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

************************************
************************************ Containment Health Index (speed)

*** import data 
import delimited ${path_input}/channels2020/OxCGRT_latest.csv, clear

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

save ${path_data}/introduce_policy.dta, replace

************************************
************************************ World Development Indicators

import delimited ${path_input}/channels21st/wdi.csv, encoding(UTF-8) rowrange(2) clear 
rename v1 country_name
rename v2 iso3c 
rename v3 series_name 
rename v4 series_code

local series "SP.DYN.IMRT.IN" "NE.TRD.GNFS.ZS"
local varname mortality trade

local n_series : word count `series'
di `word count `varname''
assert `n_series'==`:word count `varname''

forval i = 1/`n_series' {
	import delimited ${path_input}/channels21st/wdi.csv, encoding(UTF-8) rowrange(2) clear 
	rename v1 country_name
	rename v2 iso3c 
	rename v3 series_name 
	rename v4 series_code
	keep if series_code ==  "`:word `i' of "`series'"'"

	local y = 5
	forvalues year = 1960/2020 {
		destring v`y', replace force
		rename v`y' `:word `i' of `varname''`year'
		local y = `y' + 1
		gen log`:word `i' of `varname''`year' = log(`:word `i' of `varname''`year')
	}
	drop series_name series_code
	save ${path_data}/`:word `i' of `varname''.dta, replace
}


 import delimited ${path_input}/channels21st/school2.csv, encoding(UTF-8) rowrange(2) clear 

rename v1 country_name
rename v2 iso3c 
rename v3 series_name 
rename v4 series_code
keep if series_code=="SE.PRM.NENR"
local y = 5
	forvalues year = 1960/2020 {
		destring v`y', replace force
		rename v`y' primary`year'
		local y = `y' + 1
		gen logprimary`year' = log(primary`year')
}
drop series_name series_code
save ${path_data}/primary.dta, replace

 import delimited ${path_input}/channels21st/school2.csv, encoding(UTF-8) rowrange(2) clear
rename v1 country_name
rename v2 iso3c 
rename v3 series_name 
rename v4 series_code
keep if series_code=="SE.SEC.NENR"
local y = 5
	forvalues year = 1960/2020 {
		destring v`y', replace force
		rename v`y' secondary`year'
		local y = `y' + 1
		gen logsecondary`year' = log(secondary`year')
}
drop series_name series_code
save ${path_data}/secondary.dta, replace

local varname primary secondary mortality trade

// merge each of the individual .dta into one dataset
// use ${path_input}/channels21st/DDCGdata_final.dta, clear
use ${path_data}/primary.dta, clear
foreach var of local varname{
	merge 1:1 country_name using ${path_data}/`var'.dta, nogenerate
}
kountry iso3c, from(iso3c) marker
drop if MARKER==0
drop MARKER
save ${path_data}/wdi.dta, replace

import delimited ${path_input}/channels21st/tax.csv, encoding(UTF-8) rowrange(6) clear 
rename v2 iso3c 
drop v1 v3 v4
local y = 5
forvalues year = 1960/2020 {
	destring v`y', replace force
	rename v`y' tax`year'
	local y = `y' + 1
	gen logtax`year' = log(tax`year')
}
kountry iso3c, from(iso3c) marker
drop if MARKER==0
drop MARKER

merge 1:1 NAMES_STD using ${path_data}/wdi.dta
drop _merge
save ${path_data}/wdi.dta, replace

************************************
************************************ Penn World Tables

use ${path_input}/channels21st/pwt100.dta, clear
keep countrycode year rtfpna
reshape wide rtfpna, i(countrycode) j(year)
kountry countrycode, from(iso3c) marker
drop if MARKER==0
drop MARKER

foreach var of varlist rtfpna1950-rtfpna2019{
	gen log`var' = log(`var')
}
save ${path_data}/pwt.dta, replace

************************************
************************************ International Monetary Fund

import delimited ${path_input}/channels21st/imf.csv, rowrange(6) clear 

keep if indicatorid==345 
// | indicator==2777
local y = 6
forvalues year = 1980/2024{
	rename v`y' investment`year'
	local y = `y'+1
	gen loginvestment`year' = log(investment`year')
}

kountry countryiso3, from(iso3c)
drop countryiso3 countryname indicatorid indicator subindicatortype

save ${path_data}/imf.dta, replace

************************************
************************************ Democracy Does Cause Growth Replication Data

// relevant variables: country, loginvpc (log investment), ltfp (log TFP), marketref (market reforms), ltrade (trade share), lgov (government expenditure), lprienr (primary enrollment), lsecenr (secondary enrollment), lmort (child mortality), unrestn (riots and revolutions)

// load data from Acemoglu et al. (JPE, 2019)
use ${path_input}/channels21st/DDCGdata_final.dta, clear
	
foreach var of varlist loginvpc ltfp marketref ltrade2 lgov lprienr lsecenr lmort unrestn{
	use ${path_input}/channels21st/DDCGdata_final.dta, clear
	keep country_name year `var'
	reshape wide `var', i(country_name) j(year)
	save ${path_data}/`var'.dta, replace
}

// merge each of the individual .dta into one dataset
// use ${path_input}/channels21st/DDCGdata_final.dta, clear
use ${path_input}/channels21st/DDCGdata_final.dta, clear
keep country_name wbcode 
duplicates drop
foreach var in loginvpc ltfp marketref ltrade2 lgov lprienr lsecenr lmort unrestn{
	merge 1:1 country_name using ${path_data}/`var'.dta, nogenerate
}

kountry wbcode, from(iso3c) m
replace NAMES_STD = "Singapore" if wbcode=="SIN"
replace NAMES_STD = "United Arab Emirates" if wbcode =="UAE"
replace NAMES_STD = "Yugoslavia" if wbcode =="SER"
replace NAMES_STD = "Nauru" if wbcode=="NAU"
replace NAMES_STD = "Taiwan" if wbcode=="TAW"

save ${path_data}/ddcg.dta, replace

************************************
************************************ Innovation Data 
// // variables which are correlated with democracy with high significance or are important 
// local indicators "Research and development expenditure (% of GDP)" "Researchers in R&D (per million people)" "ICT goods imports (% of total goods imports)" "ICT service imports (% of service imports, BoP)" "High-technology imports (% of manufactured imports)" "Patent applications, residents" "Investment in telecoms with private participation (current US$)" "import value index (2000 = 100)" "Gross national expenditure (% of GDP)" "import value index (2000 = 100)" "International tourism, expenditures for passenger transport items (current US$)" "Manufacturing, value added (annual % growth)" "Merchandise imports to low- and middle-income economies in Latin America & the Caribbean (% of total merchandise imports)" "Merchandise imports to low- and middle-income economies in South Asia (% of total merchandise imports)" "Net trade in goods (BoP, current US$)" "Net trade in goods and services (BoP, current US$)" "New business density (new registrations per 1,000 people ages 15-64)" "New businesses registered (number)" "Services, etc., value added (% of GDP)" "Services, etc., value added (annual % growth)" "Taxes on goods and services (% value added of industry and services)" "Taxes on income, profits and capital gains (% of total taxes)" "Technicians in R&D (per million people)" 

// local shortnames rd_expenditure rd_researchers ict_goods_imports ict_services_imports high_tech_imports patent_apps telecoms_investment import_value national_expenditure import_value tourism manufacturing_value_added merch_imports_latin merch_imports_south_asia net_trade_goods net_trade_goods_services new_business_density new_business_registered services_va services_va_growth tax_goods_services tax_income technicians_rd
// local n:word count "`indicators'"
// local m:word count `shortnames'
// di `n'
// di `m'
import delimited ${path_input}/channels21st/raw_data.csv, clear 
// Get data on: 1. trade 2. growth in manufacturing and service sector value added 

// local indicators "import value index (2000 = 100)" ///
// "imports of goods and services (% of GDP)" ///
// "imports of goods and services (% of GDP)" ///
// "Net trade in goods (BoP, current US$)" ///
// "Net trade in goods and services (BoP, current US$)" ///
// "Trade (% of GDP)" ///
// "Trade in services (% of GDP)" ///
// "Manufacturing, value added (annual % growth)" ///
// "Services, etc., value added (annual % growth)" ///
// "Merchandise imports to low- and middle-income economies in Latin America & the Caribbean (% of total merchandise imports)" ///
// "Merchandise imports to low- and middle-income economies in South Asia (% of total merchandise imports)" ///
// "Foreign direct investment, net inflows (% of GDP)" ///
// "Foreign direct investment, net outflows (% of GDP)"


local indicators "Import value index (2000 = 100)" "Export value index (2000 = 100)" "Manufacturing, value added (annual % growth)" "Imports of goods and services (% of GDP)" "Exports of goods and services (% of GDP)" "Manufacturing, value added (% of GDP)" "Services, etc., value added (% of GDP)" "Research and development expenditure (% of GDP)" "Researchers in R&D (per million people)" "New business density (new registrations per 1,000 people ages 15-64)"
local shortnames import_value export_value manu_va_growth import_gdp export_gdp manu_va_gdp serv_va_gdp rd_expenditure rd_researchers new_business
local n:word count "`indicators'"

forvalues i = 1/`n' {
	import delimited ${path_input}/channels21st/raw_data.csv, clear 
	local indicator "`: word `i' of "`indicators'"'"
	local shortname "`:word `i' of `shortnames''"
	
	keep if indicator=="`indicator'"
	local y = 6
	forvalues year = 1960/2020 {
			rename v`y' `shortname'`year'
			local y = `y' + 1
			gen log`shortname'`year' = log(`shortname'`year')
	}
	keep countryiso3 log* `shortname'*
	kountry countryiso3, from(iso3c)
	drop if NAMES_STD==""
	save ${path_data}/`shortname'.dta, replace
}

import delimited ${path_input}/channels21st/services_va.csv, varnames(5) encoding(UTF-8) rowrange(6) clear 
local shortname "serv_va_growth"
local y = 5
forvalues year = 1960/2020 {
			rename v`y' `shortname'`year'
			local y = `y' + 1
			gen log`shortname'`year' = log(`shortname'`year')
}

keep countrycode log* `shortname'*
kountry countrycode, from(iso3c)
drop if NAMES_STD==""
save ${path_data}/`shortname'.dta, replace

import delimited ${path_input}/channels21st/API_NV.AGR.TOTL.KD.ZG_DS2_en_csv_v2_2826973.csv, encoding(UTF-8) rowrange(6) clear
local shortname "agr_va_growth"
local y = 5
forvalues year = 1960/2020 {
			rename v`y' `shortname'`year'
			local y = `y' + 1
			gen log`shortname'`year' = log(`shortname'`year')
}

keep v2 log* `shortname'*
kountry v2, from(iso3c) m
drop if MARKER==0
drop v2 MARKER
save ${path_data}/`shortname'.dta, replace


import delimited ${path_input}/channels21st/API_SL.TLF.CACT.NE.ZS_DS2_en_csv_v2_2827274.csv, encoding(UTF-8) rowrange(6) clear 
local shortname "labor_particip_rate"
local y = 5
forvalues year = 1960/2020 {
			rename v`y' `shortname'`year'
			local y = `y' + 1
			gen log`shortname'`year' = log(`shortname'`year')
}
keep v2 log* `shortname'*
kountry v2, from(iso3c) m
drop if MARKER==0
drop v2 MARKER
save ${path_data}/`shortname'.dta, replace

import delimited ${path_input}/channels21st/API_NE.GDI.TOTL.KD_DS2_en_csv_v2_2826962.csv, encoding(UTF-8) rowrange(6) clear 

local shortname "capital_growth"
local y = 5
forvalues year = 1960/2020 {
			rename v`y' `shortname'`year'
			local y = `y' + 1
			gen log`shortname'`year' = log(`shortname'`year')
}
keep v2 log* `shortname'*
kountry v2, from(iso3c) m
drop if MARKER==0
drop v2 MARKER
save ${path_data}/`shortname'.dta, replace

import delimited ${path_input}/channels21st/API_NE.GDI.TOTL.KD.ZG_DS2_en_csv_v2_2769834.csv, encoding(UTF-8) rowrange(6) clear 
local shortname "capital"
local y = 5
forvalues year = 1960/2020 {
			rename v`y' `shortname'`year'
			local y = `y' + 1
			gen log`shortname'`year' = log(`shortname'`year')
}
keep v2 log* `shortname'*
kountry v2, from(iso3c) m
drop if MARKER==0
drop v2 MARKER
save ${path_data}/`shortname'.dta, replace

import delimited ${path_input}/channels21st/API_SL.TLF.TOTL.IN_DS2_en_csv_v2_2765216.csv, encoding(UTF-8) rowrange(6) clear 
local shortname "labor"
local y = 5
forvalues year = 1960/2020 {
			rename v`y' `shortname'`year'
			local y = `y' + 1
			gen log`shortname'`year' = log(`shortname'`year')
}

forvalues year = 1961/2020{
	local prev = `year' - 1
	gen labor_growth`year' = (labor`year' - labor`prev')/labor`prev'
	gen loglabor_growth`year' = log(labor_growth`year')
}

keep v2 log* `shortname'* 
kountry v2, from(iso3c) m
drop if MARKER==0
drop v2 MARKER
save ${path_data}/`shortname'.dta, replace

import delimited ${path_input}/channels21st/API_NE.IMP.GNFS.KD.ZG_DS2_en_csv_v2_2764300.csv, encoding(UTF-8) rowrange(6) clear 
local shortname "import_growth"
local y = 5
forvalues year = 1960/2020 {
			rename v`y' `shortname'`year'
			local y = `y' + 1
			// gen log`shortname'`year' = log(`shortname'`year')
}
keep v2 `shortname'* 
kountry v2, from(iso3c) m
drop if MARKER==0
drop v2 MARKER
save ${path_data}/`shortname'.dta, replace

import delimited ${path_input}/channels21st/API_NE.EXP.GNFS.KD.ZG_DS2_en_csv_v2_2764241.csv, encoding(UTF-8) rowrange(6) clear 
local shortname "export_growth"
local y = 5
forvalues year = 1960/2020 {
			rename v`y' `shortname'`year'
			local y = `y' + 1
			// gen log`shortname'`year' = log(`shortname'`year')
}
keep v2 `shortname'* 
kountry v2, from(iso3c) m
drop if MARKER==0
drop v2 MARKER
save ${path_data}/`shortname'.dta, replace

// import delimited ${path_input}/channels21st/API_NE.EXP.GNFS.ZS_DS2_en_csv_v2_2766775.csv, encoding(UTF-8) rowrange(6) clear 
// local shortname "import"
// local y = 5
// forvalues year = 1960/2020 {
// 			rename v`y' `shortname'`year'
// 			local y = `y' + 1
// 			// gen log`shortname'`year' = log(`shortname'`year')
// }
// keep v2 `shortname'* 
// kountry v2, from(iso3c) m
// drop if MARKER==0
// drop v2 MARKER
// save ${path_data}/`shortname'.dta, replace


use ${path_data}/import_value.dta, clear
local shortnames export_value manu_va_growth serv_va_growth import_gdp export_gdp manu_va_gdp serv_va_gdp rd_expenditure rd_researchers new_business agr_va_growth labor_particip_rate capital_growth capital labor import_growth export_growth
local n:word count `shortnames'
di `n'
forvalues i = 1/`n'{
	local shortname "`:word `i' of `shortnames''"
	di "`shortname'"
	merge 1:1 NAMES_STD using ${path_data}/`shortname'.dta, nogenerate
}
save ${path_data}/innovation.dta, replace

************************************
************************************ China trade data: import

import delimited ${path_input}/channels21st/comtrade.csv, clear

kountry reporteriso, from(iso3c) marker
drop if MARKER==0
keep if tradeflow=="Import"
keep year NAMES_STD tradevalueus
rename tradevalueus china_import
reshape wide china_import, i(NAMES_STD) j(year)
keep china_import2001-china_import2019 NAMES_STD
// egen mean_import_china = rowmean(china_import2001-china_import2019)

save ${path_data}/china_import.dta, replace

************************************
************************************ China trade data: export

import delimited ${path_input}/channels21st/comtrade.csv, clear

kountry reporteriso, from(iso3c) marker
drop if MARKER==0
keep if tradeflow=="Export"
keep year NAMES_STD tradevalueus
rename tradevalueus china_export
reshape wide china_export, i(NAMES_STD) j(year)
keep china_export2001-china_export2019 NAMES_STD
// egen mean_export_china = rowmean(china_export2001-china_export2019)

save ${path_data}/china_export.dta, replace

************************************
************************************ Political Stability Index 
import excel "${path_input}/channels21st/2020 Edition CNTSDATA files with LINKS/2020 Edition CNTSDATA.xlsx", sheet("2019 Data") cellrange(A1:GM17720) firstrow clear

keep if CountryCode != "code" // remove first row
keep Country Year WeightedConflictIndex
destring Year, replace
keep if Year > 1960
destring WeightedConflictIndex, replace
egen conflict = std(WeightedConflictIndex)
drop WeightedConflictIndex
reshape wide conflict, i(Country) j(Year)

drop if conflict2000 ==.
kountry Country, from(other) m
drop if MARKER == 0
drop MARKER 

save ${path_data}/conflict.dta, replace

************************************
************************************ Fraser Institute data
 
import excel ${path_input}/channels21st/protectionism/economic-freedom-of-the-world-2021-master-index-data-for-researchers-iso.xlsx, sheet("EFW Data 2021 Report") cellrange(B5:BV4297) firstrow case(lower) clear

***** KEEP ONLY OBSERVATIONS IN 2001-19 PERIOD
keep if year > 2000 & year <=2019

*** currently the observations are by country-year 
*** make observations by country-index 
keep iso_code_3 year freedomtotradeinternationa atariffs airevenuefromtradetaxes ao aiimeantariffrate aq aiiistandarddeviationoftar as ///
bregulatorytradebarriers binontarifftradebarriers biicompliancecostsofimport ///
cblackmarketexchangerates ///
dcontrolsofthemovementof difinancialopenness diicapitalcontrols diiifreedomofforeignerstov

*** RE-standardize variables in 1970-2019 period
// foreach var of varlist freedomtotradeinternationa atariffs airevenuefromtradetaxes ao aiimeantariffrate aq aiiistandarddeviationoftar as bregulatorytradebarriers binontarifftradebarriers biicompliancecostsofimport cblackmarketexchangerates dcontrolsofthemovementof difinancialopenness diicapitalcontrols diiifreedomofforeignerstov {
// 	local lab: variable label `var'
// 	di "`lab'"
// 	egen `var'_sd = std(`var')
// 	drop `var'
// 	rename `var'_sd `var'
// 	label variable `var' "`lab'"
// }

local n = 1
local varname ftti atariffs airevenue ao aiitariff aw aiiisd as bregtrade binontariff bicostimport cblackmarket dcontrolmove difinopen diicapcontrol
foreach var of varlist freedomtotradeinternationa atariffs airevenuefromtradetaxes ao aiimeantariffrate aq aiiistandarddeviationoftar as bregulatorytradebarriers binontarifftradebarriers biicompliancecostsofimport cblackmarketexchangerates dcontrolsofthemovementof difinancialopenness diicapitalcontrols{
	sum `var'
	local name: word `n' of `varname'
	di "`name'"
	sort iso_code_3 year
	bysort iso_code_3: gen change_`name'_2001_2019 = `var'[_N] - `var'[1]
	bysort iso_code_3: egen mean_`name'_2001_2019 = mean(`var')
	local n = `n' + 1
}



duplicates drop iso_code_3, force
kountry iso_code_3, from(iso3c)
keep NAMES_STD mean* change* 

label variable change_ftti_2001_2019 "Change in freedom to trade internationally score in 2001-19"

// foreach var of varlist change_ftti_2001_2019 {
// 	local lab: variable label `var'
// 	di "`lab'"
// 	egen `var'_sd = std(`var')
// 	drop `var'
// 	rename `var'_sd `var'
// 	label variable `var' "`lab'"
// }

save ${path_data}/fraser.dta, replace

************************************
************************************ Fraser Institute data
 
import excel ${path_input}/channels21st/protectionism/economic-freedom-of-the-world-2021-master-index-data-for-researchers-iso.xlsx, sheet("EFW Data 2021 Report") cellrange(B5:BV4297) firstrow case(lower) clear

kountry iso_code_3, from(iso3c) 
keep NAMES_STD year freedomtotradeinternationa
rename freedomtotradeinternationa ftti
egen ftti_std = std(ftti)
replace ftti = ftti_std 
drop ftti
rename ftti_std ftti

drop if year ==.
reshape wide ftti, i(NAMES_STD) j(year)

save ${path_data}/fraser_ftti.dta, replace

************************************
************************************ Digital Society Project 
use ${path_input}/channels21st/digital-society-project/DigitalSocietyProject-v3-STATA/DSP-Dataset-v3.dta, clear
keep country_text_id year v2smmefra v2smpolsoc v2smpolhate 
drop if country_text_id ==""
keep if year >2000 
keep if year <2020

// ***** standardize the key variables across time and countries 
// egen v2smmefra_sd = std(v2smmefra)
// egen v2smpolsoc_sd = std(v2smpolsoc)
// egen v2smpolhate_sd = std(v2smpolhate)

// *****
// drop v2smmefra v2smpolsoc v2smpolhate 
// rename v2smmefra_sd v2smmefra
// rename v2smpolsoc_sd v2smpolsoc
// rename v2smpolhate_sd v2smpolhate

*****
// label variable v2smpolsoc "Societal agreement on key political issues"
// label variable v2smpolhate "Political parties' abstention from hate speech"
// label variable v2smmefra "Similar presentation of events online"

// generate necessary variables and make dataset by-country
local n = 1
// local varname ftti atariffs airevenue ao aiitariff aw aiiisd as bregtrade binontariff bicostimport cblackmarket dcontrolmove difinopen diicapcontrol
foreach var of varlist v2smpolsoc v2smpolhate v2smmefra{
	sum `var'
	sort country_text_id year
	bysort country_text_id: gen change_`var'_2001_2019 = `var'[_N] - `var'[1]
	bysort country_text_id: egen mean_`var'_2001_2019 = mean(`var')
	local n = `n' + 1
}

// keep iso3 change* mean* regime2000 dem2000 total_gdp2000
duplicates drop country_text_id, force
kountry country_text_id, from(iso3c) 

keep NAMES_STD change* mean*

// label variable change_v2smpolhate_2001_2019 "Change in political parties' abstention from hate speech score in 2001-19"
// label variable change_v2smpolsoc_2001_2019 "Change in societal agreement on key political issues score in 2001-19 "

// foreach var of varlist change_v2smpolhate_2001_2019 change_v2smpolsoc_2001_2019 {
// 	local lab: variable label `var'
// 	di "`lab'"
// 	egen `var'_sd = std(`var')
// 	drop `var'
// 	rename `var'_sd `var'
// 	label variable `var' "`lab'"
// }

save ${path_data}/digital.dta, replace

************************************
************************************ Digital Society Project 
use ${path_input}/channels21st/digital-society-project/DigitalSocietyProject-v3-STATA/DSP-Dataset-v3.dta, clear
keep country_text_id year v2smmefra v2smpolsoc v2smpolhate 
drop if country_text_id ==""

// keep if year >=1980 & year <=2019
// egen v2smpolsoc_sd = std(v2smpolsoc)
// egen v2smpolhate_sd = std(v2smpolhate)

// replace v2smpolsoc = v2smpolsoc_sd
// replace v2smpolhate = v2smpolhate_sd
// kountry country_text_id, from(iso3c)
// reshape wide v2smpolsoc, i(NAMES_STD) j(year)
// reshape wide ftti, i(NAMES_STD) j(year)
local n = 1
foreach var of varlist v2smpolsoc v2smpolhate{
	
	use ${path_input}/channels21st/digital-society-project/DigitalSocietyProject-v3-STATA/DSP-Dataset-v3.dta, clear
	keep if year >=1980 & year <=2019
	drop `var'_sd
	egen `var'_sd = std(`var')
	replace `var' = `var'_sd

	drop if country_text_id ==""
	kountry country_text_id, from(iso3c)
	keep NAMES_STD year `var' 
	reshape wide `var', i(NAMES_STD) j(year)
	
	save ${path_data}/digital_`var'.dta, replace
	local n = `n' + 1
}

************************************
************************************ Populism: ruling party's populist  rhetoric
use ${path_input}/populism/CPD_V-Party_Stata_v1/V-Dem-CPD-Party-V1.dta, clear
keep if year >=2001

***** first, we just look at ruling parties in every election term *****
keep if v2pagovsup == 0

// if there are multiple ruling parties in one election, make the weighted illiberalism and populism score using the seat share 
// for each year-country group, make a seat-share-weighted populism score 
bysort year country_text_id: egen seatw_ruling_popul = wtmean(v2xpa_popul), weight(v2paseatshare)
bysort year country_text_id: egen seatw_ruling_illib = wtmean(v2xpa_illiberal), weight(v2paseatshare)

label variable seatw_ruling_popul "Ruling party's populism score"
label variable seatw_ruling_illib "Ruling party's illiberalism score"

duplicates drop year country_text_id, force

keep year country_text_id seatw_ruling*

bysort country_text_id: egen mean_ruling_illib_2001_2019 = mean(seatw_ruling_illib)
bysort country_text_id: egen mean_ruling_popul_2001_2019 = mean(seatw_ruling_popul)
label variable  mean_ruling_illib_2001_2019 "Mean illiberalism score of ruling parties in 2001-19"
label variable mean_ruling_popul_2001_2019 "Mean populism Score of ruling parties in 2001-19"

bysort country_text_id: gen change_ruling_illib_2001_2019 = seatw_ruling_illib[_N] - seatw_ruling_illib[1]
bysort country_text_id: gen change_ruling_popul_2001_2019 = seatw_ruling_popul[_N] - seatw_ruling_popul[1]
label variable change_ruling_illib_2001_2019 "Change in Ruling Party's Illiberalism Score in 2001-19'"
label variable change_ruling_popul_2001_2019 "Change in Ruling Party's Populism Score in 2001-19'"

duplicates drop country_text_id, force
kountry country_text_id, from(iso3c)
keep NAMES_STD mean* change*

// foreach var of varlist mean_ruling_illib_2001_2019 mean_ruling_popul_2001_2019 change_ruling_illib_2001_2019 change_ruling_popul_2001_2019 {
// 	local lab: variable label `var'
// 	di "`lab'"
// 	egen `var'_sd = std(`var')
// 	drop `var'
// 	rename `var'_sd `var'
// 	label variable `var' "`lab'"
// }

save ${path_data}/vparty_ruling.dta, replace

************************************
************************************ Populism: seat-weighted populist rhetoric

use ${path_input}/populism/CPD_V-Party_Stata_v1/V-Dem-CPD-Party-V1.dta, clear
keep if year >=2001 & year <=2019

***** MAKE NATIONAL MEASURE OF POPULISM AND LIBERALISM *****
// for each year-country group, make a seat-share-weighted populism score 
bysort year country_text_id: egen seatw_popul = wtmean(v2xpa_popul), weight(v2paseatshare)
bysort year country_text_id: egen seatw_illib = wtmean(v2xpa_illiberal), weight(v2paseatshare)
label variable seatw_popul "Seat-share-weighted populism score"
label variable seatw_illib "Seat-share-weighted illiberalism score"

bysort year country_text_id: egen votew_popul = wtmean(v2xpa_popul), weight(v2pavote)
bysort year country_text_id: egen votew_illib = wtmean(v2xpa_illiberal), weight(v2pavote)
label variable seatw_popul "Vote-share-weighted populism score"
label variable seatw_illib "Vote-share-weighted illiberalism score"

duplicates drop year country_text_id, force
keep year country_text_id seatw_* votew_*

bysort country_text_id: egen mean_seatw_illib_2001_2019 = mean(seatw_illib)
bysort country_text_id: egen mean_seatw_popul_2001_2019 = mean(seatw_popul)
label variable mean_seatw_illib_2001_2019 "Mean seat-share-weighted illiberalism score in 2001-19"
label variable mean_seatw_popul_2001_2019 "Mean seat-share-weighted populism score in 2001-19"

bysort country_text_id: egen mean_votew_illib_2001_2019 = mean(votew_illib)
bysort country_text_id: egen mean_votew_popul_2001_2019 = mean(votew_popul)
label variable mean_votew_illib_2001_2019 "Mean vote-share-weighted illiberalism score in 2001-19"
label variable mean_votew_popul_2001_2019 "Mean vote-share-weighted populism score in 2001-19"

sort country_text_id year
bysort country_text_id: gen change_seatw_illib_2001_2019 = seatw_illib[_N] - seatw_illib[1]
bysort country_text_id: gen change_seatw_popul_2001_2019 = seatw_popul[_N] - seatw_popul[1]
label variable change_seatw_illib_2001_2019 "Change in seat-share-weighted illiberalism score in 2001-19"
label variable change_seatw_popul_2001_2019 "Change in seat-share-weighted populism score in 2001-19"

bysort country_text_id: gen change_votew_illib_2001_2019 = votew_illib[_N] - votew_illib[1]
bysort country_text_id: gen change_votew_popul_2001_2019 = votew_popul[_N] - votew_popul[1]
label variable change_votew_illib_2001_2019 "Change in vote-share-weighted illiberalism score in 2001-19"
label variable change_votew_popul_2001_2019 "Change in vote-share-weighted populism score in 2001-19"

// make observations by country (N=156, not 174 since we deleted observations for which v2pagovsup data is empty (ruling party is unclear))
duplicates drop country_text_id, force
kountry country_text_id, from(iso3c)

keep NAMES_STD mean* change*

// foreach var of varlist mean_seatw_illib_2001_2019 mean_votew_illib_2001_2019 change_seatw_illib_2001_2019 change_votew_illib_2001_2019 mean_seatw_popul_2001_2019 mean_votew_popul_2001_2019 change_seatw_popul_2001_2019 change_votew_popul_2001_2019 {
// 	local lab: variable label `var'
// 	di "`lab'"
// 	egen `var'_sd = std(`var')
// 	drop `var'
// 	rename `var'_sd `var'
// 	label variable `var' "`lab'"
// }

save ${path_data}/vparty_weighted.dta, replace

************************************ Populism: seat-weighted illiberal rhetoric

use ${path_input}/populism/CPD_V-Party_Stata_v1/V-Dem-CPD-Party-V1.dta, clear

***** MAKE NATIONAL MEASURE OF POPULISM AND LIBERALISM *****
// for each year-country group, make a seat-share-weighted populism score 
bysort year country_text_id: egen seatw_illib = wtmean(v2xpa_illiberal), weight(v2paseatshare)
label variable seatw_illib "Seat-share-weighted illiberalism score"

duplicates drop year country_text_id, force
kountry country_text_id, from(iso3c)

keep year NAMES_STD seatw_illib
egen group = group(NAMES_STD)
tsset group year
tsfill, full
ipolate seatw_illib year, epolate gen(seatw_illib_sm) by(group)
sort group NAMES_STD
bysort group: replace NAMES_STD = NAMES_STD[_N]

// for each country, make duplicate observations if they are missing observations for each year 
keep if year >=1980 & year <=2019
egen seatw_illib_sd = std(seatw_illib_sm)
replace seatw_illib = seatw_illib_sd

keep year NAMES_STD seatw_illib 
reshape wide seatw_illib, i(NAMES_STD) j(year)

save ${path_data}/vparty_weighted_seatw_illib.dta, replace

************************************ Populism: seat-weighted populist rhetoric

use ${path_input}/populism/CPD_V-Party_Stata_v1/V-Dem-CPD-Party-V1.dta, clear

***** MAKE NATIONAL MEASURE OF POPULISM AND LIBERALISM *****
// for each year-country group, make a seat-share-weighted populism score 
bysort year country_text_id: egen seatw_popul = wtmean(v2xpa_popul), weight(v2paseatshare)
label variable seatw_popul "Seat-share-weighted populism score"

duplicates drop year country_text_id, force
kountry country_text_id, from(iso3c)

keep year NAMES_STD seatw_popul
egen group = group(NAMES_STD)
tsset group year
tsfill, full
ipolate seatw_popul year, epolate gen(seatw_popul_sm) by(group)

sort group NAMES_STD
bysort group: replace NAMES_STD = NAMES_STD[_N]

keep if year >=1980 & year <=2019
egen seatw_popul_sd = std(seatw_popul_sm)
replace seatw_popul = seatw_popul_sd

keep year NAMES_STD seatw_popul
reshape wide seatw_popul, i(NAMES_STD) j(year)

save ${path_data}/vparty_weighted_seatw_popul.dta, replace

************************************
************************************ Merge all channels data 

*** import countries data 
use ${path_data}/countries.dta, replace

// *** merge with containmenthealth10.dta
// merge 1:1 NAMES_STD using ${path_data}/containmenthealth10.dta
// drop if _merge==2
// drop _merge

// *** merge with coverage10.dta
// merge 1:1 NAMES_STD using ${path_data}/coverage10.dta
// drop if _merge==2
// drop _merge

// *** merge with introduce_policy.dta
// merge 1:1 NAMES_STD using ${path_data}/introduce_policy.dta
// drop if _merge==2
// drop _merge

*** merge with wdi.dta
merge 1:1 NAMES_STD using ${path_data}/wdi.dta
drop if _merge==2
drop _merge

*** merge with pwt.dta
merge 1:1 NAMES_STD using ${path_data}/pwt.dta
drop if _merge==2
drop _merge

*** merge with pwt.dta
merge 1:1 NAMES_STD using ${path_data}/imf.dta
drop if _merge==2
drop _merge

*** merge with ddcg.dta
merge 1:1 NAMES_STD using ${path_data}/ddcg.dta
drop if _merge==2
drop _merge

*** merge with innovation.dta
merge 1:1 NAMES_STD using ${path_data}/innovation.dta
drop if _merge==2
drop _merge

// *** merge with china_import.dta
// merge 1:1 NAMES_STD using ${path_data}/china_import.dta
// drop if _merge==2
// drop _merge

// *** merge with china_export.dta
// merge 1:1 NAMES_STD using ${path_data}/china_export.dta
// drop if _merge==2
// drop _merge

// *** merge with china_export.dta
// merge 1:1 NAMES_STD using ${path_data}/conflict.dta
// drop if _merge==2
// drop _merge

*** merge with fraser.dta
merge 1:1 NAMES_STD using ${path_data}/fraser.dta
drop if _merge==2
drop _merge

*** merge with fraser.dta
merge 1:1 NAMES_STD using ${path_data}/fraser_ftti.dta
drop if _merge==2
drop _merge

*** merge with digital.dta
merge 1:1 NAMES_STD using ${path_data}/digital.dta
drop if _merge==2 
drop _merge

*** merge with digital.dta
merge 1:1 NAMES_STD using ${path_data}/digital_v2smpolsoc.dta
drop if _merge==2 
drop _merge

*** merge with digital.dta
merge 1:1 NAMES_STD using ${path_data}/digital_v2smpolhate.dta
drop if _merge==2 
drop _merge

*** merge with vparty.dta
merge 1:1 NAMES_STD using ${path_data}/vparty_ruling.dta
drop if _merge==2 
drop _merge

*** merge with vparty.dta
merge 1:1 NAMES_STD using ${path_data}/vparty_weighted.dta
drop if _merge==2 
drop _merge

*** merge with vparty.dta
merge 1:1 NAMES_STD using ${path_data}/vparty_weighted_seatw_illib.dta
drop if _merge==2 
drop _merge

*** merge with vparty.dta
merge 1:1 NAMES_STD using ${path_data}/vparty_weighted_seatw_popul.dta
drop if _merge==2 
drop _merge

save ${path_data}/channels.dta, replace
