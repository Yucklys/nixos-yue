{
  pkgs,
  inputs,
  ...
}:

{
  home.packages = [
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
  ];

  programs.niri.settings.spawn-at-startup = [
    { command = [ "awww-daemon" ]; }
  ];
}
