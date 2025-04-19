{
  pkgs,
  pkgs-unstable,
  ...
}:

let
  ns = pkgs.writeShellScriptBin "ns" ''
    nix-search-tv print --indexes nixpkgs,nixos,home-manager | fzf --preview 'nix-search-tv preview {}' --scheme history
  '';
in
{
  environment.systemPackages = [
    pkgs-unstable.nix-search-tv # search nixpkgs
    # scripts
    ns # use fzf for nix-search-tv
  ];
}
