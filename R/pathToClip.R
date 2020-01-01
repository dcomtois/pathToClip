#' Path To Clipboard
#'
#' RStudio Addin -- Copy Active Document's Path to Clipboard
#'
#' @export
pathToClip <- function() {

  path <- rstudioapi::getSourceEditorContext()$path

  if (path == "") {
    cat("File must be saved first. Clipboard left unchanged.\n")
    return(invisible())
  }

  path <- normalizePath(path)
  utils::writeClipboard(charToRaw(paste0(path, ' ')))
  cat("Copied to clipboard: ", path, "\n")
  return(invisible())
}
