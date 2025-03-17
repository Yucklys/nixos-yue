{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs
    yarn
    typescript
    nodePackages.typescript-language-server
  ];
}
