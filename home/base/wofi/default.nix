{ ... }:

{
  programs.wofi = {
    enable = true;
    # style = builtins.readFile ./style.css;
    settings = {
      insensitive = true;
      matching = "contains";
    };
  };

  stylix.targets.wofi.enable = true;
}
