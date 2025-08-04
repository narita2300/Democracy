
*** import data
import excel ${path_input}/IVs/crops_minerals/2003_JME_Tropics_Data.xls, sheet("Sheet1") firstrow clear

keep country code bananas coffee copper maize millet rice silver sugarcane rubber wheat 
kountry code, from(iso3c)

save ${path_output}/data/crops_minerals.dta, replace

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

save ${path_output}/data/crops_supplement.dta, replace

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

save ${path_output}/data/copper.dta, replace

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

save ${path_output}/data/silver.dta, replace

*** merge all the data together
use ${path_output}/data/countries.dta, replace
merge 1:1 NAMES_STD using ${path_output}/data/crops_minerals.dta
drop if _merge==2
drop _merge country code

merge 1:1 NAMES_STD using ${path_output}/data/crops_supplement.dta
drop if _merge==2
drop area _merge

merge 1:1 NAMES_STD using ${path_output}/data/copper.dta
replace copper2=0 if copper2==. & bananas2!=.
drop if _merge==2
drop _merge

merge 1:1 NAMES_STD using ${path_output}/data/silver.dta
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

save ${path_output}/data/crops_minerals.dta, replace



