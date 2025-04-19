{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.adb.enable = true;
  users.users.yucklys.extraGroups = [ "adbusers" ];
}
