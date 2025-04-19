{ ... }:

{
  # Fixes for applications that don't work with the default settings
  # RStudio QT doesn't work on wayland
  xdg.desktopEntries.rstudio = {
    categories = [ "Development" ];
    comment = "Set of integrated tools for the R language";
    exec = "QT_QPA_PLATFORM=xcb rstudio %F";
    genericName = "IDE";
    icon = "rstudio";
    mimeType = [
      "text/x-r-source"
      "text/x-r"
      "text/x-R"
      "text/x-r-doc"
      "text/x-r-sweave"
      "text/x-r-markdown"
      "text/x-r-html"
      "text/x-r-presentation"
      "application/x-r-data"
      "application/x-r-project"
      "text/x-r-history"
      "text/x-r-profile"
      "text/x-tex"
      "text/x-markdown"
      "text/html"
      "text/css"
      "text/javascript"
      "text/x-chdr"
      "text/x-csrc"
      "text/x-c++hdr"
      "text/x-c++src"
    ];
    name = "RStudio";
    type = "Application";
    settings = {
      Version = "1.4";
    };
  };
}
