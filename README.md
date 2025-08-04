# Democracy Project: Curse of Democracy - Evidence from a Pandemic

**Replication Package for "Curse of Democracy: Evidence from a Pandemic" by Yusuke Narita and Ayumi Sudo**

This repository contains the complete replication package for empirical analysis examining the effects of democracy on economic and health outcomes during the 2020 pandemic. The project includes the final datasets used in the empirical analysis, the code to assemble it, and the code to generate all the empirical results.

## Project Components

1. **Democracy_Main**: Main analysis for the "Curse of Democracy" paper
2. **Dem_Growth_Extend**: Extension of the "Democracy Does Cause Growth" dataset and results (Acemoglu, Naidu, Restrepo, Robinson 2019)

## System Requirements

### Software Dependencies and Operating Systems

**Required Software:**
- **Stata** 15.0 or higher (tested on Stata 16, 17)
  - Required Stata packages: `estout`, `kountry`, `_gwtmean`, `ivreg2`, `ranktest`, `labutil`
- **R** 4.0.0 or higher (tested on R 4.1.0, 4.2.0)
  - Required R packages: `ggplot2`, `viridis`, `hrbrthemes`, `tidyverse`, `haven`, `ggrepel`, `systemfonts`, `ggthemes`, `wid`, `readxl`, `readr`, `countrycode`, `collapse`, `stargazer`, `remotes`
- **Python** 3.8 or higher (tested on Python 3.10.9)
  - Required Python packages: `pandas`, `numpy`, `matplotlib`, `scipy`, `warnings`
- **Jupyter Notebook** (for Python data preparation scripts)

**Operating Systems:**
- **macOS** 10.15 or higher (primary development environment)
- **Windows** 10 or higher (compatible)
- **Linux** Ubuntu 18.04 or higher (compatible)

### Versions Tested On
- macOS 14.5.0 (Darwin 24.5.0)
- Stata 17
- R 4.3.0
- Python 3.10.9

