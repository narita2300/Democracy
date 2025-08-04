
*** import data
import excel ${path_input}/IVs/lang_frankelromer/hj.xlsx, sheet("Sheet1") firstrow clear
drop if Code=="----" //drop first row
keep Code Country EngFrac EurFrac logFrankRom
kountry Code, from(iso3c) m

//fix some NAs
replace NAMES_STD="Czech Republic" if Code=="CSK"
replace NAMES_STD="Russia" if Code=="SUN"
replace NAMES_STD="Myanmar" if Code=="BUR"

save ${path_output}/data/lang_frankelromer.dta, replace

*** merge with countries data 
use ${path_output}/data/countries.dta, replace
merge 1:1 NAMES_STD using ${path_output}/data/lang_frankelromer.dta
drop if _merge==2
keep countries iso3 NAMES_STD EngFrac EurFrac logFrankRom

*** save
save ${path_output}/data/lang_frankelromer.dta, replace
