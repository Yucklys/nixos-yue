{ config, pkgs, pkgs-unstable, ... }:

let
  ns = pkgs.writeShellScriptBin "ns" (builtins.readFile ../../scripts/nixpkgs.sh);
in {
  environment.systemPackages = [
    pkgs-unstable.nix-search-tv # search nixpkgs
    # scripts
    ns # use fzf for nix-search-tv
  ];
}
