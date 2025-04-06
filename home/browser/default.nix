{ config, pkgs, inputs, ... }:

{
  imports = [
    ./qutebrowser
  ];

  home.packages = with pkgs; [
    # nyxt
    # vivaldi
    # inputs.zen-browser.packages."${system}".default
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "qutebrowser.desktop";
      "x-scheme-handler/http" = "qutebrowser.desktop";
      "x-scheme-handler/https" = "qutebrowser.desktop";
      "x-scheme-handler/about" = "qutebrowser.desktop";
      "x-scheme-handler/unknown" = "qutebrowser.desktop";      
    };
  };
}
