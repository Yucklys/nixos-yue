{ pkgs, ... }:

let
  user = "zkli";
in
{
  imports = [
    ../home/term
    ../home/editor
  ];

  home.username = user;
  home.homeDirectory = "/Users/${user}";
  home.stateVersion = "25.11";

  home.sessionPath = [
    "/run/current-system/sw/bin"
    "/nix/var/nix/profiles/default/bin"
    "/etc/profiles/per-user/${user}/bin"
  ];

  home.sessionVariables = {
    FLAKE_PATH = "/Users/${user}/nixos-config";
  };

  programs.home-manager.enable = true;
}
