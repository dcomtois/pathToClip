# pathToClip

This "Path To Clipboard" addin for RStudio does one simple thing: take the active document's full path, store it in the clipboard. That's it! 

Most editors have this feature built-in, but for some reason, RStudio doesn't.

On OS X and Unix-like systems, the addin uses the [clipr](https://CRAN.R-project.org/package=clipr) package, which in turn relies on either "xclip" or "xsel", small utilities that can be installed in just a few seconds. See [here](https://linoxide.com/linux-how-to/copy-paste-commands-output-xclip-linux/), for distro-specific instructions.

On Windows, no additional software is required.

As with any other addin, you can assign a keyboard shortcut to it. I like to use Ctrl + Alt + C, since it's easy to remember and it's not used by default.

It should be included in the addinslist package in no time.

![Gif Demo](https://raw.githubusercontent.com/dcomtois/pathToClip/ca9f97aa6d7ed65ee51e70ba5246e72cf904df6f/inst/media/pathToClip_demo.gif)
