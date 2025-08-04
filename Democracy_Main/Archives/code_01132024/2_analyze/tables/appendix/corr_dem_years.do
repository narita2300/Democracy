

*** Load data 
use ${path_data}/total.dta, replace

estpost correlate democracy_vdem1980 democracy_vdem1990 democracy_vdem2000 democracy_vdem2010 democracy_vdem2019, matrix listwise
eststo correlate
esttab using ${path_appendix}/dem_corr_years.tex,replace label unstack not noobs compress nostar
