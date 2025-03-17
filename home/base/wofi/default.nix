{ pkgs, ... }:

{  
  programs.wofi = {
    enable = true;
    # style = builtins.readFile ./style.css;
    settings = {
      insensitive = true;
      matching = "fuzzy";
    };
  };

  stylix.targets.wofi.enable = true;
}
