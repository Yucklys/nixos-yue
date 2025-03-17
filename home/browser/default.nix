{ config, pkgs, inputs, ... }:

{
  imports = [
    ./qutebrowser
  ];

  home.packages = with pkgs; [
    # nyxt
    # vivaldi
    inputs.zen-browser.packages."${system}".default
  ];

  # xdg.mimeApps = {
  #   enable = true;
  #   defaultApplications = {
  #     "text/html" = "vivaldi-stable.desktop";
  #     "x-scheme-handler/http" = "vivaldi-stable.desktop";
  #     "x-scheme-handler/https" = "vivaldi-stable.desktop";
  #     "x-scheme-handler/about" = "vivaldi-stable.desktop";
  #     "x-scheme-handler/unknown" = "vivaldi-stable.desktop";      
  #   };
  # };
}
