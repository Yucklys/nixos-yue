{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    lxappearance
  ];

  gtk = {
    enable = true;

    # Use stylix instead
    # theme = {
    #   name = "Nordic";
    #   package = pkgs.nordic;
    # };
    iconTheme = {
      name = "Tela-nord-dark";
      package = pkgs.tela-icon-theme;
    };
  };

  # Use pointer cursor as GTK cursor.
  home.pointerCursor.gtk.enable = true;
}
