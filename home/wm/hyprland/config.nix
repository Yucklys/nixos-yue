{
  config,
  pkgs,
  lib,
  ...
}:

let
  homeDir = config.home.homeDirectory;
  monitorLeft = "HDMI-A-1";
  monitorRight = "DP-3";
  monitorMain = "eDP-1";
  term = "${pkgs.ghostty}/bin/ghostty";
in
{
  wayland.windowManager.hyprland.extraConfig =
    (builtins.readFile ./config.conf)
    + ''
      monitor = ${monitorMain}, preferred, 1080x840, 1.6
      monitor = ${monitorLeft}, preferred, 0x0, 1, transform, 1
      monitor = ${monitorRight}, preferred, 2679x800, 2

      # save clipboard with cliphist
      exec-once = wl-paste --watch cliphist store

      # Workspaces setup
      workspace = 1, monitor:${monitorMain}, default:true
      workspace = 2, monitor:${monitorMain}
      workspace = 3, monitor:${monitorMain}
      workspace = 4, monitor:${monitorLeft}, default:true, gapsout:0
      workspace = 5, monitor:${monitorRight}, default:true, gapsout:0, gapsin:0
      workspace = s[1], gapsin:5

      # Window rules
      windowrulev2 = opacity 0.9 override, title:(qutebrowser), class:(qutebrowser), workspace 6
      windowrulev2 = float, class:(com/xiaoyifang/goldendict-ng.https://github.), title:^(.* - GoldenDict-ng)$
      windowrulev2 = center, class:(com/xiaoyifang/goldendict-ng.https://github.), title:^(.* - GoldenDict-ng)$
      windowrulev2 = size 800 700, class:(com/xiaoyifang/goldendict-ng.https://github.), title:^(.* - GoldenDict-ng)$
      windowrulev2 = float, class:(wlogout)
      windowrulev2 = float, class:(anki), title:^(添加)$
      windowrulev2 = center, class:(anki), title:^(添加)$
      windowrulev2 = float, class:(Vivaldi-stable), title:^(Vivaldi Settings)
      windowrulev2 = size 800 700, class:(Vivaldi-stable), title:^(Vivaldi Settings)

      # Group Emacs frames
      # windowrulev2 = group set, class:(emacs)

      # Make Firefox PiP window floating and sticky
      windowrulev2 = float, title:^(Picture-in-Picture)$
      windowrulev2 = pin, title:^(Picture-in-Picture)$

      # telegram media viewer
      windowrulev2 = float, title:^(Media viewer)$

      # idle inhibit while watching videos
      windowrulev2 = idleinhibit focus, class:^(mpv|.+exe)$
      windowrulev2 = idleinhibit focus, class:^(.*qutebrowser.*)$, title:^(.*YouTube.*)$
      windowrulev2 = idleinhibit focus, class:^(.*qutebrowser.*)$, title:^(.*哔哩哔哩.*)$
      windowrulev2 = idleinhibit fullscreen, class:^(nyxt)$

      # Submaps
      # Applications submap
      bind = $mod, O, submap, app
      submap = app
      bind = , E, exec, ${term} -e yazi
      bind = , E, submap, reset
      bind = SHIFT, E, exec, thunar
      bind = SHIFT, E, submap, reset
      bind = , S, exec, ${term} -e spt
      bind = , S, exec, submap, reset
      bindr=,catchall,submap,reset
      submap = reset

      # Float submap
      bind = $mod, F, submap, float
      submap = float
      bind = , F, togglefloating
      bind = , C, centerwindow
      binde = , P, moveactive, 0 -10
      binde = , N, moveactive, 0 10
      binde = , H, moveactive, -10 0
      binde = , T, moveactive, 10 0
      binde = SHIFT, P, resizeactive, 0 -10
      binde = SHIFT, N, resizeactive, 0 10
      binde = SHIFT, H, resizeactive, -10 0
      binde = SHIFT, T, resizeactive, 10 0
      bind = , M, pin
      bind = , escape, submap, reset
      submap = reset

      # Group submap
      bind = $mod, G, submap, group
      submap = group
      bind = , G, togglegroup
      bind = , P, movefocus, u
      bind = , N, movefocus, d
      bind = , H, movefocus, l
      bind = , T, movefocus, r
      bind = SHIFT, P, moveintogroup, u
      bind = SHIFT, N, moveintogroup, d
      bind = SHIFT, H, moveintogroup, l
      bind = SHIFT, T, moveintogroup, r
      bind = , B, changegroupactive, b
      bind = , F, changegroupactive, f
      bind = SHIFT, B, movegroupwindow, b
      bind = SHIFT, F, movegroupwindow, f
      bind = , D, moveoutofgroup
      bind = , L, lockactivegroup
      bind = ALT, L, lockgroups
      bind = , escape, submap, reset
      submap = reset

      # Emacs submap
      bind = $mod, E, submap, emacs
      submap = emacs
      bind = , E, exec, emacsclient -c
      bind = , E, submap, reset
      bindr=,catchall,submap,reset
      submap = reset

      # Screenshot submap
      bind = , Print, submap, shot
      submap = shot
      bind = , Print, exec, grimblast copy output
      bind = , Print, submap, reset
      bind = , w, exec, grimblast copy active
      bind = , w, submap, reset
      bind = , s, exec, grimblast copy area
      bind = , s, submap, reset
      bind = ALT, Print, exec, grimblast save output - | satty -f -
      bind = ALT, Print, submap, reset
      bind = ALT, w, exec, grimblast save active - | satty -f -
      bind = ALT, w, submap, reset
      bind = ALT, s, exec, grimblast save area - | satty -f -
      bind = ALT, s, submap, reset
      bind = , escape, submap, reset
      submap = reset
    '';

  home.file.pyprland = {
    enable = true;
    target = ".config/hypr/pyprland.toml";
    source = (pkgs.formats.toml { }).generate "pyprland" {
      pyprland.plugins = [
        "expose"
      ];
      expose.include_special = false;
    };
  };
}
