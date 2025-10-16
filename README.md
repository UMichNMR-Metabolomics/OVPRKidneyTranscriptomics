This is repository hosting the input files for a data plotting tool for the OVPR Sepsis Pig project. The code for the Shiny app itself, as well as all the dependent data files are hosted in this github repository.

At the moment, in order to use the OVPR pig kidney transcriptomics data plotting tool you must have R Studio installed, as well as the following packages:

shiny
bslib
DT
ggplot2
ggpubr
ggsignif
DESeq2

----------------------------------------------------------------------------------------

DESeq2 can be installed from Bioconductor by running the following code:

if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("DESeq2")

----------------------------------------------------------------------------------------

All other packages can be installed from CRAN by running the following code:

install.packages("shiny")
install.packages("bslib")
install.packages('DT')
install.packages('ggplot2')
install.packages("ggpubr")
install.packages("ggsignif")

----------------------------------------------------------------------------------------

Once RStudio and all packages have been installed, open the app.R script and launch the app by pressing the "Run App" button in RStudio.
