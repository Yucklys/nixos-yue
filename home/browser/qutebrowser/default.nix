{ config, pkgs, ... }:

{
  programs.qutebrowser = {
    enable = true;
    package = pkgs.qutebrowser;
    # extraConfig = builtins.readFile ./config.py;
    loadAutoconfig = true;
    keyBindings = {
      normal = {
        "v" = "cmd-set-text /";
        "/" = "mode-enter caret";
      };
    };
  };

  # set as default browser
  # xdg.mimeApps.defaultApplications = {
  #   "text/html" = "org.qutebrowser.qutebrowser.desktop";
  #   "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
  #   "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
  #   "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
  #   "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
  # };

  # do not use stylix theme
  stylix.targets.qutebrowser.enable = true;
}
