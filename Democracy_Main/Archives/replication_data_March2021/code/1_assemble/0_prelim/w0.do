
kountryadd "Cabo Verde" to "Cape Verde" add
kountryadd "China, People's Republic of" to "China" add
kountryadd "Côte d'Ivoire" to "Cote d'Ivoire" add
kountryadd "Côte d’Ivoire" to "Cote d'Ivoire" add
kountryadd "Eswatini" to "Swaziland" add
kountryadd "Hong Kong SAR" to "Hong Kong" add
kountryadd "Macao SAR" to "Macau" add
kountryadd "Micronesia, Fed. States of" to "Micronesia" add
kountryadd "North Macedonia" to "Macedonia" add
kountryadd "São Tomé and Príncipe" to "Sao Tome and Principe" add
kountryadd "Czechia" to "Czech Republic" add 
kountryadd "Congo, Republic of" to "Congo" add
kountryadd "Congo, Republic of " to "Congo" add
kountryadd "Republic of the Congo" to "Congo" add
kountryadd "Sudan-North" to "Sudan" add
kountryadd "Dem. People's Republic of Korea" to "North Korea" add
kountryadd "Venezuela (Bolivarian Republic of)" to "Venezuela" add
kountryadd "Bolivia (Plurinational State of)" to "Bolivia" add
kountryadd "Korea, Dem. People’s Rep." to "North Korea" add
kountryadd "Republic of Montenegro" to "Montenegro" add
kountryadd "Republic of Serbia" to "Yugoslavia" add
kountryadd "U.S.S.R" to "Russia" add
kountryadd "Democratic Republic Congo" to "Democratic Republic of Congo" add
kountryadd "Sudan (former)" to "Sudan" add
kountryadd "United Kingdom of Great Britain and Northern Ireland" to "United Kingdom" add
kountryadd "Ethiopia PDR" to "Ethiopia" add
kountryadd "Czechoslovakia" to "Czech Republic" add

*** PREPARE COUNTRIES LIST DATA FOR MERGE 
clear
import excel ${path_input}/countries/countries.xlsx, sheet("Sheet1") firstrow
kountry countries, from(other)
save ${path_output}/data/countries.dta, replace
