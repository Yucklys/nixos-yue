{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  imports = [
    ./emacs.nix
    # ./vscode.nix
    ./zed.nix
  ];

  home.sessionVariables = {
    VISUAL = "emacsclient";
  };

  home.packages = with pkgs; [
    pkgs-unstable.copilot-language-server
  ];
}
