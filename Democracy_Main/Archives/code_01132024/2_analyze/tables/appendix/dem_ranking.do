
clear 

*** Change to appropriate directory
// cd YOUR-DIRECTORY/replication_data
// ex) cd /Users/ayumis/Desktop/replication_data
cd ${path_dropbox}/tables/appendix

*** Load data 
use ${path_data}/total.dta, replace

keep countries total_gdp2019 democracy_vdem2000 democracy_vdem2019
gsort - total_gdp2019
gen rank_total_gdp2019 = _n

gsort - democracy_vdem2000
gen rank_democracy_vdem2000 = _n

gsort - democracy_vdem2019 
gen rank_democracy_vdem2019 = _n
drop total_gdp2019

keep if rank_total_gdp2019 <= 30
egen group = group(rank_total_gdp2019 countries)
labmask group, values(countries)

// eststo clear
// estpost tabstat rank_total_gdp democracy_vdem2000 rank_democracy_vdem2000 democracy_vdem2019 rank_democracy_vdem2019, by(group) 


eststo clear
estpost tabstat rank_total_gdp democracy_vdem2000 rank_democracy_vdem2000 democracy_vdem2019 rank_democracy_vdem2019, by(group) 
esttab using dem_ranking_prelim.tex, cells("democracy_vdem2000(label(`:var lab democracy_vdem2000') fmt(1)) rank_democracy_vdem2000(fmt(0)) democracy_vdem2019(label(`:var lab democracy_vdem2019')) rank_democracy_vdem2019(fmt(0))") noobs nomtitle nonumber tex drop(Total) nonotes replace

include "${path_code}/2_analyze/tables/PanelCombine_simplest.do"
panelcombine, use(${path_appendix}/dem_ranking_prelim.tex) paneltitles(" ") columncount(13) save(${path_appendix}/dem_ranking.tex) cleanup


// esttab using dem_ranking.tex, cells("Total GDP Ranking" "Democracy Ranking 2019" "Democracy Index 2019" "Democracy Ranking 2000" "Democracy Index 2000") order(China) 
