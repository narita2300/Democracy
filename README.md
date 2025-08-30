# Democracy Project: Replication Package

This repository contains the complete replication package for the empirical analysis in **"Democracy and Growth in the 21st Century"** by Yusuke Narita. The project includes the final datasets, the code to assemble them, and the code to generate all empirical results.

This package contains the source code and datasets required to reproduce the analysis. A small, real-world dataset is used to demonstrate the software.

## Project Components

1.  **`Democracy_Main`**: Main analysis for the "Democracy and Growth in the 21st Century" paper.
2.  **`Dem_Growth_Extend`**: Extension of the "Democracy Does Cause Growth" dataset and results (Acemoglu, Naidu, Restrepo, Robinson 2019).

## 1. System Requirements

### All software dependencies and operating systems

**Required Software:**
- **Stata** 15.0 or higher
  - Required packages: `estout`, `kountry`, `_gwtmean`, `ivreg2`, `ranktest`, `labutil`
- **R** 4.0.0 or higher
  - Required packages: `ggplot2`, `viridis`, `hrbrthemes`, `tidyverse`, `haven`, `ggrepel`, `systemfonts`, `ggthemes`, `wid`, `readxl`, `readr`, `countrycode`, `collapse`, `stargazer`, `remotes`, `fontregisterer`
- **Python** 3.8 or higher
  - Required packages: `pandas`, `numpy`, `matplotlib`, `scipy`, `jupyter`

**Operating Systems:**
- **macOS** 10.15 or higher (primary development environment)
- **Windows** 10 or higher (compatible)
- **Linux** Ubuntu 18.04 or higher (compatible)

### Versions the software has been tested on
- macOS 14.5.0 (Darwin 24.5.0)
- Stata 17
- R 4.3.0
- Python 3.10.9

