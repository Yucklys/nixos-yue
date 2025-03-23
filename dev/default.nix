{ config, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./rust.nix
    ./python.nix
    ./js.nix
    ./r.nix
    ./java.nix
    # ./dafny.nix
    # ./haskell.nix
    ./lua.nix
  ];

  environment.systemPackages = with pkgs; [
    pkgs-unstable.devenv
  ];
}
