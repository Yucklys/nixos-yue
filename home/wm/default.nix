{ config, lib, ... }:

let
  wm = "niri";
in {
  imports = [
    (./. + "/${wm}/default.nix")
  ];

  # Common packages for all window managers
  # Wallpaper manager
  services.hyprpaper = {
    enable = if wm == "hyprland" then true else false;
    settings = {
      preload = [
        "/etc/nixos/wallpapers/pixelcity.png"
        "/etc/nixos/wallpapers/nixos-rainbow.png"
        "/etc/nixos/wallpapers/nixos.png"
        "/etc/nixos/wallpapers/ign_legendary.png"
      ];

      wallpaper = [
        "eDP-1, /etc/nixos/wallpapers/ign_legendary.png"
        "HDMI-A-1, /etc/nixos/wallpapers/cat-waves.png"
        "DP-3, /etc/nixos/wallpapers/pixelcity.png"
      ];

      # enable splash text over the wallpaper
      splash = true;

      # disable ipc as I don't use it
      ipc = false;
    };
  };

  # Hyprland screen locker
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        grace = 5; # number of seconds to unlock without password
        ignore_empty_input = true;
      };

      background = {
        path = lib.mkForce "screenshot";
        blur_passes = 3;
        blur_size = 7;
        vibrancy = 0.2;
      };

      input-field = {
        monitor = "eDP-1";
        size = "200, 50";
        position = "0, -80";
        dots_center = true;
        fade_on_empty = false;
        # font_color = "rgb(202, 211, 245)";
        # inner_color = "rgb(91, 96, 120)";
        # outer_color = "rgb(24, 25, 38)";
        outline_thickness = 5;
        placeholder_text = "Password...";
        shadow_passes = 2;
      };
    };
  };

  # System idle manager
  services.hypridle = let
    hyprland-settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
    niri-settings = {
      general = {
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "niri msg action power-off-monitors";
        lock_cmd = "pidof hyprlock || hyprlock";
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = "niri msg action power-off-monitors";
          on-resume = "niri msg action power-on-monitors";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];      
    };
  in {
    enable = true;
    settings = if wm == "hyprland" then hyprland-settings
               else if wm == "niri" then niri-settings
               else {};
  };
}
