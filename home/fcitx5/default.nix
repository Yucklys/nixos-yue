{ pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      fcitx5-with-addons = pkgs.kdePackages.fcitx5-with-addons;
      addons = with pkgs; [
        fcitx5-rime
      ];
      waylandFrontend = true;
    };
  };

  stylix.targets.fcitx5.enable = false;
}
