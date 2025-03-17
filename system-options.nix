{ lib, ... }:

{
  options.yue = {
    windowManager = lib.mkOption {
      type = lib.types.enum [ "hyprland" "niri" ];
      default = "hyprland";
      description = "Window manager to use";
    };
  };
}
