# ==== RUN ====

# the app will present FCS files of your computer
Sys.setenv(FCS_MERGE_MODE = "local")
# the app will show files from this location
Sys.setenv(DATA_ROOT = "C:/ws291")

# run the app
shiny::runApp("fcsmerge-app")


# ==== ORIGIN ====

# https://github.com/cipheLab/FCS-Merge/


# ==== INSTALL ====

pkgs <- c(
  "shiny", "shinyFiles", "DT", "rmarkdown", "knitr", "ggplot2", "dplyr",
  "tidyr", "shinyjs", "shinydashboard", "shinythemes",
  "stringdist", "base64enc", "remotes"
)

verifs <- sapply(pkgs, requireNamespace, quietly = TRUE)
for (pkg in names(verifs)[!verifs])
  install.packages(pkg)

remotes::install_github("cipheLab/FlowCIPHE")