### Required Non-Standard Hardware
- **Minimum**: 8 GB RAM, 50 GB free disk space
- **Recommended**: 16 GB RAM, 100 GB free disk space
- **High-performance computing cluster** (recommended for Dem_Growth_Extend component - tested on Yale's Grace cluster)

## Installation Guide

### Instructions

1. **Clone or download the repository:**
   ```bash
   git clone [repository-url]
   cd Democracy
   ```

2. **Install Stata packages:**
   Open Stata and run:
   ```stata
   ssc install estout, replace
   ssc install kountry, replace
   ssc install _gwtmean, replace
   ssc install ivreg2, replace
   ssc install ranktest, replace
   ssc install labutil, replace
   ```

3. **Install R packages:**
   Open R and run:
   ```r
   install.packages(c("ggplot2", "viridis", "hrbrthemes", "tidyverse", 
                      "haven", "ggrepel", "systemfonts", "ggthemes", 
                      "wid", "readxl", "readr", "countrycode", 
                      "collapse", "stargazer", "remotes"))
   remotes::install_github("Gedevan-Aleksizde/fontregisterer")
   ```

4. **Install Python packages:**
   ```bash
   pip install pandas numpy matplotlib scipy jupyter
   ```

5. **Configure paths:**
   Run the automated setup script:
   ```bash
   chmod +x set_paths.sh
   ./set_paths.sh
   ```
   
   For Dem_Growth_Extend component:
   ```bash
   chmod +x set_do_paths.sh
   ./set_do_paths.sh
   ```

### Typical Install Time on a "Normal" Desktop Computer
- Software installation: 15-30 minutes
- Data download and setup: 10-15 minutes
- **Total installation time: 25-45 minutes**

## Demo

### Instructions to Run on Data

**Quick Start Demo:**

1. **Configure paths** (if not done during installation):
   ```bash
   ./set_paths.sh
   ```

2. **Complete reproduction using run_all.do:**
   ```stata
   cd Democracy_Main/MainAnalysis/code
   do run_all.do
   ```
   This single command runs all Stata analysis files and generates the main results.

3. **Run R visualizations individually:**
   After setting file paths, run these R scripts:
   ```r
   # Main paper figures
   source("Democracy_Main/MainAnalysis/code/2_analyze/figures/main/figure1.R")
   source("Democracy_Main/MainAnalysis/code/2_analyze/figures/main/figure2.R")
   
   # Additional R scripts (run individually)
   source("table2_invalid_iv.R")
   source("table1.R")
   source("02_descriptive_stats.R")
   source("01_corr_auto_notitle.R")
   source("01_corr_auto_notitle_quad.R")
   source("figure1_change.R")
   ```

4. **Extended analysis (Dem_Growth_Extend):**
   ```stata
   cd Dem_Growth_Extend
   do dem.do                    // Creates dichotomous democracy measure
   do data_extend.do           // Extends main dataset variables
   ```

### Expected Output

The replication package generates three main categories of output:

**Main Paper Results:**
- **Table 1**: 2SLS and GMM Estimates of Democracy's Effects
  - `table2_panelA.tex`, `table2_panelB.tex`, `table2_invalid_iv_panelC.tex`
- **Table 2**: Mechanisms Behind Democracy's Effect in 2001-2019
  - `fitable3fA.tex`
- **Figure 1**: Correlation Between Democracy and Outcomes
  - `figure1a.png`, `figure1b.png`, `figure1c.png`
- **Figure 2**: Causal Effects of Democracy: First Look
  - `figure2a.png`, `figure2b.png`, `figure2c.png`, `figure2d.png`, `figure2e.png`, `figure2f1.png`

**Appendix Results:**
- Comprehensive descriptive statistics tables
- Robustness checks and alternative specifications
- Additional mechanism analyses
- Correlation plots and reduced form figures

**Extended Analysis Results:**
- Table: Effect of Democracy on (Log) GDP per Capita (multiple time periods)
- Table: IV Estimates of the Effect of Democracy on (Log) GDP per Capita
- Figure: Dynamic Panel Model Estimates

### Expected Run Time for Demo on a "Normal" Desktop Computer
- **Main analysis (run_all.do)**: 45-60 minutes
- **Individual R scripts**: 10-15 minutes total
- **Extended analysis**: 30-45 minutes
- **Total demo run time: 85-120 minutes**

## Instructions for Use

### Project Structure

The main analysis is organized into three folders:

- **`code`**: Contains code to assemble final datasets and generate all tables and figures
  - `1_assemble`: Code to assemble the final dataset `total.dta`
  - `2_analyze`: Code to generate figures, descriptive statistics, and regression results
- **`input`**: Stores all raw data necessary to assemble the final dataset
- **`output`**: Stores all code output (tables, figures, processed data)

### How to Run the Software on Your Data

**Complete Reproduction:**

The easiest way to reproduce all results is to run the master script:

```stata
cd Democracy_Main/MainAnalysis/code
do run_all.do
```

**Note**: Update file paths in `run_all.do` on lines 17-36 before running.

**Manual Step-by-Step Reproduction:**

1. **Data Assembly:**
   ```stata
   do 1_assemble/0_prelim.do
   do 1_assemble/1_outcomes.do
   do 1_assemble/2_democracy.do
   do 1_assemble/3_controls.do
   do 1_assemble/4_IVs.do
   do 1_assemble/5_channels.do
   do 1_assemble/6_all.do
   ```

2. **Main Analysis:**
   ```stata
   do 2_analyze/tables/main/table2.do
   do 2_analyze/tables/main/final_table_mech.do
   ```

3. **Appendix Analysis:**
   Run all scripts in `2_analyze/tables/appendix/` directory

### R Script Configuration

R files must be run individually after setting file paths. Update the following line numbers in each script:

- `table2_invalid_iv.R`: lines 15 and 17
- `figure1.R`: lines 12 and 14  
- `table1.R`: lines 18 and 20
- `02_descriptive_stats.R`: lines 16 and 18
- `01_corr_auto_notitle.R`: lines 9 and 11
- `01_corr_auto_notitle_quad.R`: lines 9 and 11
- `figure1_change.R`: lines 12 and 14

### Manually Created Tables

The following tables are manually created (not generated by code):
- Table: Data Sources and Description
- Table: Directions of Potential Bias in the IV Estimates

### Extended Analysis (High-Performance Computing)

Some results require separate code from `Dem_Growth_Extend` and should be run on a computing cluster:

**Required for:**
- Table: Effect of Democracy on (Log) GDP per Capita
- Table: IV Estimates of the Effect of Democracy on (Log) GDP per Capita  
- Figure: Dynamic Panel Model Estimates of the Effects of Democratization on the Log of GDP Per Capita

**Cluster Instructions:**
```stata
// Configure different time periods
START_YEAR = 1960 and END_YEAR = 2020
START_YEAR = 1980 and END_YEAR = 2020
START_YEAR = 1995 and END_YEAR = 2020
START_YEAR = 2001 and END_YEAR = 2020

// Run on Yale's Grace cluster or similar HPC environment
do Table2_final.do
do Table6_final.do
do Figure2_final.do
```

### Reproduction Instructions

**For analysis with your own data:**

1. **Data format requirements:**
   - Country-year panel data in Stata (.dta) format
   - Required variables: country identifiers, year, democracy measures, outcome variables
   - Place raw data in `Democracy_Main/MainAnalysis/input/` directory

2. **Modify analysis parameters:**
   - Update global variables in `run_all.do` (lines 52-65)
   - Adjust country sample and time periods as needed
   - Modify instrumental variables selection in global definitions

**Validation:**
- Compare generated `.tex` files with published results
- Visual inspection of generated figures against paper figures
- Check Stata log files for estimation warnings or errors
- All results should replicate the quantitative findings in the manuscript

## Technical Notes

**Important Stata Considerations:**
- The `rowmean()` function requires variables to be sequentially ordered in the dataset
- Random seeds are set for reproducible bootstrap procedures
- Maximum variables set to 10000 (`set maxvar 10000`)

**File Path Configuration:**
- All scripts use global path variables defined in `run_all.do`
- Automatic path configuration available via `set_paths.sh` script
- Manual path updates required for individual R scripts

## Citation

If you use this code or data, please cite:

Narita, Yusuke, and Ayumi Sudo. "Curse of Democracy: Evidence from a Pandemic." [Journal Information]

## Contact

For questions about this replication package, please contact the authors or submit an issue to this repository.

## License

[Add appropriate license information] 