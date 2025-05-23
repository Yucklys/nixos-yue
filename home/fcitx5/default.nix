{ pkgs, ... }:

{
  i18n.inputMethod.enabled = "fcitx5";

  i18n.inputMethod.fcitx5.addons = with pkgs; [
    fcitx5-rime
    fcitx5-gtk
  ];

  stylix.targets.fcitx5.enable = true;
}
