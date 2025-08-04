

*** Load data 
use ${path_data}/total.dta, replace

estpost correlate democracy_vdem2019 democracy_csp2018 democracy_fh2019 democracy_eiu2019, matrix listwise
eststo correlate
esttab using ${path_appendix}/9_dem_corr_2019.tex,replace label unstack not noobs compress nostar

eststo clear
estpost correlate democracy_vdem2000 democracy_csp2000 democracy_fh2003 democracy_eiu2006, matrix listwise
eststo correlate

esttab using ${path_appendix}/9_dem_corr_2000.tex, replace label unstack not noobs compress nostar
