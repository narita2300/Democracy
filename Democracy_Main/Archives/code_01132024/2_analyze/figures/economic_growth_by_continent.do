
cd /Users/ayumis/Dropbox/democracy/MainAnalysis/output/figures/continents

// run regression between democracy and gdp growth in the 21st century by continent
// World, weighted
graph twoway lfitci mean_growth_rate_2001_2019 democracy_vdem2000  [w=total_gdp2000], title("Democracy and Economic Growth: World, GDP-Weighted OLS",size(textsizestyle)) ytitle("Mean GDP Growth Rate in 2001-2019") legend(order(2 "GDP-Weighted OLS" 1 "95% CI"))|| scatter mean_growth_rate_2001_2019 democracy_vdem2000  [w=total_gdp2000], mlabel(countryiso3)
graph export "world_weighted.png", as(png) replace

graph twoway lfitci mean_growth_rate_2001_2019 democracy_vdem2000, title("Democracy and Economic Growth: World, Unweighted OLS",size(textsizestyle)) ytitle("Mean GDP Growth Rate in 2001-2019") legend(order(2 "GDP-Weighted OLS" 1 "95% CI"))|| scatter mean_growth_rate_2001_2019 democracy_vdem2000  [w=total_gdp2000], mlabel(countryiso3)
graph export "world_unweighted.png", as(png) replace

foreach continent in "Africa" "Asia" "Europe" "North America" "Oceania" "South America" {
	local cont "`continent'"
	graph twoway lfitci mean_growth_rate_2001_2019 democracy_vdem2000 [w=total_gdp2000] if continent =="`cont'", title("Democracy and Economic Growth: `continent', GDP-weighted OLS",size(textsizestyle)) ytitle("Mean GDP Growth Rate in 2001-2019") legend(order(2 "GDP-Weighted OLS" 1 "95% CI")) || scatter mean_growth_rate_2001_2019 democracy_vdem2000 if continent == "`cont'", mlabel(countryiso3)
graph export "`cont'_weighted.png", as(png) replace

	graph twoway lfitci mean_growth_rate_2001_2019 democracy_vdem2000 if continent =="`cont'", title("Democracy and Economic Growth: `continent', Unweighted OLS",size(textsizestyle)) ytitle("Mean GDP Growth Rate in 2001-2019") legend(order(2 "GDP-Weighted OLS" 1 "95% CI")) || scatter mean_growth_rate_2001_2019 democracy_vdem2000 if continent == "`cont'", mlabel(countryiso3)
graph export "`cont'_unweighted.png", as(png) replace
}

