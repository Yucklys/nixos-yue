{
  pkgs,
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
