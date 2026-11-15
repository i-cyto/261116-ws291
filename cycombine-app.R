# ==== RUN ====

shiny::runApp("cyCombine-app")


# ==== ORIGIN ====

# https://github.com/cipheLab/cyCombine


# ==== INSTALL ====

pkgs <- c(
  "shiny", "shinydashboard", "shinycssloaders", "DT", "openxlsx", "rhandsontable", "shinyjs"
)

verifs <- sapply(pkgs, requireNamespace, quietly = TRUE)
for (pkg in names(verifs)[!verifs])
  install.packages(pkg)

remotes::install_github("cipheLab/FlowCIPHE")
