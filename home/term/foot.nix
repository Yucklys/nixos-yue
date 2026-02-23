{
  pkgs,
  ...
}:

{
  programs.foot = {
    enable = !pkgs.stdenv.isDarwin;
  };

  stylix.targets.foot.enable = !pkgs.stdenv.isDarwin;
}
