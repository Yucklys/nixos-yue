{ config, pkgs, ... }:

{
  imports = [
    ./emacs.nix
    # ./vscode.nix
    ./zed.nix
  ];

  home.sessionVariables = {
    VISUAL = "emacsclient";
  };
}
