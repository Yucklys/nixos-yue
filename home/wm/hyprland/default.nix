{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

let
  configDir = "~/.config";
  # XMonad style: focusworkspaceoncurrentmonitor
  focusWorkspaceMethod = "focusworkspaceoncurrentmonitor";
  monitorLeft = "HDMI-A-1";
  monitorRight = "DP-3";
  monitorMain = "eDP-1";
in
{
  imports = [
    ./config.nix
  ];

  home.packages = with pkgs; [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    hyprpaper
    hyprpicker
    pyprland
    hyprkeys
  ];

  stylix.targets.hyprland.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    plugins = with pkgs.hyprlandPlugins; [
      #inputs.hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors
    ];
    xwayland.enable = true;
    settings = {
      debug.disable_logs = false;
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "WLR_NO_HARDWARE_CURSORS,1"
        "HYPRCURSOR_THEME,Nordzy-cursors-white-HYPR"
        "HYPRCURSOR_SIZE,24"
        # Some default env vars.
        "GDK_SCALE,2"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        # GTK applications run on wayland, then x11, then any other GDK backend
        "GDK_BACKEND,wayland,x11,*"
        # SDL2 applications run on wayland by default
        "SDL_VIDEODRIVER,wayland"
        # QT applications run on wayland by default
        "QT_QPA_PLATFORM,wayland;xcb"
        # Force Clutter applications to use wayland
        "CLUTTER_BACKEND,wayland"
        # Set XDG specific DE variables
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"

        # Temporary fix for pixelate font on QT apps
        "QT_SCALE_FACTOR_ROUNDING_POLICY,RoundPreferFloor"
        # Enable wayland for Ozone
        "NIXOS_OZONE_WL,1"

        # Enable wayland for goldendict
        "GOLDENDICT_FORCE_WAYLAND,1"
      ];

      exec-once = [
        "dbus-update-activation-environment --systemd --all"
        "waybar"
        "hyprpaper"
        "goldendict"
        "keyctl link @u @s"
        "pypr"
      ];

      xwayland = {
        force_zero_scaling = true;
      };
      input = {
        kb_layout = "us,us";
        kb_variant = "dvorak,";
        kb_options = "caps:ctrl_modifier";
        follow_mouse = 2;
        natural_scroll = false;
        touchpad.natural_scroll = true;
      };
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        # "col.active_border" = "rgb(81a1c1) rgb(5e81ac) 45deg";
        # "col.inactive_border" = "rgb(2e3440)";
        layout = "dwindle";
        allow_tearing = false;
      };
      decoration = {
        rounding = 0;
        blur = {
          enabled = true;
          size = 10;
          passes = 3;
          new_optimizations = true;
          brightness = 1.0;
          contrast = 1.0;
          noise = 0.02;
        };
      };
      misc = {
        vrr = 1;
        vfr = true;
        close_special_on_empty = true;
        key_press_enables_dpms = true;
        mouse_move_enables_dpms = true;
        enable_swallow = true;
        swallow_regex = "^(ghostty)$";
      };
      animations = {
        enabled = true;
        bezier = "easeInOutCubic, 0.65, 0, 0.35, 1";

        animation = [
          "windows, 1, 6, easeInOutCubic"
          "border, 1, 6, easeInOutCubic"
          "borderangle, 1, 8, easeInOutCubic"
          "fade, 1, 6, easeInOutCubic"
          "workspaces, 1, 6, easeInOutCubic, slidevert"
        ];
      };
      dwindle = {
        default_split_ratio = 1.0;
        smart_split = false;
        special_scale_factor = .9;
      };
      master = {
        mfact = 0.55;
        orientation = "left";
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_distance = 150;
      };
      group = {
        auto_group = true;
        groupbar = {
          font_size = 10;
          gradients = true;
        };
      };
      binds = {
        workspace_back_and_forth = true;
      };

      "$mod" = "SUPER";

      # keybinds
      bind = [
        "$mod, return, exec, ghostty # open terminal"
        "$mod SHIFT, return, exec, ghostty"
        "$mod SHIFT, C, killactive,"
        "$mod SHIFT, Q, exit,"
        "$mod, D, exec, wofi --show drun -w 2"
        "$mod, F2, exec, ${pkgs.rofi-rbw-wayland}/bin/rofi-rbw -a type"
        "$mod SHIFT, F2, exec, ${pkgs.rofi-rbw-wayland}/bin/rofi-rbw -a copy"
        "$mod, Space, fullscreen, 1"
        "$mod SHIFT, Space, fullscreen, 0"
        "$mod, apostrophe, pseudo,"

        "$mod, P, movefocus, u"
        "$mod, N, movefocus, d"
        "$mod, H, movefocus, l"
        "$mod, T, movefocus, r"
        "$mod SHIFT, P, movewindow, u"
        "$mod SHIFT, N, movewindow, d"
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, T, movewindow, r"
        "ALT, Tab, focuscurrentorlast"
        # "$mod, b, scroller:pin,"
        # "$mod SHIFT, b, scroller:unpin,"

        # Workspace
        ''$mod, 1, ${focusWorkspaceMethod}, 1''
        ''$mod, 2, ${focusWorkspaceMethod}, 2''
        ''$mod, 3, ${focusWorkspaceMethod}, 3''
        ''$mod, 4, ${focusWorkspaceMethod}, 4''
        ''$mod, 5, ${focusWorkspaceMethod}, 5''
        ''$mod, 6, ${focusWorkspaceMethod}, 6''
        ''$mod, 7, ${focusWorkspaceMethod}, 7''
        ''$mod, 8, ${focusWorkspaceMethod}, 8''
        ''$mod, 9, ${focusWorkspaceMethod}, 9''
        ''$mod, 0, ${focusWorkspaceMethod}, 0''
        ''$mod SHIFT, 1, movetoworkspace, 1''
        ''$mod SHIFT, 2, movetoworkspace, 2''
        ''$mod SHIFT, 3, movetoworkspace, 3''
        ''$mod SHIFT, 4, movetoworkspace, 4''
        ''$mod SHIFT, 5, movetoworkspace, 5''
        ''$mod SHIFT, 6, movetoworkspace, 6''
        ''$mod SHIFT, 7, movetoworkspace, 7''
        ''$mod SHIFT, 8, movetoworkspace, 8''
        ''$mod SHIFT, 9, movetoworkspace, 9''

        # cycle monitors
        ''$mod ALT, bracketleft, focusmonitor, l''
        ''$mod ALT, bracketright, focusmonitor, r''

        # cycle workspaces
        ''$mod, bracketleft, workspace, m-1''
        ''$mod, bracketright, workspace, m+1''

        # swap windows in two monitors
        ''$mod SHIFT, bracketleft, swapactiveworkspaces, current l''
        ''$mod SHIFT, bracketright, swapactiveworkspaces, current r''

        # special workspace
        ''$mod, 26, togglespecialworkspace'' # 26 is the keycode for the period key
        ''$mod SHIFT, 26, movetoworkspace, special''
        ''$mod, comma, togglespecialworkspace, ncspot''
        ''$mod SHIFT, comma, movetoworkspace, special:ncspot''

        # mouse
        ''$mod, mouse_up, workspace, m+1''
        ''$mod, mouse_down, workspace, m-1''

        # goldendict
        ''$mod, F3, exec, goldendict''
        # clipboard history
        ''$mod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy''
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindle = [
        '', XF86AudioRaiseVolume, exec, wpctl set-volume -l "1.0" @DEFAULT_AUDIO_SINK@ 6%+''
        '', XF86AudioLowerVolume, exec, wpctl set-volume -l "1.0" @DEFAULT_AUDIO_SINK@ 6%-''
        '', XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl -d intel_backlight s 10%+''
        '', XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl -d intel_backlight s 10%-''
      ];

      bindl = [
        # Mute and unmute
        '', XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle''
        '', XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle''
        # Next and previous track
        '', XF86AudioPrev, exec, ${pkgs.spotify-player}/bin/spotify_player playback previous''
        '', XF86AudioNext, exec, ${pkgs.spotify-player}/bin/spotify_player playback next''
      ];

      bindr = [
        # power menu
        ''$mod, escape, exec, pkill wlogout || wlogout -p layer-shell''
        # Play/Pause music
        '', XF86AudioPlay, exec, ${pkgs.spotify-player}/bin/spotify_player playback play-pause''
      ];
    };
  };
}
