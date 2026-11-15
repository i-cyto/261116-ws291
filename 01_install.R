# ==== helpers ====

get_app <- function(
    repo,
    local_dir,
    scripts = c("server.R", "ui.R"),
    root_url = "https://raw.githubusercontent.com/%s/refs/heads/main/%s"
) {
  if (!dir.exists(local_dir)) dir.create(local_dir)
  for (script in scripts) {
    script_url <- sprintf(root_url, repo, script)
    script_dest <- file.path(local_dir, script)
    if (file.exists(script_dest))
      file.rename(
        script_dest,
        paste0(script_dest, format(Sys.time(), ".%Y%m%d%H%M")))
    download.file(script_url, destfile = script_dest)
  }
}


# ==== CYTONORM-APP ====

get_app("cipheLab/cytonorm-App", "cytonorm-app")


# ==== CYCOMBINE-APP ====

get_app("cipheLab/cyCombine", "cyCombine-app")


# ==== FCS-MERGE ====

get_app("cipheLab/FCS-Merge", "fcsmerge-app")
# get_app("samgg/FCS-Merge", "fcsmerge-app")

