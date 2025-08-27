{
  config,
  pkgs,
  inputs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    nodejs
    yarn
    pnpm
    typescript
    nodePackages.typescript-language-server
  ];
}
