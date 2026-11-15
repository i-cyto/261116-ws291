# ==== RUN ====

shiny::runApp("cytonorm-app")


# ==== ORIGIN ====

# https://github.com/cipheLab/cytonorm-App


# ==== INSTALL ====

pkgs <- c(
    "shiny", "shinydashboard", "shinycssloaders", "DT", "openxlsx", "rhandsontable", "shinyjs"
  )

verifs <- sapply(pkgs, requireNamespace, quietly = TRUE)
for (pkg in names(verifs)[!verifs])
  install.packages(pkg)

remotes::install_github("cipheLab/FlowCIPHE")
