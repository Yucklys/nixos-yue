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
    ];

    extraConfig = ''
set -g mouse on
# use - and \ to split horizontally and vertically
unbind %
unbind '"'
bind v split-window
bind s split-window -h
bind C-a start-of-line

# reload config with R
bind R source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded"
'';
  };
}
