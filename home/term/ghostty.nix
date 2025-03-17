{ config, lib, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      window-decoration = "auto";
      keybind = [
        # split controls
        "ctrl+a>h=new_split:right"
        "ctrl+a>v=new_split:down"
        
        "ctrl+h=goto_split:left"
        "ctrl+s=goto_split:right"

        "ctrl+a>z=toggle_split_zoom"
        "ctrl+shift+left=resize_split:left,10"
        "ctrl+shift+right=resize_split:right,10"
        "ctrl+shift+down=resize_split:down,10"
        "ctrl+shift+up=resize_split:up,10"

        "ctrl+a>shift+z=equalize_splits"

        # tab controls
        "ctrl+t=next_tab"
        "ctrl+n=previous_tab"
        "ctrl+a>c=new_tab"
        "ctrl+a>1=goto_tab:1"
        "ctrl+a>2=goto_tab:2"
        "ctrl+a>3=goto_tab:3"
        "ctrl+a>4=goto_tab:4"
        "ctrl+a>5=goto_tab:5"
        "ctrl+a>6=goto_tab:6"
        "ctrl+a>7=goto_tab:7"
        "ctrl+a>8=goto_tab:8"
        "ctrl+a>9=goto_tab:9"
        "ctrl+a>0=goto_tab:10"
        "ctrl+tab=toggle_tab_overview"
      ];
    };
  };
}
