{ ... }:

{
  programs.aerospace = {
    enable = true;
    package = null; # installed via brew cask for stable path (accessibility permissions)
    launchd.enable = false;

    userSettings = {
      start-at-login = true;
      after-login-command = [ ];
      after-startup-command = [ ];

      exec-on-workspace-change = [
        "/bin/bash"
        "-c"
        "sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
      ];

      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;

      accordion-padding = 30;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";

      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
      automatically-unhide-macos-hidden-apps = true;

      key-mapping.preset = "dvorak";

      gaps = {
        inner.horizontal = 8;
        inner.vertical = 8;
        outer.left = 16;
        outer.bottom = 8;
        outer.top = [
          { monitor."34E6UC.*" = 48; }
          { monitor."LS27A600U.*" = 48; }
          { monitor.main = 14; }
          48
        ];
        outer.right = 16;
      };

      mode.main.binding = {
        cmd-ctrl-alt-quote = "layout tiles accordion";
        cmd-ctrl-alt-comma = "layout horizontal vertical";

        # Focus
        cmd-ctrl-alt-d = "focus left";
        cmd-ctrl-alt-h = "focus down";
        cmd-ctrl-alt-t = "focus up";
        cmd-ctrl-alt-n = "focus right";

        # Move
        cmd-ctrl-alt-shift-d = "move left";
        cmd-ctrl-alt-shift-h = "move down";
        cmd-ctrl-alt-shift-t = "move up";
        cmd-ctrl-alt-shift-n = "move right";

        # Resize
        cmd-ctrl-alt-minus = "resize smart -50";
        cmd-ctrl-alt-equal = "resize smart +50";
        cmd-ctrl-alt-z = "balance-sizes";
        cmd-ctrl-alt-m = "fullscreen";
        cmd-ctrl-alt-shift-m = "fullscreen --no-outer-gaps";

        # Monitor focus/move
        cmd-ctrl-alt-a = "focus-monitor 1";
        cmd-ctrl-alt-o = "focus-monitor 2";
        cmd-ctrl-alt-e = "focus-monitor 3";
        cmd-ctrl-alt-shift-a = "move-workspace-to-monitor 1";
        cmd-ctrl-alt-shift-o = "move-workspace-to-monitor 2";
        cmd-ctrl-alt-shift-e = "move-workspace-to-monitor 3";

        # Workspaces
        cmd-ctrl-alt-1 = "summon-workspace 1";
        cmd-ctrl-alt-2 = "summon-workspace 2";
        cmd-ctrl-alt-3 = "summon-workspace 3";
        cmd-ctrl-alt-4 = "summon-workspace 4";
        cmd-ctrl-alt-5 = "summon-workspace 5";

        cmd-ctrl-alt-shift-1 = "move-node-to-workspace 1";
        cmd-ctrl-alt-shift-2 = "move-node-to-workspace 2";
        cmd-ctrl-alt-shift-3 = "move-node-to-workspace 3";
        cmd-ctrl-alt-shift-4 = "move-node-to-workspace 4";
        cmd-ctrl-alt-shift-5 = "move-node-to-workspace 5";

        cmd-ctrl-alt-tab = "exec-and-forget aerospace focus-back-and-forth || aerospace workspace-back-and-forth";
        cmd-ctrl-alt-shift-tab = "workspace-back-and-forth";

        cmd-ctrl-alt-backtick = "focus-monitor --wrap-around next";
        cmd-ctrl-alt-shift-backtick = "focus-monitor --wrap-around prev";

        cmd-ctrl-alt-leftSquareBracket = "workspace --wrap-around prev";
        cmd-ctrl-alt-rightSquareBracket = "workspace --wrap-around next";

        cmd-ctrl-alt-f = "layout floating tiling";

        cmd-ctrl-alt-c = ''exec-and-forget nu "/Users/zkli/Library/Application Support/nushell/scripts/aerospace-cleanup.nu"'';

        cmd-ctrl-alt-shift-semicolon = "mode service";
      };

      mode.service.binding = {
        esc = [ "reload-config" "mode main" ];
        r = [ "flatten-workspace-tree" "mode main" ];
        backspace = [ "close-all-windows-but-current" "mode main" ];

        cmd-ctrl-alt-shift-d = [ "join-with left" "mode main" ];
        cmd-ctrl-alt-shift-h = [ "join-with down" "mode main" ];
        cmd-ctrl-alt-shift-t = [ "join-with up" "mode main" ];
        cmd-ctrl-alt-shift-n = [ "join-with right" "mode main" ];

        down = "volume down";
        up = "volume up";
        shift-down = [ "volume set 0" "mode main" ];
      };
    };

    extraConfig = ''
# Define window configuration
[[on-window-detected]] # VSCode
  if.app-id = "com.microsoft.VSCode"
  if.window-title-regex-substring = ".+"
  run = 'move-node-to-workspace 2'

[[on-window-detected]] # Emacs
  if.app-id = "lsp bridge diagnostic frame"
  run = ['layout floating', 'move-node-to-workspace 1']

[[on-window-detected]] # Emacs
  if.app-id = "org.gnu.Emacs"
  run = 'move-node-to-workspace 2'

[[on-window-detected]] # Emacs ediff
  if.window-title-regex-substring = "Ediff"
  run = 'layout floating'

[[on-window-detected]] # IntelliJ IDEA
  if.app-id = "com.jetbrains.intellij"
  if.window-title-regex-substring = ".+"
  run = 'move-node-to-workspace 2'

[[on-window-detected]] # iTerm2
  if.app-id = "com.googlecode.iterm2"
  if.window-title-regex-substring = ".+"
  check-further-callbacks = true
  run = 'move-node-to-workspace 3'

[[on-window-detected]] # Cisco security client
  if.app-id = "com.cisco.secureclient.gui"
  run = ['layout floating', 'move-node-to-workspace 1']

[[on-window-detected]] # Chime
  if.app-id = "com.amazon.Amazon-Chime"
  if.window-title-regex-substring = ".+"
  run = 'move-node-to-workspace 4'

[[on-window-detected]] # Zoom
  if.app-id = "us.zoom.xos"
  if.window-title-regex-substring = ".+"
  run = 'move-node-to-workspace 4'

[[on-window-detected]] # Ghostty
  if.app-id="com.mitchellh.ghostty"
  run= [
    "layout tiling"
  ]
'';
  };
}
