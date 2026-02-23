{ ... }:

let
  user = "zkli";
in
{
  imports = [
    ../home/term/nushell
  ];

  home.username = user;
  home.homeDirectory = "/Users/${user}";
  home.stateVersion = "25.11";

  home.sessionPath = [
    "/run/current-system/sw/bin"
  ];

  home.sessionVariables = {
    FLAKE_PATH = "/Users/${user}/nixos-config";
  };

  programs.home-manager.enable = true;
}
