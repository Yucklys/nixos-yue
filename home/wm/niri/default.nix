{
  config,
  pkgs,
  inputs,
  ...
}:

let
  terminal = "ghostty";
in
{
  imports = [
    ./swww.nix
  ];

  home.packages = [
    pkgs.xwayland-satellite
    (pkgs.writeShellScriptBin "niri-goto-window" ''nu "${inputs.self}/scripts/niri-goto-window.nu"'')
  ];

  systemd.user.sessionVariables = {
    DISPLAY = ":0";
    WAYLAND_DISPLAY = "wayland-1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "niri";
  };

  programs.niri = {
    package = pkgs.niri-stable;
    settings = {
      # startup programs
      spawn-at-startup = [
        # dbus update environment variables
        {
          command = [
            "sh"
            "-c"
            "sleep 4; systemctl --user restart xdg-desktop-portal"
          ];
        }
        # enable the clipboard history
        {
          command = [
            "wl-paste"
            "--watch"
            "cliphist"
            "store"
          ];
        }
        # show wallpaper
        { command = [ "hyprpaper" ]; }
        # dictionary
        { command = [ "goldendict" ]; }
        # xwayland support
        { command = [ "xwayland-satellite" ]; }
        # restart fcitx5 session to refresh environment variables
        { command = [ "fcitx5" "-d"]; }
        { command = [ "waybar" ]; }
      ];

      environment = {
        # xwayland-satellite will use Display 0 to run X11 applications
        DISPLAY = ":0";
        # GTK applications run on wayland, then x11, then any other GDK backend
        # GDK_BACKEND = "wayland,x11,*";
        # SDL2 applications run on wayland by default
        SDL_VIDEODRIVER = "wayland";
        # QT applications run on wayland by default
        QT_QPA_PLATFORM = "wayland;xcb";
        # Force Clutter applications to use wayland
        CLUTTER_BACKEND = "wayland";
        XDG_SESSION_TYPE = "wayland";
        NIXOS_OZONE_WL = "1";
        # force goldendict to use wayland
        GOLDENDICT_FORCE_WAYLAND = "1";
      };

      # change path to store screenshots
      # screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

      input = {
        keyboard.xkb = {
          layout = "us";
          variant = "dvorak";
          options = "caps:ctrl_modifier";
        };

        touchpad = {
          # disable while typing
          dwt = true;
          scroll-method = "two-finger";
        };

        # make the mouse warp to the center of newly focused windows
        warp-mouse-to-focus.enable = true;
      };

      outputs = {
        # main monitor
        eDP-1 = {
          enable = true;
          position = {
            x = 1080;
            y = 840;
          };
          scale = 1.6;
        };

        # horizontal monitor on the right
        HDMI-A-1 = {
          enable = true;
          mode = {
            height = 1440;
            width = 3440;
            refresh = 100.0;
          };
          position = {
            x = 2680;
            y = 800;
          };
          scale = 1;
          focus-at-startup = true;
        };
      };

      cursor.hide-when-typing = true;
      cursor.hide-after-inactive-ms = 10000;

      layout = {
        gaps = 16;
        # When to center a column when changing focus, options are:
        # - "never", default behavior, focusing an off-screen column will keep at the left
        #   or right edge of the screen.
        # - "always", the focused column will always be centered.
        # - "on-overflow", focusing a column will center it if it doesn't fit
        #   together with the previously focused column.
        center-focused-column = "never";

        preset-column-widths = [
          { proportion = 1. / 3.; }
          { proportion = 1. / 2.; }
          { proportion = 2. / 3.; }
        ];

        preset-window-heights = [
          { proportion = 1. / 2.; }
          { proportion = 1.; }
        ];

        focus-ring = {
          enable = true;
          width = 4;

          # Let stylix to manage the focus ring style
        };

        border = {
          enable = false;
        };

        shadow = {
          enable = true;
          # draw the shadow behind the window, requires `prefer-no-csd = true;`
          draw-behind-window = true;
        };

        tab-indicator = {
          hide-when-single-tab = true;
          position = "left";
        };

        # similar to outer gaps.
        struts = {
          left = 32;
          right = 32;
        };
      };

      # disable clint side decoration
      prefer-no-csd = true;

      # window rules for some applications
      window-rules = [
        # highlight the window that is screencasting with red border
        {
          matches = [ { is-window-cast-target = true; } ];

          focus-ring = {
            active = {
              color = "#f38ba8";
            };
            inactive = {
              color = "#7d0d2d";
            };
          };

          shadow = {
            color = "#7d0d2d70";
          };

          tab-indicator = {
            active = {
              color = "#f38ba8";
            };
            inactive = {
              color = "#7d0d2d";
            };
          };
        }
        {
          # goldendict is a centered and floating window
          matches = [ { app-id = "com/xiaoyifang/goldendict-ng.https://github."; } ];
          open-floating = true;

          default-column-width = {
            fixed = 500;
          };
          default-window-height = {
            fixed = 500;
          };
        }
        {
          # general popups
          matches = [
            { title = "Open Folder"; } # zed editor file picker
            { title = "Open File"; } # file picker
            { title = "Save File"; } # file picker
          ];
          open-floating = true;
        }
      ];

      # bindings
      binds =
        with config.lib.niri.actions;
        let
          sh = spawn "sh" "-c";
        in
        {
          "Mod+Shift+Slash".action = show-hotkey-overlay;

          "Mod+Return".action = spawn terminal;
          "Mod+D".action = spawn "wofi" "--show" "drun";
          "Super+Alt+L".action = spawn "hyprlock";

          # media control
          "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
          "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
          "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
          "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          "XF86AudioPlay".action = spawn "playerctl" "play-pause";
          "XF86AudioNext".action = spawn "playerctl" "next";
          "XF86AudioPrev".action = spawn "playerctl" "previous";
          "XF86MonBrightnessUp".action = spawn "brightnessctl" "-d" "intel_backlight" "set" "5%+";
          "XF86MonBrightnessDown".action = spawn "brightnessctl" "-d" "intel_backlight" "set" "5%-";

          # window management
          "Mod+Shift+C".action = close-window;
          "Mod+Left".action = focus-column-or-monitor-left;
          "Mod+Right".action = focus-column-or-monitor-right;
          "Mod+Down".action = focus-window-or-monitor-down;
          "Mod+Up".action = focus-window-or-monitor-up;
          "Mod+H".action = focus-column-or-monitor-left;
          "Mod+S".action = focus-column-or-monitor-right;
          "Mod+N".action = focus-window-or-monitor-down;
          "Mod+T".action = focus-window-or-monitor-up;

          "Mod+Shift+Left".action = move-column-left-or-to-monitor-left;
          "Mod+Shift+Right".action = move-column-right-or-to-monitor-right;
          "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
          "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;
          "Mod+Shift+H".action = move-column-left-or-to-monitor-left;
          "Mod+Shift+S".action = move-column-right-or-to-monitor-right;
          "Mod+Shift+N".action = move-window-down-or-to-workspace-down;
          "Mod+Shift+T".action = move-window-up-or-to-workspace-up;

          "Mod+Home".action = focus-column-first;
          "Mod+End".action = focus-column-last;
          "Mod+Shift+Home".action = move-column-to-first;
          "Mod+Shift+End".action = move-column-to-last;

          "Mod+Ctrl+Left".action = focus-monitor-left;
          "Mod+Ctrl+Right".action = focus-monitor-right;
          "Mod+Ctrl+Down".action = focus-monitor-down;
          "Mod+Ctrl+Up".action = focus-monitor-up;
          "Mod+Ctrl+H".action = focus-monitor-left;
          "Mod+Ctrl+S".action = focus-monitor-right;
          "Mod+Ctrl+N".action = focus-monitor-down;
          "Mod+Ctrl+T".action = focus-monitor-up;

          # use wofi to select a window
          "Mod+O".action = spawn "niri-goto-window";

          "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
          "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
          "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
          "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
          "Mod+Shift+Ctrl+S".action = move-column-to-monitor-right;
          "Mod+Shift+Ctrl+N".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+T".action = move-column-to-monitor-up;

          "Mod+Page_Down".action = focus-workspace-down;
          "Mod+Page_Up".action = focus-workspace-up;
          "Mod+V".action = focus-workspace-down;
          "Mod+W".action = focus-workspace-up;
          "Mod+Shift+Page_Down".action = move-column-to-workspace-down;
          "Mod+Shift+Page_Up".action = move-column-to-workspace-up;
          "Mod+Shift+V".action = move-column-to-workspace-down;
          "Mod+Shift+W".action = move-column-to-workspace-up;

          "Mod+WheelScrollDown" = {
            cooldown-ms = 150;
            action = focus-workspace-down;
          };
          "Mod+WheelScrollUp" = {
            cooldown-ms = 150;
            action = focus-workspace-up;
          };
          "Mod+Ctrl+WheelScrollDown" = {
            cooldown-ms = 150;
            action = move-column-to-workspace-down;
          };
          "Mod+Ctrl+WheelScrollUp" = {
            cooldown-ms = 150;
            action = move-column-to-workspace-up;
          };

          "Mod+WheelScrollRight".action = focus-column-right;
          "Mod+WheelScrollLeft".action = focus-column-left;
          "Mod+Shift+WheelScrollRight".action = move-column-right;
          "Mod+Shift+WheelScrollLeft".action = move-column-left;

          # replace horizontal scrolling by shift+wheelup/wheeldown
          "Mod+Shift+WheelScrollDown".action = focus-column-right;
          "Mod+Shift+WheelScrollUp".action = focus-column-left;
          "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
          "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;

          # touchpad gestures
          # with natrual scrolling enabled, the scroll direction is reversed
          "Mod+TouchpadScrollDown".action = focus-workspace-up;
          "Mod+TouchpadScrollUp".action = focus-workspace-down;
          "Mod+TouchpadScrollRight".action = focus-column-left;
          "Mod+TouchpadScrollLeft".action = focus-column-right;

          # workspace management
          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+5".action = focus-workspace 5;
          "Mod+6".action = focus-workspace 6;
          "Mod+7".action = focus-workspace 7;
          "Mod+8".action = focus-workspace 8;
          "Mod+9".action = focus-workspace 9;
          "Mod+Shift+1".action.move-column-to-workspace =  1;
          "Mod+Shift+2".action.move-column-to-workspace =  2;
          "Mod+Shift+3".action.move-column-to-workspace =  3;
          "Mod+Shift+4".action.move-column-to-workspace =  4;
          "Mod+Shift+5".action.move-column-to-workspace =  5;
          "Mod+Shift+6".action.move-column-to-workspace =  6;
          "Mod+Shift+7".action.move-column-to-workspace =  7;
          "Mod+Shift+8".action.move-column-to-workspace =  8;
          "Mod+Shift+9".action.move-column-to-workspace =  9;
          "Mod+Tab".action = focus-workspace-previous;

          "Mod+BracketLeft".action = consume-or-expel-window-left;
          "Mod+BracketRight".action = consume-or-expel-window-right;
          "Mod+Comma".action = consume-window-into-column;
          "Mod+Period".action = expel-window-from-column;
          "Mod+Semicolon".action = toggle-column-tabbed-display;

          "Mod+R".action = switch-preset-column-width;
          "Mod+Shift+R".action = switch-preset-window-height;
          "Mod+Ctrl+R".action = reset-window-height;
          "Mod+F".action = maximize-column;
          "Mod+Shift+F".action = fullscreen-window;
          "Mod+J".action = center-column;

          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Equal".action = set-column-width "+10%";

          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Equal".action = set-window-height "+10%";

          "Mod+Apostrophe".action = switch-focus-between-floating-and-tiling;
          "Mod+Ctrl+Apostrophe".action = toggle-window-floating;

          # switch layouts
          "Mod+Space".action = switch-layout "next";
          "Mod+Shift+Space".action = switch-layout "prev";

          # screenshot & screencast
          "Print".action.screenshot = [];
          "Ctrl+Print".action.screenshot-screen = [];
          # "Ctrl+Print".action = screenshot-screen;
          "Alt+Print".action.screenshot-window = [];

          # Applications
          # emacs shortcuts
          "Mod+E".action = spawn "emacsclient" "-c";
          # yazi file manager
          "Mod+Ctrl+E".action = spawn "ghostty" "-e" "yazi";
          # goldendict
          "Mod+G".action = spawn "goldendict";
          # wallpaper
          # "Mod+B".action = spawn ""
          # cliphist
          "Mod+P".action = sh "cliphist list | wofi -S dmenu | cliphist decode | wl-copy";
          # bitwarden
          "Mod+B".action = spawn "rofi-rbw";
          # pass store
          "Mod+Ctrl+B".action = spawn "wofi-pass";

          # quit Niri
          "Mod+Shift+Q".action = quit;
          "Ctrl+Alt+Delete".action = quit;
          "Mod+Shift+P".action = power-off-monitors;
        };
    };
  };
}
