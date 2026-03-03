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
bind s split-window
bind v split-window -h
bind C-a send-keys C-a

# switch panes using Alt-arrow without prefix
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# reload config with R
bind R source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded"

# THEME
setw -g clock-mode-colour yellow

set-option -g status "on"
set-option -g status-justify "left"
set-option -g status-left "#[fg=#b8c6d5,bg=#4a4f62] #S #[fg=#4a4f62,bg=#1d202f,nobold,noitalics,nounderscore]"
set-option -g status-left-length "80"
set-option -g status-left-style none
set-option -g status-right "#[fg=#2a2f42,bg=#1d202f nobold, nounderscore, noitalics]#[fg=#807c9f,bg=#2a2f42] %Y-%m-%d  %H:%M #[fg=#b8c6d5,bg=#2a2f42,nobold,noitalics,nounderscore]#[fg=#1d202f,bg=#b8c6d5] #h "
set-option -g status-right-length "80"
set-option -g status-right-style none
set-window-option -g window-status-current-format "#[fg=#1d202f,bg=#d1803f,nobold,noitalics,nounderscore]#[fg=#2a2f42,bg=#d1803f] #I #[fg=#2a2f42,bg=#d1803f,bold] #W#{?window_zoomed_flag,*Z,} #[fg=#d1803f,bg=#1d202f,nobold,noitalics,nounderscore]"
set-window-option -g window-status-format "#[fg=#1d202f,bg=#2a2f42,noitalics]#[fg=#dedeff,bg=#2a2f42] #I #[fg=#dedeff,bg=#2a2f42] #W#{?window_zoomed_flag,*Z,} #[fg=#2a2f42,bg=#1d202f,noitalics]"
set-window-option -g window-status-separator ""
'';
  };
}
