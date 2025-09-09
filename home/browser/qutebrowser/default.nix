{ config, pkgs, ... }:

{
  programs.qutebrowser = {
    enable = true;
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
    searchEngines = {
      DEFAULT = "https://www.google.com/search?q={}";
      d = "https://duckduckgo.com/?q={}";
      gh = "https://github.com/search?q={}";
    };
  };

  stylix.targets.qutebrowser.enable = true;
}
