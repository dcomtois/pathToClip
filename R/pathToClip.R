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


  # Unix-Like systems
  } else {
    if (sep == "\\") {
      path <- gsub("/", "\\", path, fixed = TRUE)
    } else if (sep == "\\\\") {
      path <- gsub("/", "\\\\", path, fixed = TRUE)
    }

    rc <- try(clipr::write_clip(path), silent = TRUE)

    if (class(rc) == "try-error") {
      if (!"clipr" %in% rownames(utils::installed.packages())) {
        message("package 'clipr' needs to be installed; ",
                "checking system requirements...")

        if (isTRUE(Sys.info()['sysname'] == "Darwin")) {
          if (system("which pbcopy", ignore.stdout = TRUE) == 0L) {
            message("OK... 'pbcopy' is installed")
            utils::install.packages("clipr")
          } else {
            message("In order for the 'clipr' package to work properly, the 'pbcopy' command-line\n",
                    "utility must first be installed. Please refer to the 'clipr' package's\n",
                    "documentation to find out how to resolve this issue; one resolved, try\n",
                    "using the 'pathToClip' addin again")
            stop()
          }
        } else { # Sys.info()['sysname'] == "Linux" or other
          if (system("which xclip", ignore.stdout = TRUE) == 0L) {
            message("OK... 'xclip' is installed")
            utils::install.packages("clipr")
          } else if (system("which xsel" , ignore.stdout = TRUE) == 0L) {
            message("OK... 'xsel' is installed")
            utils::install.packages("clipr")
          } else {
            message("Problem encountered: neither the 'xclip' nor\n",
                    "the 'xsel' are installed on your system. Please\n",
                    "try installing the 'xclip' command-line tool as per\n",
                    "the instructions found on the following site:\n",
                    "https://linoxide.com/linux-how-to/copy-paste-commands-output-xclip-linux\n",
                    "and try using the 'pathToClip' addin again")
            stop()
          }
        }
      }
      message("Unknown error encountered. Please check the results of the\n",
              "clipr::clipr_available() function; if it is FALSE, then refer\n",
              "to the 'clipr' package's documentation to try and identify the\n",
              "cause and solution to the problem. If the result is TRUE, then\n",
              "please take a moment to open an issue on the 'pathToClip' package's\n",
              "development page on GitHub: https://github.com/dcomtois/pathToClip/issues\n",
              "including the results of sessionInfo()")
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
