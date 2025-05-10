{
  config,
  pkgs,
  lib,
  ...
}:

let
  height = 49;
  wm = "niri";
  workspaces =
    if wm == "hyprland" then
      "hyprland/workspaces"
    else if wm == "niri" then
      "niri/workspaces"
    else
      "";
  window =
    if wm == "hyprland" then
      "hyprland/window"
    else if wm == "niri" then
      "niri/window"
    else
      "";
in
{
  programs.waybar = {
    enable = true;
    # systemd.enable = true; # start waybar with graphical-session.target

    style = lib.mkAfter (builtins.readFile ./style.css);

    settings = [
      {
        layer = "top";
        position = "top";
        height = height;
        output = [ "DP-3" ];
        include = [ "/etc/nixos/home/bar/waybar/default-modules.json" ];
        modules-left = [
          "clock"
          # "hyprland/language"
          "idle_inhibitor"
          workspaces
          window
        ];
        modules-center = [ "mpris" ];
        modules-right = [
          "cpu"
          "temperature"
          "pulseaudio"
          "bluetooth"
          "network"
          "battery"
          "tray"
          "custom/powermenu"
        ];
      }
      {
        layer = "top";
        position = "top";
        height = height;
        output = [ "eDP-1" ];
        include = [ "/etc/nixos/home/bar/waybar/default-modules.json" ];
        modules-left = [
          "clock"
          "idle_inhibitor"
          workspaces
        ];
        modules-right = [
          "cpu"
          "temperature"
          "pulseaudio"
          "bluetooth"
          "network"
        ];
      }
      {
        layer = "top";
        position = "top";
        height = height;
        output = [
          "HDMI-A-1"
        ];
        include = [ "/etc/nixos/home/bar/waybar/default-modules.json" ];
        modules-left = [
          "user"
          workspaces
        ];
        modules-right = [
          "pulseaudio"
          "bluetooth"
          "network"
        ];
      }
    ];
  };

  home.file.nord-waybar-palette = {
    target = ".config/waybar/nord.css";
    source = ./nord.css;
  };

  stylix.targets.waybar.enable = true;
  stylix.targets.waybar.addCss = false;
}
