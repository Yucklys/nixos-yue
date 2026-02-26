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

    userKeymaps = [
      # Dvorak movement: d=left, h=down, t=up, n=right
      {
        context = "VimControl && !menu";
        bindings = {
          d = "vim::Left";
          h = "vim::Down";
          t = "vim::Up";
          n = "vim::Right";
          # remap displaced keys
          l = "vim::FindTill";
          shift-l = "vim::FindTillPrevious";
          k = "vim::DeleteRight"; # delete_selection -> use x/d behavior
        };
      }
      # normal mode specific
      {
        context = "vim_mode == normal && !menu";
        bindings = {
          k = "editor::Delete"; # delete selection
          "alt-k" = ["workspace::SendKeystrokes" "\" _ x"]; # delete no yank
          "g d" = "vim::StartOfLine";
          "g n" = "vim::EndOfLine";
          "g l" = "vim::WindowTop";
          "g h" = ["workspace::SendKeystrokes" "shift-j"]; # move_line_down (join)
          "g t" = ["workspace::SendKeystrokes" "shift-k"]; # move_line_up
          "g j" = "editor::GoToDefinition";
          "g k" = "pane::ActivateNextItem"; # goto_next_buffer
          "z h" = "vim::ScrollDown";
          "z t" = "vim::ScrollUp";
          # window/pane navigation
          "w d" = "workspace::ActivatePaneLeft";
          "w h" = "workspace::ActivatePaneDown";
          "w t" = "workspace::ActivatePaneUp";
          "w n" = "workspace::ActivatePaneRight";
          "w shift-d" = "workspace::SwapPaneLeft";
          "w shift-h" = "workspace::SwapPaneDown";
          "w shift-t" = "workspace::SwapPaneUp";
          "w shift-n" = "workspace::SwapPaneRight";
        };
      }
      # visual mode
      {
        context = "vim_mode == visual && !menu";
        bindings = {
          k = "editor::Delete";
          "alt-k" = ["workspace::SendKeystrokes" "\" _ d"];
        };
      }
      # insert mode
      {
        context = "vim_mode == insert";
        bindings = {
          "ctrl-t" = "editor::DeleteToEndOfLine";
          "ctrl-h" = "editor::Newline";
        };
      }
    ];

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
      agent = {
        enabled = true;
        default_model = {
          provider = "zed.dev";
          model = "claude-4-5-sonnet-latest";
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

      # settings for helix mode
      vim_mode = false;
      helix_mode = true;
      relative_line_numbers = "enabled";

      # disable collecting telemetry
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      # add kiro agent
      agent_servers = {
        "kiro" = {
          type = "custom";
          command = "kiro-cli";
          args = ["acp"];
          env = {};
        };
      };
    };
  };
}
