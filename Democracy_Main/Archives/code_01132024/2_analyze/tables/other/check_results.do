

use ${path_output}/total.dta, replace
replace ex2col = 1 if country == "China"

// BASELINE RESULTS 

ivregress 2sls gdp_growth2020 (democracy_csp2018=lpd1500s)  [w=total_gdp2019], vce(robust)
ivregress 2sls mean_growth_rate_2001_2019 (democracy_csp2000=lpd1500s)  [w=total_gdp2000], vce(robust)
ivregress 2sls total_deaths_per_million (democracy_csp2018=lpd1500s)  [w=total_gdp2019], vce(robust)

ivregress 2sls gdp_growth2020 abs_lat mean_precip_1991_2016 mean_temp_1991_2016  (democracy_csp2018=lpd1500s)  [w=total_gdp2019], vce(robust)
ivregress 2sls mean_growth_rate_2001_2019 abs_lat mean_precip_1991_2000 mean_temp_1991_2000 (democracy_csp2000=lpd1500s)  [w=total_gdp2000], vce(robust)
ivregress 2sls total_deaths_per_million abs_lat mean_precip_1991_2016 mean_temp_1991_2016 (democracy_csp2018=lpd1500s)  [w=total_gdp2019], vce(robust)


// ivregress 2sls gdp_growth2020 (democracy_csp2018=lpd1500s)  [w=total_gdp2019]  if ex2col ==1, vce(robust)
// ivregress 2sls mean_growth_rate_2001_2019 (democracy_csp2000=lpd1500s)  [w=total_gdp2000]  if ex2col ==1, vce(robust)
// ivregress 2sls total_deaths_per_million (democracy_csp2018=lpd1500s)  [w=total_gdp2019]  if ex2col ==1, vce(robust)


// ivregress 2sls gdp_growth2020 abs_lat mean_precip_1991_2016 mean_temp_1991_2016 (democracy_csp2018=lpd1500s)  [w=total_gdp2019]  if ex2col ==1, vce(robust)
// ivregress 2sls mean_growth_rate_2001_2019 abs_lat mean_precip_1991_2000 mean_temp_1991_2000 (democracy_csp2000=lpd1500s)  [w=total_gdp2000] if ex2col ==1, vce(robust)
// ivregress 2sls total_deaths_per_million abs_lat mean_precip_1991_2016 mean_temp_1991_2016 (democracy_csp2018=lpd1500s)  [w=total_gdp2019] if ex2col ==1, vce(robust)


ivregress 2sls gdp_growth2020 (democracy_vdem2019=lpd1500s)  [w=total_gdp2019], vce(robust)
ivregress 2sls mean_growth_rate_2001_2019 (democracy_vdem2000=lpd1500s)  [w=total_gdp2000], vce(robust)
ivregress 2sls total_deaths_per_million (democracy_vdem2019=lpd1500s)  [w=total_gdp2019], vce(robust)

ivregress 2sls gdp_growth2020 abs_lat mean_precip_1991_2016 mean_temp_1991_2016  (democracy_vdem2019=lpd1500s)  [w=total_gdp2019], vce(robust)
ivregress 2sls gdp_growth2020 abs_lat mean_precip_1991_2016 mean_temp_1991_2016  (democracy_vdem2019=lpd1500s)  [w=total_gdp2019] if ex2col ==1, vce(robust)

estat firststage
ivregress 2sls mean_growth_rate_2001_2019 abs_lat mean_precip_1991_2000 mean_temp_1991_2000 (democracy_vdem2000=lpd1500s)  [w=total_gdp2000], vce(robust)
ivregress 2sls total_deaths_per_million abs_lat mean_precip_1991_2016 mean_temp_1991_2016 (democracy_vdem2019=lpd1500s)  [w=total_gdp2019], vce(robust)

ivregress 2sls gdp_growth2020 (democracy_vdem2019=lpd1500s)  [w=total_gdp2019]  if ex2col ==1, vce(robust)
ivregress 2sls mean_growth_rate_2001_2019 (democracy_vdem2000=lpd1500s)  [w=total_gdp2000]  if ex2col ==1, vce(robust)
ivregress 2sls total_deaths_per_million (democracy_vdem2019=lpd1500s)  [w=total_gdp2019]  if ex2col ==1, vce(robust)

// ivregress 2sls gdp_growth2020 abs_lat mean_precip_1991_2016 mean_temp_1991_2016 (democracy_vdem2018=logem)  [w=total_gdp2019], vce(robust)
// estat firststage

ivregress 2sls gdp_growth2020 abs_lat mean_precip_1991_2016 mean_temp_1991_2016 pop_density2020 median_age2020 diabetes_prevalence2019 (democracy_vdem2019=lpd1500s)  [w=total_gdp2019]  if ex2col ==1, vce(robust)


estat firststage
ivregress 2sls mean_growth_rate_2001_2019 abs_lat mean_precip_1991_2000 mean_temp_1991_2000 (democracy_vdem2000=lpd1500s)  [w=total_gdp2000] if ex2col ==1, vce(robust)
ivregress 2sls total_deaths_per_million abs_lat mean_precip_1991_2016 mean_temp_1991_2016 (democracy_vdem2019=lpd1500s)  [w=total_gdp2019] if ex2col ==1, vce(robust)
estat firststage

