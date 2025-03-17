{ config, pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    settings = {
      theme = "nord";
      on_force_close = "detach";
      copy_command = "wl-copy";
    };
  };

  stylix.targets.zellij.enable = false;
}
