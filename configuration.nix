# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./system-options.nix
      ./hardware-configuration.nix
      ./nvidia.nix
      ./video.nix
      # ./game.nix
      ./vm.nix
      ./ollama.nix
      ./packages
      ./dev
    ];
  
  # Enable Flake for Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Auto hardlink, reduce disk usage but increase build time
  nix.settings.auto-optimise-store = false;
  # Add user to trusted users
  nix.settings.trusted-users = [ "root" "@wheel" ];

  # Protect nix-shell against garbage collection
  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
    # Hyprland Cachix
    substituters = [
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Optimizing storage
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  
  # Allow some packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (import inputs.emacs-overlay)
    inputs.niri.overlays.niri
  ];
  

  # use the latest kernel
  boot.kernelPackages = pkgs.linuxPackages;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Register AppImage as regular binary
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

  # Enable xdg-desktop-portal for wayland
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "US/Eastern";
  time.hardwareClockInLocalTime = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
    # keyMap = "dvorak";
    packages = with pkgs; [ terminus_font ];
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Hyprland system wide settings
  programs.hyprland = {
    enable = false;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  # KDEConnect
  programs.kdeconnect.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    fira-code
    wqy_microhei
    wqy_zenhei
    nerdfonts
    maple-mono-SC-NF
    font-awesome
    symbola
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    hanazono
    lxgw-wenkai
    nanum
  ];

  # Enable PAM for swaylock
  security.pam.services.swaylock = {};

  # Authentication agent
  security.polkit.enable = true;
  # systemd = {
  #   user.services.polkit-gnome-authentication-agent-1 = {
  #     description = "polkit-gnome-authentication-agent-1";
  #     wantedBy = [ "graphical-session.target" ];
  #     wants = [ "graphical-session.target" ];
  #     after = [ "graphical-session.target" ];
  #     serviceConfig = {
  #       Type = "simple";
  #       ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #       Restart = "on-failure";
  #       RestartSec = 1;
  #       TimeoutStopSec = 10;
  #     };
  #   };
  # };
  
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "dvorak";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;

    touchpad.naturalScrolling = true;
    mouse.naturalScrolling = false;
  };

  # Enable bluetooth support
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yucklys = {
    isNormalUser = true;
    extraGroups = [ "wheel"
    		            "networkmanager"
		                "audio"
                    "video"
                    "input"
                    "docker"
                    "dialout"
		              ]; # Enable ‘sudo’ for the user.
    
    # Setting default shell for user
    shell = pkgs.nushell;
  };

  stylix = {
    enable = true;
    image = ./wallpapers/ign_legendary.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
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
        package = pkgs.fira-code;
        name = "Fira Code";
      };
    };
  };

  environment.shells = [pkgs.nushell];
  environment.sessionVariables = {
    FLAKE = "/etc/nixos"; # indicate flake.nix for nh
    NIXOS_OZONE_WL = "1"; # enable ozone for wayland
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Dbus
  services.dbus.enable = true;

  # USB auto mount
  services.udisks2.enable = true;

  # OneDrive
  services.onedrive.enable = true;

  # Enable missing dependencies for hyprpanel
  services.gvfs.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  services.greetd = let
    niri-config = pkgs.writeText "niri-config" ''
hotkey-overlay {
    skip-at-startup
}
input {
    keyboard {
             xkb {
                 layout "us"
                 variant "dvorak"
             }
    } 
}
output "DP-3" {
    off
}
output "HDMI-A-1" {
		off
}
output "eDP-1" {
    scale 1.600000
    transform "normal"
    position x=1080 y=840
}

spawn-at-startup "sh" "-c" "${pkgs.greetd.regreet}/bin/regreet; pkill -f niri"
'';
  in {
    enable = true;
    settings = {
      default_session = {
        command = "niri -c ${niri-config} --session";
        # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time";
        user = "greeter";
      };
    };
  };
  programs.regreet.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    # Sync local tracks with mobile
    allowedTCPPorts = [ 57621 ];
    # Enable discovery of other devices for Spotify
    allowedUDPPorts = [ 5353 5354 ];    
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

