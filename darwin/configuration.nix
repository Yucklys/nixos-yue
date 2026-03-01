{ pkgs, ... }:

{
  imports = [
    ../dev/nix.nix
  ];

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
    interval = {
      Weekday = 0;
      Hour = 3;
      Minute = 45;
    };
    options = "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # System packages
  environment.systemPackages = with pkgs; [
    nushell
    nh

    nodePackages.typescript-language-server
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

  # User
  system.primaryUser = "zkli";
  users.users.zkli.home = "/Users/zkli";

  # Enable Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # Default shell
  environment.shells = [ pkgs.nushell ];

  # Homebrew (manages existing homebrew installation declaratively)
  homebrew = {
    enable = true;
    taps = [
      "d12frosted/emacs-plus"
    ];
    brews = [
      "emacs-plus"
    ];
    casks = [
      "nikitabobko/tap/aerospace"
    ];
    caskArgs.appdir = "/Applications";
    caskArgs.no_quarantine = true;
    onActivation.cleanup = "none";
  };

  # Used for backwards compatibility
  system.stateVersion = 6;

  stylix = {
    enable = true;
    image = ../wallpapers/ign_legendary.png;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    base16Scheme = ../themes/ef-winter-base16.yaml;
    polarity = "dark";
    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      monospace = {
        package = pkgs.maple-mono.NF-CN;
        name = "Maple Mono NF CN";
      };
    };
  };
}
