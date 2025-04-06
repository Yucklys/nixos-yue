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
        "h" = "scroll left";
        "s" = "scroll right";
        "t" = "scroll up";
        "n" = "scroll down";
        "H" = "back";
        "S" = "forward";
        "T" = "tab-prev";
        "N" = "tab-next";
        "p" = "search-next";
        "P" = "search-prev";
      };
    };
  };

  # do not use stylix theme
  stylix.targets.qutebrowser.enable = true;
}
