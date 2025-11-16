{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    shortcut = "a";
    disableConfirmationPrompt = true;
    newSession = true;
    customPaneNavigationAndResize = true;
    sensibleOnTop = true;

    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
set -g @catppuccin_flavor "mocha"
set -g @catppuccin_window_status_style "slanted"
'';
      }
    ];

    extraConfig = ''
# use - and \ to split horizontally and vertically
unbind %
unbind '"'
bind - split-window
bind '\' split-window -h

# reload config with R
bind R source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded"
'';
  };
}
