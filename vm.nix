{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    liveRestore = false;
  };
}
