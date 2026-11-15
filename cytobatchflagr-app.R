# ==== RUN CytoBatchFlagR aka CBFR ====

# ==== STEP A: install cytoBatchFlagR script

# Select the dir in which CBFR is copied and executed
(packagePath <- tcltk::tk_choose.dir(default = getwd(), caption = "CBFR folder"))

# Show the current dir where CBFR will be copied
setwd(packagePath)
getwd()

# Install R files from CBFR
# This copies the functions of CBFR in the current dir. This does not install
# packages required by CBFR.
cbfr_url <- "https://raw.githubusercontent.com/AndorfLab/CytoBatchFlagR/refs/heads/main/R/"
for (file in c(
  "CytoBatchFlagR_functions.R",
  "auto_threshold_func.R",
  "generate_marker_expression_densities.R",
  "package_installer.R",
  "editMarkerTable.R",
  "referenceMarkerSelection.R",
  "selectMarkerList.R",
  "CytoBatchFlagR_workflow.R",
  "cytoBatchFlagR_example.Rmd")
) {
  download.file(paste0(cbfr_url, file), file, mode = "wb", cacheOK = FALSE)
}

# Download files from Maelle
mm_url <- "https://raw.githubusercontent.com/cipheLab/CBFR_RMD/refs/heads/main/"
for (file in c("cytoBatchFlagR.Rmd", "cytoBatchFlagR_auto.Rmd")) {
  download.file(paste0(mm_url, file), file, mode = "wb", cacheOK = FALSE)
}

# ==== STEP B: SPECIFY FCS DIR AND RUN

# Select the FCS dir
(workDir <- tcltk::tk_choose.dir(default = getwd(), caption = "FCS folder"))

# Open cytoBatchFlagR.Rmd or cytoBatchFlagR_example.Rmd and execute it step by step


# ==== TRAINING SESSION: Eswar26 example

# Download prepared files and copy them to the FCS folder
for (file in c("fcs_file_info.csv","panel_markers.csv","panel_markers.xlsx")) {
  download.file(paste0(mm_url, file), file.path(workDir, file), mode = "wb", cacheOK = FALSE)
}

# Open cytoBatchFlagR.Rmd and execute it step by step

# Alt. run in auto mode
rmarkdown::render("cytoBatchFlagR_auto.Rmd", params = list(
  packagePath           = packagePath,
  workDir               = workDir,
  transformation        = "arcsinh",
  transform_cofactor    = 3000,
  umap_max_cell         = 50000,
  fsom_meta_k           = 15
))


# ==== ORIGIN ====

# https://github.com/cipheLab/CBFR_RMD

# Original Rmd file
# https://raw.githubusercontent.com/AndorfLab/CytoBatchFlagR/refs/heads/main/R/cytoBatchFlagR_example.Rmd


# ==== INSTALL ====

### Installing and Loading Dependencies ###

# Before running, all required R packages must be installed

# Load this function to check for missing packages and install them
source("package_installer.R")

# Packages needed
requiredPackages <- c("dplyr","scales","tidyr","reshape2","readr",
                      "matrixStats","readxl","ggplot2","ggpubr",
                      "ggridges","MASS","RColorBrewer","cowplot",
                      "ggrepel","emdist","circlize","gridExtra","stats",
                      "LaplacesDemon","pheatmap","umap","progress","crayon",
                      "patchwork","ggpmisc","viridis","tidyverse","shiny",
                      "shinyjs","DT","bslib","shinyjs","cluster","rstudioapi",
                      "grid","shinycssloaders","shinyWidgets")
# Install
package_installer(requiredPackages)

# Check if the packages can be loaded
lapply(requiredPackages, require, character.only = TRUE)
