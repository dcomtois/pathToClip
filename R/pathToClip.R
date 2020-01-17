#' Path To Clipboard
#'
#' RStudio Addin -- Copy Active Document's Path to Clipboard
#'
#' @param sep Path separator; one of \sQuote{/}, \sQuote{\\} or \sQuote{\\\\}
#'
#' @export
pathToClip <- function(sep) {

  path <- try(rstudioapi::getSourceEditorContext()$path, silent = TRUE)

  if (class(path) == "try-error") {
    cat("An error has occurred. Clipboard left unchanged.\n")
    return(invisible())
  }

  if (is.null(path)) {
    cat("No active document to get path from. Clipboard left unchanged.\n")
    return(invisible())
  }

  if (path == "") {
    cat("File must be saved first. Clipboard left unchanged.\n")
    return(invisible())
  }

  path <- normalizePath(path)

  if (.Platform$OS.type == "windows") {
    if (sep == "/") {
      path <- gsub("\\", "/", path, fixed = TRUE)
    } else if (sep == "\\\\") {
      path <- gsub("\\", "\\\\", path, fixed = TRUE)
    }
    utils::writeClipboard(charToRaw(paste0(path, ' ')))
  } else {
    if (sep == "\\") {
      path <- gsub("/", "\\", path, fixed = TRUE)
    } else if (sep == "\\\\") {
      path <- gsub("/", "\\\\", path, fixed = TRUE)
    }

    if (!"clipr" %in% rownames(utils::installed.packages())) {
      message("installing require package 'clipr'")
      utils::install.packages("clipr")
    }

    rc <- try(clipr::write_clip(path), silent = TRUE)
    if (class(rc) == "try-error") {
      stop("An error has occured. Please make sure the 'clipr' package is correctly installed")
    }
  }

  cat("Copied to clipboard: ", path, "\n")
  return(invisible())
}

#' Path To Clipboard (/)
#'
#' RStudio Addin -- Copy Active Document's Path to Clipboard
#'
#' Uses forward slash as path separator.
#' @export
pathToClip_fwd <- function() {
  pathToClip(sep="/")
}

#' Path To Clipboard (\\)
#'
#' RStudio Addin -- Copy Active Document's Path to Clipboard
#'
#' Uses backslash as path separator.
#' @export
pathToClip_back <- function() {
  pathToClip(sep="\\")
}

#' Path To Clipboard (\\\\)
#'
#' RStudio Addin -- Copy Active Document's Path to Clipboard
#'
#' Uses double backslash as path separator.
#' @export
pathToClip_dbl_back <- function() {
  pathToClip(sep="\\\\")
}
