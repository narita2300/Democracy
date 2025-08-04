
clear 

*** Load data 
use ${path_data}/total.dta, replace

rename tot_dem_vdem_change_2000_2019 tot_change_2000_2019
replace tot_change_2000_2019 = tot_change_2000_2019*10


keep countries total_gdp2019 tot_change_2000_2019
gsort - total_gdp2019
gen rank_total_gdp2019 = _n

gsort - tot_change_2000_2019
gen rank_tot = _n

drop total_gdp2019

keep if rank_total_gdp2019 <= 30
egen group = group(rank_total_gdp2019 countries)
labmask group, values(countries)


eststo clear
estpost tabstat rank_total_gdp tot_change_2000_2019 rank_tot, by(group) 
esttab using dem_change_ranking_prelim.tex, cells("tot_change_2000_2019(label(`:var lab tot_change_2000_2019') fmt(1)) rank_tot(fmt(0))") noobs nomtitle nonumber tex drop(Total) nonotes replace

include "${path_code}/2_analyze/tables/PanelCombine_simplest.do"
panelcombine, use(dem_change_ranking_prelim.tex) paneltitles(" ") columncount(13) save(dem_change_ranking.tex) cleanup
