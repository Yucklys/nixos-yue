{
  config,
  pkgs,
  inputs,
  ...
}:

let
  defaultBrowser = "qutebrowser.desktop";
in
{
  imports = [
    ./qutebrowser
  ];

  home.packages = with pkgs; [
    # nyxt
    # vivaldi
    google-chrome
    inputs.zen-browser.packages."${system}".default
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = defaultBrowser;
      "x-scheme-handler/http" = defaultBrowser;
      "x-scheme-handler/https" = defaultBrowser;
      "x-scheme-handler/about" = defaultBrowser;
      "x-scheme-handler/unknown" = defaultBrowser;
    };
  };
}
