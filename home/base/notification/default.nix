{ pkgs, ... }:

{
  # A lightweight notification daemon for Wayland
  # Now using ags-shell as notification daemon
  services.mako = {
    enable = true;
    settings = {
      anchor = "top-right";
      # backgroundColor = "#2E3440";
      margin = "20,20";
      default-timeout = 5000;
    };
  };

  # Periodic rest notification
  home.packages = with pkgs; [
    ianny
  ];

  xdg.configFile.ianny = {
    enable = true;
    target = "io.github.zefr0x.ianny/config.toml";
    text = ''
  [timer]
  # Enabling this will only consider user input alone for idle state, e.g. you will not have breaks when watching videos or playing music without any user input.
  ignore_idle_inhibitors = true
  # The timer will stop and rest when you are idle for this amount of seconds
  idle_timeout = 240
  # Rest time in seconds
  short_break_timeout = 1200
  long_break_timeout = 3840
  # Breaks duration
  short_break_duration = 120
  long_break_duration = 240

  [notification]
  show_progress_bar = true
  # Minimum delay of updating the progress bar (lower than 1s may return an error).
  minimum_update_delay = 1
  '';
  };
}
