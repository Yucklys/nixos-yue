{ pkgs, ... }:

{
  # A lightweight notification daemon for Wayland
  # Now using ags-shell as notification daemon
  services.mako = {
    enable = true;
    anchor = "top-right";
    # backgroundColor = "#2E3440";
    margin = "20,20";
    defaultTimeout = 5000;
  };

  # Periodic rest notification
  home.packages = with pkgs; [
    ianny
  ];

  #   xdg.configFile.ianny = {
  #     enable = true;
  #     target = "io.github.zefr0x.ianny/config.toml";
  #     text = ''
  # [timer]
  # # The timer will stop and rest when you are idle for this amount of seconds
  # idle_timeout = 240
  # # Rest time in seconds
  # short_break_timeout = 1200
  # long_break_timeout = 3600
  # # Breaks duration
  # short_break_duration = 120
  # long_break_duration = 240

  # [notification]
  # show_progress_bar = true
  # # Minimum delay of updating the progress bar (lower than 1s may return an error).
  # minimum_update_delay = 1
  # '';
  #   };
}
