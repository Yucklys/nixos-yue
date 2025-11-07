{
  pkgs,
  inputs,
  ...
}:

{
  home.packages = [
    inputs.swww.packages.${pkgs.system}.swww
  ];

  programs.niri.settings.spawn-at-startup = [
    { command = [ "swww-daemon" ]; }
  ];
}
