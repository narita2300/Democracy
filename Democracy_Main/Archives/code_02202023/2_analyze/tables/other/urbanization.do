

ivregress 2sls gdp_growth2020 (democracy_vdem2019=urban1500)  [w=total_gdp2019], vce(robust)
ivregress 2sls mean_growth_rate_2001_2019 (democracy_vdem2000=urban1500)  [w=total_gdp2000], vce(robust)
ivregress 2sls total_deaths_per_million (democracy_vdem2019=urban1500)  [w=total_gdp2019], vce(robust)

ivregress 2sls gdp_growth2020 abs_lat mean_precip_1991_2016 mean_temp_1991_2016  (democracy_vdem2019=urban1500)  [w=total_gdp2019], vce(robust)
ivregress 2sls mean_growth_rate_2001_2019 abs_lat mean_precip_1991_2016 mean_temp_1991_2016 (democracy_vdem2000=urban1500)  [w=total_gdp2000], vce(robust)
ivregress 2sls total_deaths_per_million abs_lat mean_precip_1991_2016 mean_temp_1991_2016 (democracy_vdem2019=urban1500)  [w=total_gdp2019], vce(robust)

ivregress 2sls gdp_growth2020 abs_lat mean_precip_1991_2016 mean_temp_1991_2016  (democracy_vdem2019=urban1500)  [w=total_gdp2019], vce(robust)
