This folder extends the dataset and several results from "Democracy Does Cause Growth" (Acemoglu, Naidu, Restrepo, Robinson 2019).

Data Extension:
(1) dem.do
	- Creates the dichotomous measure of democracy.
(2) data_extend.do
	- Extends variables from the main dataset.

Results (replication_files_ddcg/do_files):
(1) Figure1_final.do
(2) Figure2_final.do
(3) Figure3_4_5_final.do
	- Table5_final.do must be run before Figure3_4_5_final.do
(4) Figure6_final.do
(5) Table2_final.do
	- Lines 318, 544, 555, 567, 579
(6) Table3_final.do
	- Lines 328, 556, 567, 579, 591
(7) Table4_final.do
	- Lines 139, 456, 467, 478, 489, 500, 512, 524, 536
(8) Table5_final.do
(9) Table6_final.do
	- Lines 139, 453, 464, 475, 486, 498, 510, 523, 535, 546
(10) Table8_final.do
	- Lines 138, 615, 638, 660, 679, 703, 724, 745, 769

Configure START_YEAR and END_YEAR in each file to set the subsample of data used.

(5), (6), (7), (9), and (10) require modifications to the lines of code listed. For each line, manually replace the strings containing START_YEAR and END_YEAR with the appropriately calculated years (see example).

EXAMPLE:

Desired START_YEAR = 1960 and END_YEAR = 2020. 

syntax anything[, ydeep(integer $START_YEAR) ystart(integer $START_YEAR+4) yfinal(integer $END_YEAR-1) truncate(integer 4) depvarlags(integer 4)]
->
syntax anything[, ydeep(integer 1960) ystart(integer 1964) yfinal(integer 2019) truncate(integer 4) depvarlags(integer 4)]