### Any required non-standard hardware
- **Minimum**: 8 GB RAM, 50 GB free disk space
- **Recommended**: 16 GB RAM, 100 GB free disk space
- **High-performance computing cluster**: Recommended for the `Dem_Growth_Extend` component (tested on Yale's Grace cluster).

## 2. Installation Guide

### Instructions

1.  **Clone or download the repository:**
    ```bash
    git clone [repository-url]
    cd Democracy
    ```

2.  **Install Stata packages:**
    Open Stata and run:
    ```stata
    ssc install estout, replace
    ssc install kountry, replace
    ssc install _gwtmean, replace
    ssc install ivreg2, replace
    ssc install ranktest, replace
    ssc install labutil, replace
    ```

3.  **Install R packages:**
    Open R and run:
    ```r
    install.packages(c("ggplot2", "viridis", "hrbrthemes", "tidyverse",
                       "haven", "ggrepel", "systemfonts", "ggthemes",
                       "wid", "readxl", "readr", "countrycode",
                       "collapse", "stargazer", "remotes"))
    remotes::install_github("Gedevan-Aleksizde/fontregisterer")
    ```

4.  **Install Python packages:**
    ```bash
    pip install pandas numpy matplotlib scipy jupyter
    ```

5.  **Configure paths:**
    Run the automated setup scripts to configure paths for Stata, R, and Python scripts. This avoids manual path editing.
    ```bash
    chmod +x set_paths.sh
    ./set_paths.sh
    ```
    For the `Dem_Growth_Extend` component, run its specific path setup script:
    ```bash
    chmod +x set_do_paths.sh
    ./set_do_paths.sh
    ```

6.  **Download input data (required):**
    - Download the `input` folder from the Dropbox link and place it in the repository at `Democracy_Main/MainAnalysis/input/`.
      - [Download input folder (Dropbox)](https://www.dropbox.com/scl/fo/vxrge7256gz7q0kb7vif1/AC0dpYPJazDieybg5APy-1Q?rlkey=l43wxqhynp60e0p8uv0n6tjx2&dl=0)

### Typical install time on a "normal" desktop computer
- Software installation: 15-30 minutes
- Data download and setup: 10-15 minutes
- **Total installation time: 25-45 minutes**

## Create Output Directories
Before running the analysis, you may need to create the following output directories:
```bash
mkdir -p Democracy_Main/MainAnalysis/output/data
mkdir -p Democracy_Main/MainAnalysis/output/tables
mkdir -p Democracy_Main/MainAnalysis/output/tables/appendix
mkdir -p Democracy_Main/MainAnalysis/output/tables/coefs
mkdir -p Democracy_Main/MainAnalysis/output/tables/extensions
mkdir -p Democracy_Main/MainAnalysis/output/tables/old
mkdir -p Democracy_Main/MainAnalysis/output/tables/old/coefs
```

These directories are required for the code to store generated datasets, tables, and coefficients.

## 3. Demo

### Instructions to run on data

1.  **Main Analysis (`Democracy_Main`):**
    To run the main analysis, execute the master Stata script. This will reproduce all main tables and figures.
    ```stata
    cd Democracy_Main/MainAnalysis/code
    do run_all.do
    ```
    The `set_paths.sh` script should have configured all necessary paths. R scripts are called from Stata where needed.

2.  **Extended Analysis (`Dem_Growth_Extend`):**
    This component contains analysis that should be run on a high-performance computing (HPC) cluster, such as Yale's Grace cluster.

    To reproduce the tables and figures from this section, run the following scripts with the specified year ranges:

    - **Table: Effect of Democracy on (Log) GDP per Capita**
      - Run `Table2_final.do` on the cluster with the following arguments:
        - `START_YEAR = 1960` and `END_YEAR = 2020`
        - `START_YEAR = 1980` and `END_YEAR = 2020`
        - `START_YEAR = 1995` and `END_YEAR = 2020`
        - `START_YEAR = 2001` and `END_YEAR = 2020`

    - **Table: IV Estimates of the Effect of Democracy on (Log) GDP per Capita**
      - Run `Table6_final.do` on the cluster with the same year arguments.

    - **Figure: Dynamic Panel Model Estimates**
      - Run `Figure2_final.do` on the cluster with the same year arguments.

### Expected output

The replication package generates three main categories of output, which are stored in the `Democracy_Main/MainAnalysis/output/` directory:

- **Main Paper Results**:
  - `Table 1`: 2SLS and GMM Estimates of Democracy's Effects (`table2_panelA.tex`, `table2_panelB.tex`, `table2_invalid_iv_panelC.tex`)
  - `Table 2`: Mechanisms Behind Democracy's Effect in 2001-2019 (`fitable3fA.tex`)
  - `Figure 1`: Correlation Between Democracy and Outcomes (`figure1a.png`, `figure1b.png`, `figure1c.png`)
  - `Figure 2`: Causal Effects of Democracy: First Look (`figure2a.png`, `figure2b.png`, etc.)

- **Appendix Results**: Comprehensive descriptive statistics, robustness checks, and additional plots.

- **Extended Analysis Results**: Tables and figures from the `Dem_Growth_Extend` analysis.

### Expected run time for demo on a "normal" desktop computer
- **Main analysis (`run_all.do`)**: 45-60 minutes
- **Extended analysis**: 30-45 minutes
- **Total demo run time: 75-105 minutes**

## 4. Instructions for Use

### How to run the software on your data

To run the analysis on your own data, follow these steps:

1.  **Data Formatting:**
    - Your data must be a country-year panel in Stata (`.dta`) format.
    - Required variables include country identifiers, year, democracy measures, and outcome variables.
    - Place your raw data in the `Democracy_Main/MainAnalysis/input/` directory.

2.  **Modify Analysis Parameters:**
    - Update global variables in `run_all.do` (e.g., sample, time periods).
    - Adjust instrumental variable selection in the global definitions if necessary.

### (OPTIONAL) Reproduction instructions

For a complete reproduction of all results, including appendix tables and figures, run the master script after completing the installation:

```stata
cd Democracy_Main/MainAnalysis/code
do run_all.do
```

## Mapping of Paper Tables/Figures to Code

| Paper element | Generating code (path) |
| --- | --- |
| Figure 1: Correlation Between Democracy and Growth | `Democracy_Main/MainAnalysis/code/2_analyze/figures/main/figure1.R` |
| Figure 2: Causal Effects of Democracy: First Look | `Democracy_Main/MainAnalysis/code/2_analyze/figures/main/figure2.R` |
| Table 1: 2SLS and GMM Estimates of Democracy’s Effects | `Democracy_Main/MainAnalysis/code/2_analyze/tables/main/table2.do`, `Democracy_Main/MainAnalysis/code/2_analyze/tables/main/table2_invalid_iv.R` |
| Table 2: Mechanisms Behind Democracy’s Effect in 2001-2019 | `Democracy_Main/MainAnalysis/code/2_analyze/tables/main/final_table_mech.do` |
| Table A2: Descriptive Statistics | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/table1.R` |
| Table A3: Additional Descriptive Statistics | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/02_descriptive_stats.R` |
| Table A4: Democracy Indices for 30 Countries with Largest Total GDP in 2019 | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/03_dem_ranking.do` |
| Table A5: Correlation Among Democracy Indices | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/05_corr_dem_indices.do` |
| Table A6: Correlation Between Democracy and Economic Growth With Control for Baseline GDP | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/06_ols_control_gdp.do` |
| Table A7: First-stage Regression Estimates of IVs’ Effects on Democracy | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/15_first_stage.do` |
| Table A8: First-stage Monotonicity Check: By Continent | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/08_monotonicity_check.do` |
| Table A9: Correlation Among IVs | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/09_ivs_corr.do` |
| Figure A1 ((a)-(f)): Reduced Forms for Causal Effects of Democracy | `Democracy_Main/MainAnalysis/code/2_analyze/figures/appendix/rf_figure.R` |
| Table A11: Additional Mechanisms in 2001-2019 | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/mechanism_appendix.do` |
| Figure A2 ((a)-(i)): Correlation Between Democracy and Additional Outcomes | `Democracy_Main/MainAnalysis/code/2_analyze/figures/appendix/figure_happiness.R`, `figure_top_income.R`, `figure_co2_emissions.R`, `figure_energy.R`, `figure_deaths.R` |
| Table A12: 2SLS Regression Estimates of Democracy’s Effects on Additional Outcomes | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/additional_outcomes.do` |
| Table A13: 2SLS Regression Estimates of Democracy’s Effects on GDP per Capita Growth | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/19_table2_pc.do` |
| Table A14: 2SLS Regression with Alternative Democracy Indices | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/24_2sls_indices.do` |
| Table A15: 2SLS Regression Estimates Before, During, and After the Great Recession | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/20_2sls_recession.do` |
| Table A16: 2SLS Regression Excluding the US and China | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/27_2sls_exclude_US_China.do` |
| Table A17: 2SLS Regression Excluding Outliers | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/28_2sls_outliers.do` |
| Table A18: 2SLS Regression Excluding G7 Countries | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/29_2sls_remove_g7.do` |
| Table A19: 2SLS Regression with Alternative Weightings | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/25_2sls_weighting.do` |
| Table A20: Democracy’s Effect on Economic Growth With Control for Baseline GDP | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/21_2sls_control_gdp.do` |
| Table A21: 2SLS Regression with Continent Controls | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/23_2sls_control_continent.do` |
| Figure A3 ((a)-(d)): Correlation Between Democracy and Economic Growth by Decade | `Democracy_Main/MainAnalysis/code/2_analyze/figures/appendix/01_corr_auto_notitle.R` |
| Table A22: Democracy’s Effect on Economic Growth by Decade | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/30_2sls_by_decade.do` |
| Figure A4 ((a)-(f)): Correlation Between Democracy Quadratic and Economic Growth by Decade | `Democracy_Main/MainAnalysis/code/2_analyze/figures/appendix/01_corr_auto_notitle_quad.R` |
| Figure A6 ((a)-(c)): Correlation Between Democracy Change and Outcomes | `Democracy_Main/MainAnalysis/code/2_analyze/figures/appendix/figure1_change.R` |
| Table A23: 2SLS Regression Estimates of Democracy Change’s Effects | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/table2_change.do` |
| Table A24: Effect of Democratization on (Log) GDP per Capita | `Dem_Growth_Extend/replication_files_ddcg/do_files/Table2_final.do` |
| Table A25: IV Estimates of the Effect of Democratization on (Log) GDP per Capita | `Dem_Growth_Extend/replication_files_ddcg/do_files/Table6_final.do` |
| Figure A7: Dynamic Panel Model Estimates of the Effects of Democratization on Log GDP Per Capita | `Dem_Growth_Extend/replication_files_ddcg/do_files/Figure2_final.do` |
| Table A26: Potential Policy Mechanisms Behind Democracy’s Effect in 2020-22 | `Democracy_Main/MainAnalysis/code/2_analyze/tables/appendix/32_2sls_policy_mechanisms.do` |

## Contact

For questions about this replication package, please contact the authors or submit an issue to this repository.
