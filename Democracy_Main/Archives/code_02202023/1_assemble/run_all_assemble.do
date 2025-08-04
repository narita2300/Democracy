
************************************
************************************

clear all
macro drop _all
set more off 
pause on

************************************
************************************ set directory

**** CHANGE:
cd /Users/ayumis/Dropbox/democracy/MainAnalysis

************************************
************************************ set folders for results and data

*path for code
global path_code /Users/ayumis/Dropbox/democracy/MainAnalysis/code

* path for input
global path_input /Users/ayumis/Dropbox/democracy/MainAnalysis/input

* path for output data
global path_data  /Users/ayumis/Dropbox/democracy/MainAnalysis/output/data

************************************
************************************ Assemble data

do ${path_code}/1_assemble/0_prelim.do
do ${path_code}/1_assemble/1_outcomes.do
do ${path_code}/1_assemble/3_controls.do
do ${path_code}/1_assemble/4_IVs.do
do ${path_code}/1_assemble/5_channels.do
do ${path_code}/1_assemble/6_all.do

************************************
************************************ 
