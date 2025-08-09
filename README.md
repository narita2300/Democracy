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

## Contact

For questions about this replication package, please contact the authors or submit an issue to this repository.