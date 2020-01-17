#' Path To Clipboard
#'
#' RStudio Addin -- Copy Active Document's Path to Clipboard
#'
#' @export
pathToClip <- function() {

  path <- try(rstudioapi::getSourceEditorContext()$path, silent = TRUE)

  if (is.null(path)) {
    cat("No active document to get path from. Clipboard left unchanged.\n")
    return(invisible())
  }

  if (path == "") {
    cat("File must be saved first. Clipboard left unchanged.\n")
    return(invisible())
  }

  if (class(path) == "try-error") {
    cat("An unknown error occured. Clipboard not affected.")
    return(invisible())
  }

  path <- normalizePath(path)

  if (.Platform$OS.type == "windows") {
    utils::writeClipboard(charToRaw(paste0(path, ' ')))
  } else {
    rc <- try(clipr::write_clip(path), silent = TRUE)
    if (class(rc) == "try-error") {
      if (!"clipr" %in% rownames(utils::installed.packages())) {
        utils::install.packages("clipr")
        rc <- try(clipr::write_clip(path), silent = TRUE)

        if (class(rc) == "try-error")
          stop("An error has occured. Please make sure the 'clipr' package\n",
               "is installed correctly and that clipr::clipr_available()\n",
               "returns TRUE. If it doesn't look into the 'clipr' package's\n",
               "documentation to try to identify and solve the issue.")
      }
    }
  }

  cat("Copied to clipboard: ", path, "\n")
  return(invisible())
}
