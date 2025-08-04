
************************************
************************************ settler mortality

*** import data
use ${path_input}/IVs/settler_mortality/maketable5.dta, replace
// replace baseco=1 if shortnam=="CHN"
// keep if baseco==1
keep shortnam logem4
kountry shortnam, from(iso3c)
rename logem4 logem

save ${path_data}/settler_mortality.dta, replace

*** merge with countries data 
use ${path_data}/countries.dta, replace
merge 1:1 NAMES_STD using ${path_data}/settler_mortality.dta
drop if _merge==2
keep countries iso3 NAMES_STD logem

*** save
save ${path_data}/settler_mortality.dta, replace

************************************
************************************ language and trade

*** import data
import excel ${path_input}/IVs/lang_frankelromer/hj.xlsx, sheet("Sheet1") firstrow clear
drop if Code=="----" //drop first row
keep Code Country EngFrac EurFrac logFrankRom
kountry Code, from(iso3c) m

//fix some NAs
replace NAMES_STD="Czech Republic" if Code=="CSK"
replace NAMES_STD="Russia" if Code=="SUN"
replace NAMES_STD="Myanmar" if Code=="BUR"

save ${path_data}/lang_frankelromer.dta, replace

*** merge with countries data 
use ${path_data}/countries.dta, replace
merge 1:1 NAMES_STD using ${path_data}/lang_frankelromer.dta
drop if _merge==2
keep countries iso3 NAMES_STD EngFrac EurFrac logFrankRom

*** save
save ${path_data}/lang_frankelromer.dta, replace

************************************
************************************ legal origin

*** import data
import excel ${path_input}/IVs/legal_origin/EconomicCon_data.xls, sheet("Table 1") firstrow clear

drop if anti_sd =="" //drop parts that are not data
keep country code legor_uk legor_fr legor_ge legor_sc legor_so
drop if legor_uk=="."
kountry code, from(iso3c) m
drop if MARKER==0
drop MARKER
save ${path_data}/legal_origin.dta, replace

*** merge with countries data 
use ${path_data}/countries.dta, replace
merge 1:1 NAMES_STD using ${path_data}/legal_origin.dta
drop if _merge==2
keep countries iso3 NAMES_STD legor_uk legor_fr legor_ge legor_sc legor_so
destring legor*, replace


*** save
save ${path_data}/legal_origin.dta, replace


************************

*** import data
import excel ${path_input}/IVs/legal_origin/landfweb_0-2.xls, sheet("data") firstrow clear
keep name uk_mom frsp_mom scan_mom ger_mom civ_com
kountry name, from(other)
drop name
rename civ_com civil_law

merge 1:1 NAMES_STD using ${path_data}/legal_origin.dta
drop if _merge==1
drop _merge
replace civil_law=1 if NAMES_STD=="China"
// replace uk_mom=0 if NAMES_STD =="China"
// replace frsp_mom=0 if NAMES_STD =="China"
// replace scan_mom=0 if NAMES_STD =="China"
// replace ger_mom = 1 if NAMES_STD=="China"

*** save
save ${path_data}/legal_origin.dta, replace

************************************
************************************ crops and minerals


*** import data
import excel ${path_input}/IVs/crops_minerals/2003_JME_Tropics_Data.xls, sheet("Sheet1") firstrow clear

keep country code bananas coffee copper maize millet rice silver sugarcane rubber wheat 
kountry code, from(iso3c)

save ${path_data}/crops_minerals.dta, replace

*** load supplement data for crops
import delimited ${path_input}/IVs/crops_minerals/crops_supplement/FAOSTAT_data.csv, encoding(UTF-8) clear
keep area item 

gen bananas_d = 0
replace bananas_d=1 if item=="Bananas"
gen coffee_d = 0
replace coffee_d=1 if item=="Coffee, green"
gen maize_d = 0
replace maize_d = 1 if item=="Maize"
gen millet_d = 0
replace millet_d = 1 if item=="Millet"
gen rice_d = 0
replace rice_d = 1 if item=="Rice, paddy"
gen rubber_d = 0 
replace rubber_d = 1 if item=="Rubber, natural"
gen sugarcane_d = 0
replace sugarcane_d = 1 if item=="Sugar cane"
gen wheat_d = 0
replace wheat_d = 1 if item=="Wheat"

bysort area: egen bananas2 = max(bananas_d)
bysort area: egen coffee2 = max(coffee_d)
bysort area: egen maize2 = max(maize_d)
bysort area: egen millet2 = max(millet_d)
bysort area: egen rice2 = max(rice_d)
bysort area: egen rubber2 = max(rubber_d)
bysort area: egen sugarcane2 = max(sugarcane_d)
bysort area: egen wheat2 = max(wheat_d)

bysort area: gen dup = cond(_N==1, 0,_n) 
drop if dup > 1
drop *_d dup item

kountry area, from(other) m
drop if MARKER==0
drop MARKER

//prevent NAs
drop if area == "China, mainland"
replace NAMES_STD="Czech Republic" if area=="Czechoslovakia"
expand 2 if area=="Belgium-Luxembourg", generate(dup)
replace NAMES_STD="Belgium" if area=="Belgium-Luxembourg" & dup == 0
replace NAMES_STD="Luxembourg" if area=="Belgium-Luxembourg" & dup == 1
drop dup

save ${path_data}/crops_supplement.dta, replace

