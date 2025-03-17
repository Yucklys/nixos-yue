{ pkgs, ... }:

{
  imports = [
    ./wofi
    ./notification
    ./office.nix
    ./gtk.nix
  ];

  home.sessionVariables = {
    XDG_DATA_HOME = "$HOME/.local/share";
  };

  # Using Hyprcursor
  # Some apps (e.g. GTK) may not use hyprcursor, so fallback to xcursor
  stylix.cursor = {
    name = "Nordzy-cursors-white";
    size = 24;
    package = pkgs.nordzy-cursor-theme;
  };
}
