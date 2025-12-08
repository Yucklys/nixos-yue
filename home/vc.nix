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
    settings = {
      user = {
        name = name;
        email = email;
      };
      merge.conflictStyle = "zdiff3";
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    enableJujutsuIntegration = true;
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        email = email;
        name = name;
      };
    };
  };
}
