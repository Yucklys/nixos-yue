{ pkgs-unstable, ... }:

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
    ./nix.nix
  ];

  environment.systemPackages = [
    pkgs-unstable.devenv
  ];
}
