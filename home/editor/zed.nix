{ config, pkgs, pkgs-unstable, lib, ... }:

{
  programs.zed-editor = {
    enable = true;
    package = pkgs-unstable.zed-editor;

    extensions = ["nix" "toml"];

    userSettings = {
      load_direnv = "direct";
      base_keymap = "Emacs";
      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };
      assistant = {
        enabled = true;
        default_model = {
          provider = "zed.dev";
          model = "claude-3-7-sonnet";
        };
      };
      buffer_font_family = "Maple Mono";
    };
  };
}
