
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
