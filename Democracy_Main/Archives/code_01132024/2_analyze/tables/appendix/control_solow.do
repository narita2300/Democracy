
*** Load data 
use ${path_data}/total.dta, replace

reg mean_growth_rate_2001_2019 democracy_vdem2000 [w=total_gdp2000], robust
reg mean_growth_rate_2001_2019 democracy_vdem2000 loggdppc2000 [w=total_gdp2000], robust
reg mean_growth_rate_2001_2019 democracy_vdem2000 logcapital2000 logpopgrowth2000 logyr_sch2000 loggdppc2000 [w=total_gdp2000], robust

ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv1}) loggdppc2000 [w=total_gdp2000], robust
ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv2}) loggdppc2000 [w=total_gdp2000], robust
ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv3}) loggdppc2000 [w=total_gdp2000], robust
ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv4}) loggdppc2000 [w=total_gdp2000], robust
ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv5}) loggdppc2000 [w=total_gdp2000], robust
ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv6}) loggdppc2000 [w=total_gdp2000], robust

ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv1}) loggdppc2000 [w=total_gdp2000], robust
ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv2}) loggdppc2000 [w=total_gdp2000], robust
ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv3}) loggdppc2000 [w=total_gdp2000], robust
ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv4}) loggdppc2000 [w=total_gdp2000], robust
ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv5}) loggdppc2000 [w=total_gdp2000], robust
ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv6}) loggdppc2000 [w=total_gdp2000], robust

ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv1}) logcapital2000 popgrowth2000 logyr_sch2000 loggdppc2000 [w=total_gdp2000], robust
ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv2}) logcapital2000 popgrowth2000 logyr_sch2000 loggdppc2000 [w=total_gdp2000], robust
ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv3}) logcapital2000 popgrowth2000 logyr_sch2000 loggdppc2000 [w=total_gdp2000], robust
ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv4}) logcapital2000 popgrowth2000 logyr_sch2000 loggdppc2000 [w=total_gdp2000], robust
ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv5}) logcapital2000 popgrowth2000 logyr_sch2000 loggdppc2000 [w=total_gdp2000], robust
ivreg2 mean_growth_rate_2001_2019 (democracy_vdem2000=${iv6}) logcapital2000 popgrowth2000 logyr_sch2000 loggdppc2000 [w=total_gdp2000], robust

