
************************************
************************************

clear all
macro drop _all
set more off 
pause on

************************************
************************************ set directory


**** CHANGE:
cd /YOUR_FOLDER/replication_data
// cd /Users/ayumis/Desktop/replication_data

************************************
************************************ set folders for results and data

**** CHANGE:
*path for code
global path_code /YOUR_FOLDER/replication_data/code
//global path_code /Users/ayumis/Desktop/replication_data/code

* path for input
global path_input /YOUR_FOLDER/replication_data/input
// global path_input /Users/ayumis/Desktop/replication_data/input


* path for ouput
global path_output /YOUR_FOLDER/replication_data/output
// global path_output   /Users/ayumis/Desktop/replication_data/output

stop
************************************
************************************ Assemble data

do ${path_code}/1_assemble/0_prelim/w0.do

do ${path_code}/1_assemble/1_outcomes/w1.do
do ${path_code}/1_assemble/1_outcomes/w2.do
do ${path_code}/1_assemble/1_outcomes/w3.do

do ${path_code}/1_assemble/2_democracy/w4.do
do ${path_code}/1_assemble/2_democracy/w5.do
do ${path_code}/1_assemble/2_democracy/w6.do
do ${path_code}/1_assemble/2_democracy/w7.do

do ${path_code}/1_assemble/3_controls/w8.do
do ${path_code}/1_assemble/3_controls/w9.do
do ${path_code}/1_assemble/3_controls/w10.do
do ${path_code}/1_assemble/3_controls/w11.do
do ${path_code}/1_assemble/3_controls/w12.do
do ${path_code}/1_assemble/3_controls/w13.do
do ${path_code}/1_assemble/3_controls/w14.do
do ${path_code}/1_assemble/3_controls/w15.do
do ${path_code}/1_assemble/3_controls/w16.do

do ${path_code}/1_assemble/4_IVs/w17.do
do ${path_code}/1_assemble/4_IVs/w18.do
do ${path_code}/1_assemble/4_IVs/w19.do
do ${path_code}/1_assemble/4_IVs/w20.do
do ${path_code}/1_assemble/4_IVs/w21.do
do ${path_code}/1_assemble/4_IVs/w22.do

do ${path_code}/1_assemble/5_channels/w23.do
do ${path_code}/1_assemble/5_channels/w24.do
do ${path_code}/1_assemble/5_channels/w25.do

do ${path_code}/1_assemble/6_all/w26.do

************************************
************************************ 
