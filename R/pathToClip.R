#' Path To Clipboard
#'
#' RStudio Addin -- Copy Active Document's Path to Clipboard
#'
#' Uses the system default separator (\sQuote{\\} on Windows,
#' \sQuote{/} on others).
#'
#' Use \dQuote{Path To Clipboard (\\\\)} to have the double-backslash,
#' Windows-style path.
#'
#' @param dbs Logical. Used for producing Windows
#' double-backslashed paths.
#'
#' @export
pathToClip <- function(dbs=FALSE) {

  path <- try(rstudioapi::getSourceEditorContext()$path, silent = TRUE)
  if (class(path) == "try-error") {
    if (!"rstudioapi" %in% rownames(utils::installed.packages())) {
      inst_rstudioapi <- utils::askYesNo(msg = "It appears rstudioapi is not installed. Install now?",
                                         prompts = c(" [Yes] ", " No ", " Cancel "))
      if (!isTRUE(inst_rstudioapi))
        stop("Aborting")
      utils::install.packages("rstudioapi")
      path <- rstudioapi::getSourceEditorContext()$path
    }
  }

  if (path == "") {
    cat("File must be saved first. Clipboard left unchanged.\n")
    return(invisible())
  }

  path <- normalizePath(path)

  if (.Platform$OS.type == "windows") {
    if (isTRUE(dbs)) {
      path <- gsub("\\", "\\\\", path, fixed = TRUE)
    }
    utils::writeClipboard(charToRaw(paste0(path, ' ')))
  } else {
    if (isTRUE(dbs)) {
      path <- gsub("/", "\\\\", path, fixed = TRUE)
    }

    rc <- try(clipr::write_clip(path), silent = TRUE)
    if (class(rc) == "try-error") {
      if (!"clipr" %in% rownames(utils::installed.packages())) {
        inst_clipr <- utils::askYesNo(msg = "It appears clipr is not installed. Install now?",
                                      prompts = c(" [Yes] ", " No ", " Cancel "))
        if (!isTRUE(inst_clipr))
          stop("Aborting")

        utils::install.packages("clipr")
        rc <- try(clipr::write_clip(path), silent = TRUE)

        if (class(rc) == "try-error")
          stop("An error has occured. Do you have xclip / xsel installed? Aborting.")
      }
    }
  }

  cat("Copied to clipboard: ", path, "\n")
  return(invisible())
}

#' Path To Clipboard (\\\\)
#'
#' RStudio Addin -- Copy Active Document's Path to Clipboard
#'
#' Produces double-backslash, Windows-style paths.
#' @export
pathToClip_dbs <- function() {
  pathToClip(dbs=TRUE)
}
