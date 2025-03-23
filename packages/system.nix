{ config, lib, pkgs, pkgs-unstable, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # essentials
    helix # terminal modal editor
    wget
    ripgrep
    coreutils
    keyutils
    xdg-utils
    git

    # tools
    fd # find replacement
    tealdeer # tldr client
    just # an universal makefile
    nh # yet another nix helper
    wtype # xdotool type for wayland
    dtrx # extract all kinds of archives
    unzip # unzip
    cachix # nix binary cache manager
    wev # xev for wayland, check key code
    brightnessctl # control screen brightness
    pandoc # document converter
    appimage-run # run appimage in nix
    fzf # fuzzy finder
    pkgs-unstable.nix-search-tv # search nixpkgs

    # libraries
    librime # library for rime input method
    libnotify # notification library
    libtool # library for building shared libraries

    # hardware support by https://github.com/NixOS/nixos-hardware
    pkgs.lenovo-legion # for legion laptop
  ];
}