*** load supplement data for copper
import excel "$path_input/IVs/crops_minerals/minerals_supplement/Copper Workbook February 2019.xlsx", sheet("Cu Mine Production") cellrange(A4:W87) clear
keep B D
drop if D==.
drop if B==""
gen copper2 = 1
kountry B, from(other) m
drop if MARKER ==0
drop MARKER
keep NAMES_STD copper2

save ${path_data}/copper.dta, replace

*** load supplement data for silver
import excel "$path_input/IVs/crops_minerals/minerals_supplement/Silver Workbook February 2019.xlsx", sheet("Ag Mine Production") cellrange(A8:W92) clear

keep B D
drop if D==.
drop if B==""

gen silver2 = 1
kountry B, from(other) m
drop if MARKER ==0
drop MARKER

keep NAMES_STD silver2

save ${path_data}/silver.dta, replace

*** merge all the data together
use ${path_data}/countries.dta, replace
merge 1:1 NAMES_STD using ${path_data}/crops_minerals.dta
drop if _merge==2
drop _merge country code

merge 1:1 NAMES_STD using ${path_data}/crops_supplement.dta
drop if _merge==2
drop area _merge

merge 1:1 NAMES_STD using ${path_data}/copper.dta
replace copper2=0 if copper2==. & bananas2!=.
drop if _merge==2
drop _merge

merge 1:1 NAMES_STD using ${path_data}/silver.dta
replace silver2=0 if silver2==. & bananas2!=.
drop if _merge==2
drop _merge


//if the observation in the original data is NA, replace with data from crops_supplement.dta
replace bananas=bananas2 if bananas==.
replace coffee=coffee2 if coffee==.
replace copper=copper2 if copper==.
replace maize=maize2 if maize==.
replace millet=millet2 if millet==.
replace rice=rice2 if rice==.
replace silver=silver2 if silver==.
replace sugarcane=sugarcane2 if sugarcane==.
replace rubber=rubber2 if rubber==.
replace wheat=wheat2 if wheat==.

drop *2

save ${path_data}/crops_minerals.dta, replace

************************************
************************************ population density

*** import data
use ${path_input}/IVs/pop_density/unbundle.dta, clear
// replace ex2col=1 if country == "United Arab Emirates"
// replace ex2col=1 if country == "Brunei"
// replace ex2col=1 if country == "Equatorial Guinea"
// replace ex2col=1 if country == "Iran, Islamic Rep."
// replace ex2col=1 if country == "Iraq"
// replace ex2col=1 if country == "Japan"
// replace ex2col=1 if country == "Jordan"
// replace ex2col=1 if country == "Kuwait"
// replace ex2col=1 if country == "Lebanon"
// replace ex2col=1 if country == "Liberia"
// replace ex2col=1 if country == "Oman"
// replace ex2col=1 if country == "Qatar"
replace ex2col=1 if shortnam == "CHN"
// replace ex2col=1 if shortnam == "IRQ"
// replace ex2col=1 if shortnam == "KOR"
// replace ex2col=1 if shortnam == "LBN"
// // replace ex2col=1 if shortnam == "PRK"
// replace ex2col=1 if shortnam == "SYR"
// replace ex2col=1 if shortnam == "TWN"


// replace ex2col=1 if country == "Saudi Arabia"
// replace ex2col=1 if country == "Turkey"
replace lpd1500s=. if ex2col!=1
kountry shortnam, from(iso3c)

save ${path_data}/pop_density.dta, replace

*** merge with country data
use ${path_data}/countries.dta, replace
merge 1:1 NAMES_STD using ${path_data}/pop_density.dta
drop if _merge==2
drop _merge 
keep countries iso3 NAMES_STD lpd1500s ex2col sjlouk

save ${path_data}/pop_density.dta, replace

*** import data for urbanization in 1500s ***
use ${path_input}/IVs/pop_density/maketable3.dta, clear
replace sjb1500 = . if baserf!=1
keep shortnam sjb1500
keep if shortnam!=""
kountry shortnam, from(iso3c)

save ${path_data}/urban1500.dta, replace

*** merge with country data 
use ${path_data}/countries.dta, replace
merge 1:m NAMES_STD using ${path_data}/urban1500.dta
drop if _merge==2
bysort NAMES_STD: gen dup = cond(_N==1,0,_n)
drop if dup==2
keep countries iso3 NAMES_STD sjb1500
rename sjb1500 urban1500

save ${path_data}/urban1500.dta, replace

************************************
************************************ merge all IV data

*** import countries data 
use ${path_data}/countries.dta, replace


*** merge with settler_mortality.dta
merge 1:1 NAMES_STD using ${path_data}/settler_mortality.dta, nogenerate

*** merge with lang_frankelromer.dta 
merge 1:1 NAMES_STD using ${path_data}/lang_frankelromer.dta, nogenerate

*** merge with legal_origin.dta 
merge 1:1 NAMES_STD using ${path_data}/legal_origin.dta, nogenerate

*** merge with crops_minerals.dta 
merge 1:1 NAMES_STD using ${path_data}/crops_minerals.dta, nogenerate

*** merge with pop_density.dta 
merge 1:1 NAMES_STD using ${path_data}/pop_density.dta, nogenerate

*** merge with urbanization in 1500s data
merge 1:1 NAMES_STD using ${path_data}/urban1500.dta, nogenerate

*** convert strings to numeric 
destring *Frac, replace
destring logFrankRom, replace ignore("NaN")
*** save data
save ${path_data}/IVs.dta, replace



