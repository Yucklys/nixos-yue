{ pkgs, ... }:

{
  # Nix settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.trusted-users = [
    "root"
    "zkli"
  ];
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    interval = { Weekday = 0; Hour = 3; Minute = 45; };
    options = "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # System packages
  environment.systemPackages = with pkgs; [
  ];

  # Fonts
  fonts.packages = with pkgs; [
  ];

  # macOS system defaults
  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;
      show-recents = false;
    };
    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "clmv";
    };
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
    };
  };

  # Enable Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # Default shell
  environment.shells = [ pkgs.nushell ];

  # Used for backwards compatibility
  system.stateVersion = 6;
}
