{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:

{
  programs.zed-editor = {
    enable = true;
    package = pkgs-unstable.zed-editor;

    extensions = [
      "nix"
      "toml"
      "dockerfile"
      "make"
      "justfile"
    ];

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
          model = "claude-3-7-sonnet-latest";
        };
      };
      edit_predictions.disabled_globs = [
        "**/.env*"
        "**/*.pem"
        "**/*.key"
        "**/*.cert"
        "**/*.crt"
        "**/.dev.vars"
        "**/secrets.yml"
      ];

      # settings for vim mode
      vim_mode = true;
      vim = {
        default_mode = "helix_normal";
        toggle_relative_line_numbers = true;
      };
      relative_line_numbers = true;
    };
  };
}
