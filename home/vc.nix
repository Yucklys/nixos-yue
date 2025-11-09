{ pkgs-unstable, ... }:

let
  email = "yucklys687@outlook.com";
  name = "Yucklys";
in
{
  home.packages = with pkgs-unstable; [
    jjui
  ];
  
  programs.git = {
    enable = true;
    userName = name;
    userEmail = email;
    delta.enable = true;
    extraConfig = {
      merge.conflictStyle = "zdiff3";
      delta.navigate = true;
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        email = email;
        name = name;
      };
      ui = {
        pager = "delta";
        diff-formatter = ":git";
        conflict-marker-style = "git";
      };
    };
  };
}
