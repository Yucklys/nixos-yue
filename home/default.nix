{ config, pkgs, pkgs-unstable, inputs, lib, ... }:

let
  user = "yucklys";
in
{
  imports = [
    ../packages/home.nix
    ./term
    ./editor
    ./bar
    ./wm
    ./browser
    ./fcitx5
    ./base
    ./wlogout.nix
    ./music.nix
    ./email.nix
    ./dropbox.nix
    ./fix.nix
  ];

  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  home.stateVersion = "23.05";

  home.sessionVariables = {
    FLAKE = "/home/${user}/niri-config";
  };

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  services.gnome-keyring = {
    enable = true;
    components = ["secrets"];
  };

  services.blueman-applet.enable = true;

  programs.rbw = {
    enable = true;
    package = pkgs-unstable.rbw;
    settings.email = "yucklys687@outlook.com";
    settings.pinentry = pkgs.pinentry-gnome3;
  };

  programs.texlive.enable = true;

  # pdf viewer
  programs.zathura.enable = true;

  # git setting
  programs.git = {
    enable = true;
    userName = "yucklys";
    userEmail = "yucklys687@outlook.com";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };

  # password store
  programs.password-store.enable = true;
}
