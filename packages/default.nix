{ config, lib, pkgs, ... }:

{
  imports = [
    ./system.nix
    
    ./options/android.nix
  ];
}
