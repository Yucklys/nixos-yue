{ ... }:

let
  user = "zkli";
in
{
  home.username = user;
  home.homeDirectory = "/Users/${user}";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
