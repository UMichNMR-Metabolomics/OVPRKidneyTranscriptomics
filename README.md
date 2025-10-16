This is repository hosting the input files for a data plotting tool for the OVPR Sepsis Pig project. The code for the Shiny app itself, as well as all the dependent data files are hosted in this github repository.

# Setup and Installation

To run the app, download the app.R file and open it in RStudio. If all the required packages are installed, it can be run right away either by running the command 
```
runApp("app.R")
```
or by clicking on the "Run App" button at the top right of the script panel.

At the moment, in order to use the OVPR pig kidney transcriptomics data plotting tool you must have R Studio installed, as well as the following packages:

- shiny
- bslib
- DT
- ggplot2
- ggpubr
- ggsignif
- DESeq2

----------------------------------------------------------------------------------------

DESeq2 can be installed from Bioconductor by running the following code:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("DESeq2")
```

----------------------------------------------------------------------------------------

All other packages can be installed from CRAN by running the following code:

```
install.packages("shiny")
install.packages("bslib")
install.packages('DT')
install.packages('ggplot2')
install.packages("ggpubr")
install.packages("ggsignif")
```
----------------------------------------------------------------------------------------

# App Overview

The panel on the left contains a table of ALL genes present in the sequencing report delivered by the Advanced Genomics Core. It cross references Ensembl IDs with gene names and descriptions, and is searchable.

The panel on the right contains an text box to enter the Ensembl ID of the gene you want to produce a plot for, and the plot itself. When the app first opens, there will be an error message instead of a plot, this is expected behavior.

To generate a plot, use the table to look up the Ensembl ID of the gene you want to plot, and then either type or copy and paste the Ensembl ID into the text box above the plot.
