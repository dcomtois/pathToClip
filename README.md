### This "Path To Clipboard" addin for RStudio does **one simple thing**...

## It stores the active document's path into the clipboard.

That's it! Most editors have this feature built-in, but for some reason, RStudio doesn't.

**On OS X and Linux**, it uses the [clipr](https://CRAN.R-project.org/package=clipr) package, which in turn relies on either "xclip" or "xsel", small utilities that can be installed in just a few seconds. See [here](https://linoxide.com/linux-how-to/copy-paste-commands-output-xclip-linux/), for distro-specific instructions.

**On Windows, no additional software is required.**

### Installation

It can be installed via ['addinslist'](https://github.com/daattali/addinslist), or using 'devtools' or 'remotes':

```r
remotes::install_github("dcomtois/pathToClip")
```

### Shortcut suggestion

As with any other addin, you can assign a keyboard shortcut to it. 

I like to use `< Ctrl + Alt + C >`, since it's easy to remember and it's not pre-assigned (see animated demo if needed).

### Simplified version

If you don't like having 3 entries in your Addins menu and need only the platform-specific path separator, install version 0.1.0:

```r
remotes::install_github("dcomtois/pathToClip", ref="0-1-0")
```

### Demo

![Gif Demo](inst/media/pathToClip_demo.gif)
