{ config, pkgs-unstable, ... }:

{
  programs.zed-editor = {
    enable = true;
    package = pkgs-unstable.zed-editor;

    userSettings = {
      inactive_opacity = 0.9;
      base_keymap = "Emacs";
      buffer_font_family = "Maple Mono";
    };
  };
}
