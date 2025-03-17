{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    rustup
    cargo-generate
  ];
}
