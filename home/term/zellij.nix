{ config, pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    settings = {
      theme = "nord";
      on_force_close = "detach";
      copy_command = if pkgs.stdenv.isDarwin then "pbcopy" else "wl-copy";
    };
  };

  stylix.targets.zellij.enable = false;
}