ivregress 2sls gdp_growth2020 mean_precip_1991_2016 mean_temp_1991_2016 (democracy_vdem2019=lpd1500s)  [w=total_gdp2019] if ex2col ==1, vce(robust)
ivregress 2sls gdp_growth2020 abs_lat mean_precip_1991_2016 mean_temp_1991_2016 (democracy_vdem2019=lpd1500s)  [w=total_gdp2019]  if ex2col ==1, vce(robust)
ivregress 2sls mean_growth_rate_2001_2019 abs_lat mean_precip_1991_2000 mean_temp_1991_2000 (democracy_vdem2000=lpd1500s)  [w=total_gdp2000] if ex2col ==1, vce(robust)
ivregress 2sls total_deaths_per_million abs_lat mean_precip_1991_2016 mean_temp_1991_2016 (democracy_vdem2019=lpd1500s)  [w=total_gdp2019] if ex2col ==1, vce(robust)


// ivregress 2sls gdp_growth2020 abs_lat  (democracy_csp2018=lpd1500s)  [w=total_gdp2019]  if ex2col ==1, vce(robust)
// ivregress 2sls mean_growth_rate_2001_2019 abs_lat (democracy_csp2000=lpd1500s)  [w=total_gdp2000] if ex2col ==1, vce(robust)
// ivregress 2sls total_deaths_per_million abs_lat (democracy_csp2018=lpd1500s)  [w=total_gdp2019] if ex2col ==1, vce(robust)

// ivregress 2sls gdp_growth2020 abs_lat mean_precip_1991_2016 mean_temp_1991_2016 (democracy_vdem2019=lpd1500s)  [w=total_gdp2019], vce(robust)
// ivregress 2sls mean_growth_rate_2001_2019 abs_lat (democracy_vdem2019=lpd1500s)  [w=total_gdp2000] if ex2col ==1, vce(robust)
// ivregress 2sls total_deaths_per_million abs_lat (democracy_vdem2019=lpd1500s)  [w=total_gdp2019] if ex2col ==1, vce(robust)

// ivregress 2sls gdp_growth2020 (democracy_vdem2019=lpd1500s)  [w=total_gdp2019]  if ex2col ==1, vce(robust)
// ivregress 2sls mean_growth_rate_2001_2019 (democracy_csp2000=lpd1500s)  [w=total_gdp2000]  if ex2col ==1, vce(robust)
// ivregress 2sls total_deaths_per_million (democracy_vdem2019=lpd1500s)  [w=total_gdp2019]  if ex2col ==1, vce(robust)


// ivregress 2sls gdp_growth2020 (democracy_vdem2019=lpd1500s)  [w=total_gdp2019] if ex2col ==1, vce(robust)
// ivregress 2sls mean_growth_rate_2001_2019 (democracy_vdem2019=lpd1500s)  [w=total_gdp2000] if ex2col ==1, vce(robust)
// ivregress 2sls total_deaths_per_million (democracy_vdem2019=lpd1500s)  [w=total_gdp2019] if ex2col ==1, vce(robust)


// UNWEIGHTED RESULTS 

ivregress 2sls gdp_growth2020 (democracy_vdem2019=lpd1500s) if ex2col ==1, vce(robust)
ivregress 2sls mean_growth_rate_2001_2019 (democracy_vdem2019=lpd1500s) if ex2col ==1, vce(robust)
ivregress 2sls total_deaths_per_million (democracy_vdem2019=lpd1500s)if ex2col ==1, vce(robust)

ivregress 2sls gdp_growth2020 abs_lat (democracy_vdem2019=lpd1500s) if ex2col ==1, vce(robust)
ivregress 2sls mean_growth_rate_2001_2019 abs_lat (democracy_vdem2019=lpd1500s) if ex2col ==1, vce(robust)
ivregress 2sls total_deaths_per_million abs_lat (democracy_vdem2019=lpd1500s)if ex2col ==1, vce(robust)

// SAMPLE EXCLUDES US AND CHINA
drop if countries=="United States"
drop if countries=="China"

ivregress 2sls gdp_growth2020 (democracy_vdem2019=lpd1500s) [w=total_gdp2019], vce(robust)
ivregress 2sls mean_growth_rate_2001_2019 (democracy_vdem2019=lpd1500s) [w=total_gdp2000] if ex2col ==1, vce(robust)
ivregress 2sls total_deaths_per_million (democracy_vdem2019=lpd1500s)[w=total_gdp2019] if ex2col ==1, vce(robust)

ivregress 2sls gdp_growth2020 abs_lat mean_precip_1991_2000 mean_temp_1991_2000 (democracy_vdem2019=lpd1500s) [w=total_gdp2019], vce(robust)
ivregress 2sls mean_growth_rate_2001_2019 abs_lat (democracy_vdem2019=lpd1500s) [w=total_gdp2000] if ex2col ==1, vce(robust)
ivregress 2sls total_deaths_per_million abs_lat (democracy_vdem2019=lpd1500s)[w=total_gdp2019] if ex2col ==1, vce(robust)


ivregress 2sls total_deaths_per_million (democracy_vdem2019=lpd1500s)[w=total_gdp2019], vce(robust)
ivregress 2sls total_deaths_per_million abs_lat (democracy_vdem2019=lpd1500s)[w=total_gdp2019], vce(robust)
